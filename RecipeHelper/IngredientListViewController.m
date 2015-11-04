//
//  IngredientListViewController.m
//  RecipeHelper
//
//  Created by emdog4 on 7/26/14.
//  Copyright (c) 2014 Emery Clark. All rights reserved.
//

#import "IngredientListViewController.h"
#import "IngredientDetailViewController.h"
#import "IngredientNutritionInfoViewController.h"

#import "RecipeListViewController.h"
#import "RecipeDetailViewController.h"
#import "Ingredient.h"
#import "DataManager.h"

@interface IngredientListViewController ()
{
    NSManagedObjectContext *_context;
    UITableView *_searchResultsTableView;
    UINavigationBar *_navBar;
    UINavigationItem *_navItem;
}
@end

@implementation IngredientListViewController

static NSString *ReuseableTableViewCellId = @"ReuseableTableViewCellId";

- (instancetype)init
{
    if (self = [super init])
    {
        self.title = @"Ingredient List VC";

        _foods = @[@"Ahipa", @"Amaranth", @"American groundnut", @"Aonori", @"Arame", @"Arracacha", @"Artichoke", @"Arugula", @"Asparagus", @"Avocado", @"Azuki bean", @"Bamboo shoot", @"Beet greens", @"Beetroot", @"Bell pepper", @"Bitter gourd", @"Bitter melon", @"Black-eyed pea", @"Bok choy (白菜)", @"Borage greens", @"Broadleaf arrowhead", @"Broccoli", @"Broccolini (leaves / stalks)", @"Broccolini flowers", @"Brussels sprout", @"Bulb and stem vegetables", @"Burdock", @"Cabbage", @"Camas", @"Canna", @"Caper", @"Cardoon", @"Carola", @"Carrot", @"Cassava", @"Catsear", @"Cauliflower", @"Celeriac", @"Celery", @"Celery", @"Celtuce", @"Chaya", @"Chayote", @"Chickpea", @"Chickweed", @"Chicory", @"Chinese artichoke", @"Chinese mallow", @"Chives", @"Chrysanthemum (leaves)", @"Collard greens", @"Common bean", @"Common purslane", @"Corn salad", @"Courgette flowers", @"Cress", @"Cucumber", @"Dabberlocks (Badderlocks)", @"Daikon", @"Dandelion", @"Daylily", @"Dill", @"Dolichos bean", @"Drumstick", @"Dulse ", @"Earthnut pea", @"Eggplant ", @"Elephant foot yam", @"Elephant garlic", @"Endive", @"Ensete", @"Fat hen", @"Fava bean", @"Fiddlehead", @"Florence fennel", @"Flowers and flower buds", @"Fluted pumpkin", @"Fruits", @"Galangal", @"Garbanzo", @"Garden rocket", @"Garlic", @"Garlic chives", @"Ginger", @"Golden samphire", @"Good King Henry", @"Greater plantain", @"Green bean", @"Guar", @"Hamburg parsley", @"Hijiki", @"Horse gram", @"Horseradish", @"Indian pea", @"Ivy gourd", @"Jerusalem artichoke", @"Jícama", @"Kai-lan (芥蘭 Gai lan)", @"Kale", @"Kohlrabi", @"Komatsuna", @"Kombu", @"Kuka", @"Kurrat", @"Lagos bologi", @"Lamb's lettuce", @"Lamb's quarters", @"Land cress", @"Laver / Gim", @"Leafy and salad vegetables", @"Leek", @"Lemongrass", @"Lentil", @"Lettuce", @"Lima bean", @"Lizard's tail", @"Lotus root", @"Luffa", @"Malabar spinach", @"Mashua", @"Melokhia", @"Miner's lettuce (Winter purslane)", @"Mizuna greens", @"Moth bean", @"Mozuku", @"Mung bean", @"Mustard", @"Napa cabbage (召菜 Siu choi)", @"New Zealand Spinach", @"Nopal", @"Nori", @"Ogonori", @"Okra", @"Olive fruit", @"Onion", @"Orache", @"Pak choy (白菜 Bok choy)", @"Paracress", @"Parsnip", @"Pea", @"Pea sprouts / leaves", @"Peanut", @"Pearl onion", @"Pigeon pea", @"Pignut", @"Podded vegetables", @"Poke", @"Potato", @"Potato onion", @"Prairie turnip", @"Prussian asparagus", @"Pumpkin", @"Radicchio", @"Radish", @"Rapini (broccoli rabe)", @"Ricebean", @"Root and tuberous vegetables", @"Runner bean", @"Rutabaga", @"Salsify", @"Samphire", @"Scorzonera", @"Sculpit / Stridolo", @"Sea beet", @"Sea grape", @"Sea kale", @"Sea lettuce", @"Sea vegetables", @"Shallot", @"Sierra Leone bologi", @"Skirret", @"Snap pea", @"Snow pea", @"Soko", @"Sorrel", @"Soybean", @"Spinach", @"Spring onion / Scallion", @"Squash", @"Squash blossoms", @"Summer purslane", @"Swede", @"Sweet pepper", @"Sweet potato (Kumara)", @"Swiss chard", @"Taro", @"Tarwi (Tarhui / Chocho)", @"Tatsoi", @"Tepary bean", @"Ti", @"Tigernut", @"Tinda", @"Tomatillo", @"Tomato", @"Tree onion[3]", @"Turmeric", @"Turnip", @"Turnip greens", @"Ulluco", @"Urad bean", @"Vanilla", @"Velvet bean", @"Wakame", @"Wasabi", @"Water caltrop", @"Water chestnut", @"Water spinach", @"Watercress", @"Welsh onion", @"West Indian gherkin", @"Wheatgrass", @"Wild leek", @"Winged bean", @"Winter melon", @"Yacón", @"Yam", @"Yao choy (油菜 Yu choy)", @"Yardlong bean", @"Yarrow", @"Zucchini / Courgette"];
        
        _values = [NSMutableArray new];
        
        NSInteger count = 0;
        
        while (count < [_foods count])
        {
            [_values addObject:[NSNumber numberWithBool:NO]];
            count++;
        }
        
        _dataAllDictionary = [[NSMutableDictionary alloc] initWithObjects:_values forKeys:_foods];
        _dataAllKeys = [[_dataAllDictionary allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        _dataSearchedKeys = [NSMutableArray new];
        
    }
    return self;
}

- (void)loadView
{
    self.view = [[UIView alloc] init];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    _mainTableView = [[UITableView alloc] init];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    _navBar = [[UINavigationBar alloc] init];
    _navBar.translatesAutoresizingMaskIntoConstraints = NO;
    
    _navItem = [[UINavigationItem alloc] init];
    _navItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addIngredient:)];
    _navItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
    
    [_navBar pushNavigationItem:_navItem animated:YES];
    
    UITableViewController *searchResultsTableVC = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    
    _searchController = [[UISearchController alloc] initWithSearchResultsController:searchResultsTableVC];
    
    _searchResultsTableView = ((UITableViewController *)_searchController.searchResultsController).tableView;
    _searchResultsTableView.delegate = self;
    _searchResultsTableView.dataSource = self;
    
    _searchController.searchResultsUpdater = self;
    _searchController.delegate = self;

    _searchController.searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _searchController.searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    [_searchController.searchBar sizeToFit];
    
    [_mainTableView registerClass:UITableViewCell.class forCellReuseIdentifier:ReuseableTableViewCellId];
    [_searchResultsTableView registerClass:UITableViewCell.class forCellReuseIdentifier:ReuseableTableViewCellId];
    
    _mainTableView.tableHeaderView = _searchController.searchBar;
    
    [self.view addSubview:_navBar];
    [self.view addSubview:_mainTableView];
    
    id _topLayoutGuide = self.topLayoutGuide;
    
    NSMutableArray *constraints = [NSMutableArray array];
    NSDictionary *_bindings = NSDictionaryOfVariableBindings(_mainTableView, _navBar, _topLayoutGuide);
    
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_topLayoutGuide][_navBar][_mainTableView]|" options:0 metrics:nil views:_bindings]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_navBar]|" options:0 metrics:nil views:_bindings]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_mainTableView]|" options:0 metrics:nil views:_bindings]];
    
    [self.view addConstraints:constraints];
}


#pragma mark - Search Results Updating
#pragma mark

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *searchText = searchController.searchBar.text;

    _dataSearchedKeys = [NSArray new];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@", searchText];
    
    _dataSearchedKeys = [_dataAllKeys filteredArrayUsingPredicate:predicate];
    
    [_searchResultsTableView reloadData];
}

#pragma mark - Search Controller Delegate
#pragma mark

- (void)willPresentSearchController:(UISearchController *)searchController
{
    ///
}

- (void)willDismissSearchController:(UISearchController *)searchController
{
    ///
}

#pragma mark - Search Bar Delegate
#pragma mark

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    
}

#pragma mark - TableView datasource
#pragma mark

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ((tableView == _searchResultsTableView) ? [_dataSearchedKeys count] : [_dataAllKeys count]);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *_datasource = ((tableView == _searchResultsTableView) ? _dataSearchedKeys : _dataAllKeys);
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseableTableViewCellId forIndexPath:indexPath];
    
    cell.textLabel.text = [_datasource objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

#pragma mark - TableView delegate
#pragma mark

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    IngredientDetailViewController *_ingredientDetailVC = [[IngredientDetailViewController alloc] init];
    
    _ingredientDetailVC.modalPresentationStyle = UIModalPresentationFormSheet;
    
    [self.splitViewController presentViewController:_ingredientDetailVC animated:YES completion:nil];
}

#pragma mark - Private Methods
#pragma mark

-(BOOL)boolValueForKeyInTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    NSArray *keys = ((tableView == _searchResultsTableView) ? _dataSearchedKeys : _dataAllKeys);
    
    return [_dataAllDictionary valueForKey:[keys objectAtIndex:indexPath.row]];
}

- (void)cancel:(UIBarButtonItem *)sender
{
    UISplitViewController *_splitVC = self.splitViewController;

    RecipeListViewController *_recipeListVC = [[RecipeListViewController alloc] init];
    
    [_splitVC showViewController:_recipeListVC sender:self];
}

- (void)addIngredient:(UIBarButtonItem *)sender
{
    IngredientDetailViewController *ingredientDetailVC = [[IngredientDetailViewController alloc] init];
    
    [self.navigationController showViewController:ingredientDetailVC sender:self];
}

-(void)random:(UIBarButtonItem *)sender
{
    ///
}

@end

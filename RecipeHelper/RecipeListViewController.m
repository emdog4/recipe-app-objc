//
//  RecipeListViewController.m
//  ReceipePro
//
//  Created by Emery Clark on 7/7/13.
//  Copyright (c) 2013 Emery Clark. All rights reserved.
//

#import "RecipeListViewController.h"

#import "RecipeDetailViewController.h"
#import "EmptyRecipeViewController.h"

#import "RecipeListTableViewCell.h"
#import "RecipeTextViewController.h"

#import "Models.h"


@interface RecipeListViewController ()
{
    UISearchController *_searchController;
    
    UITableView *_searchResultsTableView;
    UITableView *_mainTableView;

    NSArray *_dataAllRecipes;
    NSArray *_dataSearchedRecipes;
    
    NSManagedObjectContext *_context;
    
    RecipeTextViewController *_recipeTextVC;
    
    UINavigationBar *_navBar;
    UINavigationItem *_navItem;
}
@end


@implementation RecipeListViewController

static NSString *ReuseableTableViewCellId = @"ReuseableTableViewCellId";

- (instancetype)init
{
    if (self = [super init])
    {
        self.title = NSLocalizedString(@"All Recipes", @"All Recipes");
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    self.view = [[UIView alloc] init];
    self.edgesForExtendedLayout = UIRectEdgeTop;
    [self.view addSubview:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background"]]];
        
    _navBar = [[UINavigationBar alloc] init];
    _navBar.translatesAutoresizingMaskIntoConstraints = NO;
    _navBar.delegate = self;
    
    _navItem = [[UINavigationItem alloc] init];
    //_navItem.title = ;
    //_navItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add:)];
    NSAttributedString *_title = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"All Recipes", @"All Recipes")];
    
    [_navBar pushNavigationItem:_navItem animated:YES];
    
    [_navBar setBackgroundImage:[UIImage imageNamed:@"Status-Bar"] forBarMetrics:UIBarMetricsDefault];
    
    _mainTableView = [[UITableView alloc] init];
    _mainTableView.dataSource = self;
    _mainTableView.delegate = self;
    _mainTableView.translatesAutoresizingMaskIntoConstraints = NO;
    _mainTableView.estimatedRowHeight = 150.0;
    _mainTableView.rowHeight = UITableViewAutomaticDimension;
    _mainTableView.backgroundColor = [UIColor clearColor];
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UITableViewController *_searchResultsTableVC = [[UITableViewController alloc] initWithStyle:UITableViewStyleGrouped];

    _searchController = [[UISearchController alloc] initWithSearchResultsController:_searchResultsTableVC];

    _searchResultsTableView = ((UITableViewController *)_searchController.searchResultsController).tableView;
    _searchResultsTableView.delegate = self;
    _searchResultsTableView.dataSource = self;
    _searchResultsTableView.estimatedRowHeight = 150.0;
    _searchResultsTableView.rowHeight = UITableViewAutomaticDimension;
    
    _searchController.searchResultsUpdater = self;
    _searchController.delegate = self;
    
    _searchController.searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _searchController.searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    _searchController.searchBar.searchBarStyle = UISearchBarStyleMinimal;
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
    
    Class RecipeListTableViewCellClass = RecipeListTableViewCell.class;
    
    [_mainTableView registerClass:RecipeListTableViewCellClass forCellReuseIdentifier:NSStringFromClass(RecipeListTableViewCellClass)];
    [_searchResultsTableView registerClass:RecipeListTableViewCellClass forCellReuseIdentifier:NSStringFromClass(RecipeListTableViewCellClass)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self refreshDatasource];
}

- (void)refreshDatasource
{
    if (!_context)
    {
        _context = [[DataManager sharedInstance] mainObjectContext];
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass(Recipe.class)];
    NSError *error;
    
    _dataAllRecipes = [[_context executeFetchRequest:fetchRequest error:&error] mutableCopy];
    
    [_mainTableView reloadData];
}


- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *searchText = searchController.searchBar.text;
    
    _dataSearchedRecipes = [NSArray new];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name contains[c] %@", searchText];
    
    _dataSearchedRecipes = [_dataAllRecipes filteredArrayUsingPredicate:predicate];
    
    [_searchResultsTableView reloadData];
}

#pragma mark - TableView DataSource
#pragma mark

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ((tableView == _searchResultsTableView) ? [_dataSearchedRecipes count] : [_dataAllRecipes count]);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecipeListTableViewCell *cell = (RecipeListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass(RecipeListTableViewCell.class) forIndexPath:indexPath];
    
    NSInteger row = indexPath.row;
    
    // Choose the correct datasource
    NSArray *_datasource = ((tableView == _searchResultsTableView) ? _dataSearchedRecipes : _dataAllRecipes);
    
    Recipe *recipe = (Recipe *)[_datasource objectAtIndex:row];
    
    cell.recipeName.text = recipe.name;
    cell.recipeName.numberOfLines = 0;
    cell.prep.text = [recipe.prep stringValue];
    cell.total.text = [recipe.total stringValue];
    cell.serves.text = [recipe.serves stringValue];
    cell.difficulty.text = @"medium";
    cell.tags.text = @"tags here";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ((tableView == _searchResultsTableView) ? NO : YES);
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        Recipe *recipeToDelete = [_dataAllRecipes objectAtIndex:indexPath.row];
        
        [_context deleteObject:recipeToDelete];
        
        [[DataManager sharedInstance] save];
        
        [self refreshDatasource];
        
        EmptyRecipeViewController *_emptyVC = [[EmptyRecipeViewController alloc] init];
        
        [self.splitViewController showDetailViewController:_emptyVC sender:self];
    }
}

#pragma mark - TableView Delegate
#pragma mark

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark - Private methods
#pragma mark

- (void)search:(UIBarButtonItem *)sender
{
    ///
}


- (void)add:(UIBarButtonItem *)sender
{
    _recipeTextVC = [[RecipeTextViewController alloc] init];
    
    _recipeTextVC.modalPresentationStyle = UIModalPresentationFormSheet;
    
    [self.splitViewController presentViewController:_recipeTextVC animated:YES completion:nil];
}

-(void)random:(UIButton *)sender
{
    
    //NSArray *_datasource = ((tableView == _searchResultsTableView) ? _dataSearchedRecipes : _dataAllRecipes);
    
    //Recipe *_recipe = [_datasource objectAtIndex:indexPath.row];
    
    //RecipeDetailViewController *_detailVC = [[RecipeDetailViewController alloc] initWithRecipe:_recipe];
    
    //[self.splitViewController showDetailViewController:_detailVC sender:self];
}

- (UIBarPosition)positionForBar:(id <UIBarPositioning>)bar
{
    return UIBarPositionTopAttached;
}

@end

//
//  RecipeDetailViewController.m
//  RecipeHelper
//
//  Created by emdog4 on 6/21/14.
//  Copyright (c) 2014 Emery Clark. All rights reserved.
//

#import "RecipeDetailViewController.h"
#import "IngredientListViewController.h"

#import "RecipeListViewController.h"
#import "RecipeIngredientTableViewCell.h"
#import "RecipeStepTableViewCell.h"
#import "RecipeStepComponentCollectionViewCell.h"

#import "RecipeDetailsTableViewHeaderView.h"

#import "Models.h"


@interface RecipeDetailViewController ()
{
    UITableView *_mainTableView;
    Recipe *_recipeSelected;
    
    UINavigationBar *_navBar;
    UINavigationItem *_navItem;
    
    NSMutableArray *_ingredients;
    NSMutableArray *_steps;
    NSManagedObjectContext *_context;
    
    NSArray *_timeValues;
    NSArray *_timeUnits;
    NSArray *_serves;
    
    UIFont *_titleFont;
    UIFont *_sectionFont;
}
@end

@implementation RecipeDetailViewController

- (instancetype)init
{
    if (self = [super init])
    {
        self = [self initWithRecipe:nil];
    }
    return self;
}

- (instancetype)initWithRecipe:(Recipe *)recipe
{
    if (self = [super init])
    {
        _recipeSelected = recipe;
                
        _titleFont = [UIFont fontWithName:@"Helvetica Neue" size:17.0];
        _sectionFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:17.0];
        
        _ingredients = [[_recipeSelected.ingredients array] mutableCopy];
        _steps = [[_recipeSelected.steps array] mutableCopy];
        
        _timeValues = [[PlistModel singleton] timeValues];
        _timeUnits = [[PlistModel singleton] timeUnits];
        _serves = [[PlistModel singleton] serves];
    }
    
    return self;
}

- (void)loadView
{
    [super loadView];
    
    self.view = [[UIView alloc] init];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    _mainTableView = [[UITableView alloc] init];
    _mainTableView.translatesAutoresizingMaskIntoConstraints = NO;
    _mainTableView.backgroundColor = [UIColor clearColor];
    
    _navBar = [[UINavigationBar alloc] init];
    _navBar.translatesAutoresizingMaskIntoConstraints = NO;
    
    _navItem = [[UINavigationItem alloc] init];
    _navItem.rightBarButtonItem = self.editButtonItem;
    
    [_navBar pushNavigationItem:_navItem animated:YES];
    
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

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    
    Class RecipeIngredientTableViewCellClass = RecipeIngredientTableViewCell.class;
    Class RecipeStepTableViewCellClass = RecipeStepTableViewCell.class;
    
    [_mainTableView registerClass:RecipeIngredientTableViewCellClass forCellReuseIdentifier:NSStringFromClass(RecipeIngredientTableViewCellClass)];
    [_mainTableView registerClass:RecipeStepTableViewCellClass forCellReuseIdentifier:NSStringFromClass(RecipeStepTableViewCellClass)];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
        
    _ingredients = [[_recipeSelected.ingredients array] mutableCopy];
    _steps = [[_recipeSelected.steps array] mutableCopy];
    
    [_mainTableView reloadData];
}

#pragma mark - TableView DataSource
#pragma mark

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
            return 0;
        case 1:
            return [_ingredients count] + 1;
        case 2:
            return [_steps count] + 1;
        default:
            return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case 1:
        {
            if (indexPath.row == [_ingredients count])
            {
                UITableViewCell *_cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(UITableViewCell.class)];
                
                _cell.textLabel.text = NSLocalizedString(@"Add Ingredient", @"Add Ingredient");
                _cell.backgroundColor = [UIColor clearColor];
                
                return _cell;
            }
            else
            {
                RecipeIngredientTableViewCell *_cell = (RecipeIngredientTableViewCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass(RecipeIngredientTableViewCell.class) forIndexPath:indexPath];
                
                Ingredient *ingredient = (Ingredient *)[_ingredients objectAtIndex:indexPath.row];
                
                [_cell setIngredient:ingredient];
                _cell.backgroundColor = [UIColor clearColor];
                
                return _cell;
            }
        }
        case 2:
        {
            if (indexPath.row == [_steps count])
            {
                UITableViewCell *_cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(UITableViewCell.class)];
                
                _cell.textLabel.text = NSLocalizedString(@"Add Step", @"Add Step");
                _cell.backgroundColor = [UIColor clearColor];

                return _cell;
            }
            else
            {
                RecipeStepTableViewCell *_cell = (RecipeStepTableViewCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass(RecipeStepTableViewCell.class) forIndexPath:indexPath];
                
                Step *_step = (Step *)[_steps objectAtIndex:indexPath.row];
                
                _cell.textLabel.text = _step.text;
                
                NSSet *ingredients = _step.ingredients;
                NSSet *cookwares = _step.cookwares;

                NSMutableArray *allObjects = [NSMutableArray new];
                
                [allObjects addObjectsFromArray:[ingredients allObjects]];
                [allObjects addObjectsFromArray:[cookwares allObjects]];
                
                _cell.detailTextLabel.text =  [allObjects componentsJoinedByString:@", "];
                _cell.backgroundColor = [UIColor clearColor];

                return _cell;
            }
        }
        default:
            break;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    if (sourceIndexPath.section != destinationIndexPath.section)
        return;
    
    if (sourceIndexPath.row == destinationIndexPath.row)
        return;
    
    if (sourceIndexPath.section == 1)
    {
        NSInteger destination = destinationIndexPath.row;
        NSInteger source = sourceIndexPath.row;
        
        Ingredient *ingredient = [_ingredients objectAtIndex:source];
        
        [_ingredients insertObject:ingredient atIndex:destination];
        
        NSInteger offset = 1;
        
        if (destination > source && source > 0)
        {
            offset = -1;
        }
        else if (source == 0)
        {
            offset = 0;
        }
        
        [_ingredients removeObjectAtIndex:source+offset];
        
        [_recipeSelected setIngredients:[NSOrderedSet orderedSetWithArray:_ingredients]];
    }
    else if (sourceIndexPath.section == 2)
    {
        Step *step = [_steps objectAtIndex:sourceIndexPath.row];
        
        [_steps insertObject:step atIndex:destinationIndexPath.row];
        [_steps removeObjectAtIndex:sourceIndexPath.row];
        
        [_recipeSelected setSteps:[NSOrderedSet orderedSetWithArray:_steps]];
    }
    
    [[DataManager sharedInstance] save];
    
    [tableView reloadData];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSManagedObject *managedObject;
        
        if (section == 1)
        {
            managedObject = [_recipeSelected.ingredients objectAtIndex:row];
            [_ingredients removeObjectAtIndex:row];
        }
        else if (section == 2)
        {
            managedObject = [_recipeSelected.steps objectAtIndex:row];
            [_steps removeObjectAtIndex:row];
        }
        
        [_context deleteObject:managedObject];
        
        [[DataManager sharedInstance] save];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
    
    if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        if (section == 1)
        {
            IngredientListViewController *ingredientListVC = [[IngredientListViewController alloc] init];
            ingredientListVC.recipeSelected = _recipeSelected;
            
            [self.splitViewController showViewController:ingredientListVC sender:self];
            
        }
        else if (section == 2)
        {
            ///
            
        }
    }
}

#pragma mark - TableView Delegate
#pragma mark

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
        {
            return [[RecipeDetailsTableViewHeaderView alloc] initWithTitle:_recipeSelected.name andFont:_titleFont];
        }
        case 1:
        {
            return [[RecipeDetailsTableViewHeaderView alloc] initWithTitle:@"Ingredients" andFont:_sectionFont];
        }
        case 2:
        {
            return [[RecipeDetailsTableViewHeaderView alloc] initWithTitle:@"Steps" andFont:_sectionFont];
        }
        default:
            return [UIView new];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat height;
    
    switch (section)
    {
        case 0:
        {
            height = [self calculateHeaderHeightForSection:section withText:_recipeSelected.name font:_titleFont andPadding:10.0];
            break;
        }
        case 1:
        {
            NSString *text = @"Ingredients";
            height = [self calculateHeaderHeightForSection:section withText:text font:_sectionFont andPadding:10.0];
            break;
        }
        case 2:
        {
            NSString *text = @"Steps";
            height = [self calculateHeaderHeightForSection:section withText:text font:_sectionFont andPadding:10.0];
            break;
        }
    }
    
    return ceilf(height);
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    if ((section == 1 && row == [_ingredients count]) || (section == 2 && row == [_steps count]))
    {
        return UITableViewCellEditingStyleInsert;
    }
    else
    {
        return UITableViewCellEditingStyleDelete;
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.isEditing && indexPath.section > 0)
    {
        return YES;
    }
    
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    if (section == 0)
        return NO;
    else if ((section == 1 && row == [_ingredients count]) || (section == 2 && row == [_steps count]))
        return NO;
    else
        return YES;
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    if (sourceIndexPath.section != proposedDestinationIndexPath.section)
    {
        return sourceIndexPath;
    }
    else
    {
        return proposedDestinationIndexPath;
    }
}

#pragma mark - UIScrollViewDelegate Methods
#pragma mark

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (![scrollView isKindOfClass:[UICollectionView class]]) return;
    
//    CGFloat horizontalOffset = scrollView.contentOffset.x;
//    
//    UICollectionView *collectionView = (UICollectionView *)scrollView;
//    NSInteger index = collectionView.tag;
//    _collectionViewContentOffsets[[@(index) stringValue]] = @(horizontalOffset);
}

#pragma mark - Private methods
#pragma mark

- (BOOL)sectionNeedsAddItemCellForIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case 1:
            return (indexPath.row == [_ingredients count]);
        case 2:
            return (indexPath.row == [_steps count]);
        default:
            return NO;
    }
}

- (CGFloat)calculateHeaderHeightForSection:(NSInteger)section withText:(NSString *)text font:(UIFont *)font andPadding:(CGFloat)padding
{
    CGFloat height;
    
    CGFloat width = self.view.bounds.size.width - 40;
    
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName: font}];
    
    CGRect rect = [attributedText boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    
    height = rect.size.height + padding;
    
    return ceilf(height);
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    
    [[DataManager sharedInstance] save];

    [_mainTableView setEditing:editing animated:animated];
    
    [_mainTableView reloadData];
}

- (void)itemAction:(UIBarButtonItem *)sender
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Recipe Options" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Share with Friends" style:UIAlertActionStyleDefault handler:nil]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Pin Ingredients to Grocery List" style:UIAlertActionStyleDefault handler:nil]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Add Recipe to Favorites" style:UIAlertActionStyleDefault handler:nil]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Print" style:UIAlertActionStyleDefault handler:nil]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Delete Recipe" style:UIAlertActionStyleDestructive handler:nil]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    
    alert.modalPresentationStyle = UIModalPresentationPopover;
    
    UIPopoverPresentationController *popPC = alert.popoverPresentationController;
    
    popPC.barButtonItem = [self.navigationItem.rightBarButtonItems objectAtIndex:0];
    popPC.permittedArrowDirections = UIPopoverArrowDirectionUp;
    
    [self.splitViewController presentViewController:alert animated:YES completion:nil];
}

@end

//
//  RecipeTextViewController.m
//  RecipeHelper
//
//  Created by emdog4 on 4/24/14.
//  Copyright (c) 2014 Emery Clark. All rights reserved.
//

#import "RecipeTextViewController.h"
#import "RecipeListViewController.h"

#import "Recipe.h"
#import "DataManager.h"

@interface RecipeTextViewController ()
{
    RecipeCardTextView *_cardTextView;
    
    NSManagedObjectContext *_context;
    
    UINavigationBar *_navBar;
    UINavigationItem *_navItem;
}
@end


@implementation RecipeTextViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)loadView
{
    [super loadView];
    
    self.view = [[UIView alloc] init];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    _cardTextView = [[RecipeCardTextView alloc] init];
    _cardTextView.translatesAutoresizingMaskIntoConstraints = NO;
    _cardTextView.delegate = self;
    
    _navBar = [[UINavigationBar alloc] init];
    _navBar.translatesAutoresizingMaskIntoConstraints = NO;
    
    _navItem = [[UINavigationItem alloc] init];
    _navItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save:)];
    _navItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
    
    _navItem.title = NSLocalizedString(@"Recipe Title", @"Recipe Title");
    _navItem.prompt = NSLocalizedString(@"Please Enter A Title For Your New Recipe", @"Please Enter A Title For Your New Recipe");
    
    [_navBar pushNavigationItem:_navItem animated:YES];
    
    [self.view addSubview:_navBar];
    [self.view addSubview:_cardTextView];
    
    id _topLayoutGuide = self.topLayoutGuide;
    
    NSMutableArray *constraints = [NSMutableArray array];
    NSDictionary *_bindings = NSDictionaryOfVariableBindings(_cardTextView, _navBar, _topLayoutGuide);
    
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_topLayoutGuide][_navBar][_cardTextView]|" options:0 metrics:nil views:_bindings]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_navBar]|" options:0 metrics:nil views:_bindings]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_cardTextView]|" options:0 metrics:nil views:_bindings]];
    
    [self.view addConstraints:constraints];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    if ([self.presentingViewController isKindOfClass:UISplitViewController.class] && [(UISplitViewController *)self.presentingViewController isCollapsed])
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
    }
}

#pragma mark - Private
#pragma mark

- (void)cancel:(UIBarButtonItem *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)save:(UIBarButtonItem *)sender
{
    [self newRecipe:_cardTextView.text];

    BOOL isSplitVC = [self.presentingViewController isKindOfClass:UISplitViewController.class];
    
    BOOL primaryIsRecipeListVC = [((UISplitViewController *)self.presentingViewController).viewControllers[0] isKindOfClass:RecipeListViewController.class];
    
    RecipeListViewController *_primaryVC;
    
    if (isSplitVC && primaryIsRecipeListVC)
    {
        _primaryVC = (RecipeListViewController *)((UISplitViewController *)self.presentingViewController).viewControllers[0];
    }

    [self dismissViewControllerAnimated:YES completion:^{
        if (_primaryVC)
        {
            [_primaryVC refreshDatasource];
        }
    }];
}

- (void)newRecipe:(NSString *)name
{
    NSString *NewRecipeEntityName = NSStringFromClass(Recipe.class);
    
    if (!_context)
    {
        _context = [[DataManager sharedInstance] mainObjectContext];
    }
    
    Recipe *newRecipe = [NSEntityDescription insertNewObjectForEntityForName:NewRecipeEntityName inManagedObjectContext:_context];
    
    newRecipe.name = name ? name : @"empty";
    newRecipe.prep = [NSDecimalNumber decimalNumberWithDecimal:[@10 decimalValue]];
    newRecipe.total = [NSDecimalNumber decimalNumberWithDecimal:[@30 decimalValue]];
    newRecipe.serves = @4;
    
    [[DataManager sharedInstance] save];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

#pragma mark - Keyboard Notification Handlers
#pragma mark

- (void)keyboardWillShowNotification:(NSNotification*)notification
{
    CGFloat keyboardHeight = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    UIEdgeInsets insets = _cardTextView.contentInset;
    insets.bottom = keyboardHeight;
    _cardTextView.contentInset = insets;
    
    insets = _cardTextView.scrollIndicatorInsets;
    insets.bottom = keyboardHeight;
    _cardTextView.scrollIndicatorInsets = insets;
}

- (void)keyboardWillHideNotification:(NSNotification*)notification
{
    UIEdgeInsets insets = UIEdgeInsetsZero;
    insets.top = self.topLayoutGuide.length;
    
    _cardTextView.contentInset = insets;
    _cardTextView.scrollIndicatorInsets = insets;
    
    [_cardTextView endEditing:YES];
}

@end

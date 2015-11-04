//
//  RecipeSplitViewControllerDelegate.m
//  RecipeHelper
//
//  Created by emdog4 on 7/24/14.
//  Copyright (c) 2014 Emery Clark. All rights reserved.
//

#import "RecipeSplitViewControllerDelegate.h"

#import "RecipeListViewController.h"
#import "RecipeDetailViewController.h"
#import "EmptyRecipeViewController.h"

#import "IngredientListViewController.h"
#import "EmptyRecipeViewController.h"

@implementation RecipeSplitViewControllerDelegate

#pragma mark - SplitVC delegate


-(void)splitViewController:(UISplitViewController *)svc willChangeToDisplayMode:(UISplitViewControllerDisplayMode)displayMode
{
    ///
}

- (UISplitViewControllerDisplayMode)targetDisplayModeForActionInSplitViewController:(UISplitViewController *)svc
{
    return (svc.isCollapsed ? UISplitViewControllerDisplayModeAutomatic : UISplitViewControllerDisplayModeAllVisible);
}

-(BOOL)splitViewController:(UISplitViewController *)splitViewController showViewController:(UIViewController *)vc sender:(id)sender
{
    if ([vc isKindOfClass:IngredientListViewController.class] ||
        [vc isKindOfClass:RecipeListViewController.class])
    {
        if ([splitViewController.viewControllers count] < 2)
        {
            [splitViewController setViewControllers:@[vc]];
        }
        else
        {
            UIViewController *secondaryVC = splitViewController.viewControllers[1];
            [splitViewController setViewControllers:@[vc, secondaryVC]];
        }
        
        return YES;
    }
    
    return NO;
}

-(BOOL)splitViewController:(UISplitViewController *)splitViewController showDetailViewController:(UIViewController *)vc sender:(id)sender
{
    if (splitViewController.collapsed)
    {
        if ([vc isKindOfClass:EmptyRecipeViewController.class])
        {
            return YES;
        }
        if ([vc isKindOfClass:RecipeDetailViewController.class])
        {
            [splitViewController setViewControllers:@[vc]];
            return YES;
        }
        
    }
    
    return NO;
}

- (UIViewController *)primaryViewControllerForCollapsingSplitViewController:(UISplitViewController *)splitViewController
{
    return nil;
}

- (UIViewController *)primaryViewControllerForExpandingSplitViewController:(UISplitViewController *)splitViewController
{
    return nil;
}

- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController
{
    return YES;
}


-(UIViewController *)splitViewController:(UISplitViewController *)splitViewController separateSecondaryViewControllerFromPrimaryViewController:(UIViewController *)primaryViewController
{
    return nil;
}

@end

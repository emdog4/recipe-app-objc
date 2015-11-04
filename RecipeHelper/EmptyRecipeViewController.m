//
//  EmptyRecipeViewController.m
//  RecipeHelper
//
//  Created by emdog4 on 7/21/14.
//  Copyright (c) 2014 Emery Clark. All rights reserved.
//

#import "EmptyRecipeViewController.h"

@interface EmptyRecipeViewController ()
{
    UINavigationBar *_navBar;
    UINavigationItem *_navItem;
}

@end

@implementation EmptyRecipeViewController


- (void)loadView
{
    [super loadView];
    
    self.view = [[UIView alloc] init];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    _navBar = [[UINavigationBar alloc] init];
    _navBar.translatesAutoresizingMaskIntoConstraints = NO;
    
    _navItem = [[UINavigationItem alloc] init];
    
    [_navBar pushNavigationItem:_navItem animated:NO];

    UILabel *_label = [[UILabel alloc] init];
    _label.translatesAutoresizingMaskIntoConstraints = NO;
    _label.text = NSLocalizedString(@"No Recipe Selected", @"No Recipe Selected");
    _label.textColor = [UIColor colorWithWhite:0.0 alpha:0.4];
    _label.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];

    [self.view addSubview:_label];
    [self.view addSubview:_navBar];
    
    id _topLayoutGuide = self.topLayoutGuide;
    
    NSMutableArray *_constraints = [NSMutableArray array];
    NSDictionary *_bindings = NSDictionaryOfVariableBindings(_navBar, _topLayoutGuide);
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_label attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_label attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
    
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_topLayoutGuide][_navBar]" options:0 metrics:nil views:_bindings]];
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_navBar]|" options:0 metrics:nil views:_bindings]];
    
    [self.view addConstraints:_constraints];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.splitViewController.preferredDisplayMode = UISplitViewControllerDisplayModeAllVisible;
}

@end

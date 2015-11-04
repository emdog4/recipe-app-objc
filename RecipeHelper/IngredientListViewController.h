//
//  IngredientListViewController.h
//  RecipeHelper
//
//  Created by emdog4 on 7/26/14.
//  Copyright (c) 2014 Emery Clark. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Recipe.h"

@interface IngredientListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate>

@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) UITableView *mainTableView;

@property (strong, nonatomic) Recipe *recipeSelected;

@property (strong, nonatomic) NSArray *foods;
@property (strong, nonatomic) NSMutableArray *values;

@property (strong, nonatomic) NSMutableDictionary *dataAllDictionary;
@property (strong, nonatomic) NSArray *dataAllKeys;
@property (strong, nonatomic) NSArray *dataSearchedKeys;


@end

//
//  RecipeDetailViewController.h
//  RecipeHelper
//
//  Created by emdog4 on 6/21/14.
//  Copyright (c) 2014 Emery Clark. All rights reserved.
//

@import UIKit;

@class Recipe;

@interface RecipeDetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

- (instancetype)initWithRecipe:(Recipe *)recipe;

@end

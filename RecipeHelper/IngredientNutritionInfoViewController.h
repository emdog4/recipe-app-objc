//
//  IngredientNutritionInfoViewController.h
//  RecipeHelper
//
//  Created by Emery Clark on 9/22/14.
//  Copyright (c) 2014 Emery Clark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IngredientNutritionInfoViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (strong, nonatomic) UITableView *ingredientNutritionTableView;

@end

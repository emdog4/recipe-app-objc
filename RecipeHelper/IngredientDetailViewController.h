//
//  IngredientDetailViewController.h
//  RecipeHelper
//
//  Created by Emery Clark on 9/21/14.
//  Copyright (c) 2014 Emery Clark. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Ingredient.h"
#import "Recipe.h"

@interface IngredientDetailViewController : UIViewController <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) Ingredient *ingredient;

@property (strong, nonatomic) UINavigationBar *navBar;
@property (strong, nonatomic) UINavigationItem *navItem;
@property (strong, nonatomic) UIPickerView *pickerView;
@property (strong, nonatomic) UITextField *textField;


@end

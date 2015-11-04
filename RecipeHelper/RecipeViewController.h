//
//  RECRecipeViewController.h
//  RecipeHelper
//
//  Created by Emery Clark on 9/18/13.
//  Copyright (c) 2013 Emery Clark. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Recipe.h"

@interface RecipeViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) Recipe *recipe;

- (IBAction)doneButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)cancelButtonPressed:(UIBarButtonItem *)sender;


@end

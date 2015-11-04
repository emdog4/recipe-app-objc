//
//  IngredientNutritionInfoViewController.m
//  RecipeHelper
//
//  Created by Emery Clark on 9/22/14.
//  Copyright (c) 2014 Emery Clark. All rights reserved.
//

#import "IngredientNutritionInfoViewController.h"

@interface IngredientNutritionInfoViewController ()

@end

@implementation IngredientNutritionInfoViewController

static NSString *TextFieldTableViewCellId = @"TextFieldTableViewCellId";

- (instancetype)init
{
    if (self= [super init])
    {
        self.title = @"Nutrition";
        self.view = [[UIView alloc] init];
        self.view.backgroundColor = [UIColor whiteColor];
        
        _ingredientNutritionTableView = [[UITableView alloc] init];
        _ingredientNutritionTableView.translatesAutoresizingMaskIntoConstraints = NO;
        _ingredientNutritionTableView.delegate = self;
        _ingredientNutritionTableView.dataSource = self;
        
        [self.view addSubview:_ingredientNutritionTableView];
        
        NSMutableArray *constraints = [NSMutableArray array];
        NSDictionary *_bindings = NSDictionaryOfVariableBindings(_ingredientNutritionTableView);
        
        [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_ingredientNutritionTableView]|" options:0 metrics:nil views:_bindings]];
        [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_ingredientNutritionTableView]|" options:0 metrics:nil views:_bindings]];
        
        [self.view addConstraints:constraints];
        
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View Datasource
#pragma mark

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    switch (section)
    {
        case 0:
        {
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TextFieldTableViewCellId];
            cell.textLabel.text = [NSString stringWithFormat:@"%ld", (long)row];
            return cell;
        }
        default:
            break;
    }
    
    return nil;
}

#pragma mark - Table View Delegate
#pragma mark

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return;
}

#pragma mark - Text Field Delegate
#pragma mark

- (void)textFieldDidEndEditing:(UITextField *)textField
{
}

@end

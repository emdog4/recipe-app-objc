//
//  RecipeIngredientTableViewCell.h
//  RecipeHelper
//
//  Created by emdog4 on 7/26/14.
//  Copyright (c) 2014 Emery Clark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Models.h"

@interface RecipeIngredientTableViewCell : UITableViewCell

@property (strong, nonatomic) Ingredient *ingredient;

@property (strong, nonatomic) UILabel *title;
@property (strong, nonatomic) UILabel *subtitle;

@end

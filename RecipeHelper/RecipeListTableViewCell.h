//
//  RecipeListTableViewCell.h
//  RecipeHelper
//
//  Created by emdog4 on 7/9/14.
//  Copyright (c) 2014 Emery Clark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipeListTableViewCell : UITableViewCell

@property (strong, nonatomic) UILabel *recipeName;
@property (strong, nonatomic) UILabel *prep;
@property (strong, nonatomic) UILabel *total;
@property (strong, nonatomic) UILabel *serves;
@property (strong, nonatomic) UILabel *difficulty;
@property (strong, nonatomic) UILabel *tags;

@end

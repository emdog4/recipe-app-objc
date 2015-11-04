//
//  RecipeStepTableViewCell.m
//  RecipeHelper
//
//  Created by emdog4 on 7/26/14.
//  Copyright (c) 2014 Emery Clark. All rights reserved.
//

#import "RecipeStepTableViewCell.h"
#import "RecipeStepComponentCollectionViewCell.h"

@implementation RecipeStepTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(self.class)];

    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
}

@end

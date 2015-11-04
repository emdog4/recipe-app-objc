//
//  RecipeStepComponentCollectionViewCell.m
//  RecipeHelper
//
//  Created by emdog4 on 7/26/14.
//  Copyright (c) 2014 Emery Clark. All rights reserved.
//

#import "RecipeStepComponentCollectionViewCell.h"

@implementation RecipeStepComponentCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        _name = [[UILabel alloc] init];
        _name.translatesAutoresizingMaskIntoConstraints = NO;
//        _name.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16.0];
        
        [self.contentView addSubview:_name];
        
        NSMutableArray *constraints = [NSMutableArray array];

        [constraints addObject:[NSLayoutConstraint constraintWithItem:_name attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_name.superview attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
        
        [constraints addObject:[NSLayoutConstraint constraintWithItem:_name attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:_name.superview attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0]];

        [self.contentView addConstraints:constraints];
    }
    
    return self;
}

@end

//
//  RecipeDetailsTableViewHeaderView.m
//  RecipeHelper
//
//  Created by emdog4 on 7/12/14.
//  Copyright (c) 2014 Emery Clark. All rights reserved.
//

#import "RecipeDetailsTableViewHeaderView.h"


@interface RecipeDetailsTableViewHeaderView ()
{
    NSDictionary *_bindings;
    UILabel *_labelTitle;
}

@end


@implementation RecipeDetailsTableViewHeaderView

- (instancetype)initWithTitle:(NSString *)title andFont:(UIFont *)font
{
    if (self = [super init])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        _labelTitle = [[UILabel alloc] init];
        
        _labelTitle.translatesAutoresizingMaskIntoConstraints = NO;
        
        _labelTitle.text = title;
        _labelTitle.numberOfLines = 0;
        
        _labelTitle.font = font;
        _labelTitle.textAlignment = NSTextAlignmentJustified;
        
        [self addSubview:_labelTitle];
        
        NSMutableArray *constraints = [NSMutableArray array];
        _bindings = NSDictionaryOfVariableBindings(_labelTitle);
        
        [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_labelTitle]|" options:0 metrics:nil views:_bindings]];
        [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_labelTitle]-|" options:0 metrics:nil views:_bindings]];
        
        [self addConstraints:constraints];
    }
    
    return self;
}


@end

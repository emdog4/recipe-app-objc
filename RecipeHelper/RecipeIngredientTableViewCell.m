//
//  RecipeIngredientTableViewCell.m
//  RecipeHelper
//
//  Created by emdog4 on 7/26/14.
//  Copyright (c) 2014 Emery Clark. All rights reserved.
//

#import "RecipeIngredientTableViewCell.h"

@implementation RecipeIngredientTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(self.class)];
    
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _title = [[UILabel alloc] init];
        _subtitle = [[UILabel alloc] init];
        
        _title.translatesAutoresizingMaskIntoConstraints = NO;
        _subtitle.translatesAutoresizingMaskIntoConstraints = NO;
        
        _title.numberOfLines = 0;
        _subtitle.numberOfLines = 0;
        
        _title.textAlignment = NSTextAlignmentLeft;
        _subtitle.textAlignment = NSTextAlignmentLeft;
        
        NSDictionary *bindings = NSDictionaryOfVariableBindings(_title, _subtitle);
        
        for (NSString *key in [bindings allKeys])
            [self.contentView addSubview:[bindings objectForKey:key]];
        
        NSMutableArray *constraints = [NSMutableArray array];
        
        //NSDictionary *metrics = @{@"left":@(self.contentView.layoutMargins.left)};
        
        [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_title]-[_subtitle]-|" options:0 metrics:nil views:bindings]];
        [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(20)-[_title]-|" options:0 metrics:nil views:bindings]];
        [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(20)-[_subtitle]-|" options:0 metrics:nil views:bindings]];
        
        [self.contentView addConstraints:constraints];
        
    }
    return self;
}


- (void)setIngredient:(Ingredient *)ingredient
{
    if (ingredient)
    {
        NSMutableArray *components = [NSMutableArray array];
        
        _subtitle.text = @"auto-layout placeholder";
         _subtitle.hidden = YES;
        
        if ([ingredient.amount floatValue] > 0)
        {
            CGFloat quantityValue = [ingredient.amount floatValue];
            
            NSString *quantity = nil;
            if (quantityValue == 0.25f) {
                const unichar quarter = 0xbc;
                quantity = [NSString stringWithCharacters:&quarter length:1];
            } else if (quantityValue == 0.33f) {
                const unichar third = 0x2153;
                quantity = [NSString stringWithCharacters:&third length:1];
            } else if (quantityValue == 0.5f) {
                const unichar half = 0xbd;
                quantity = [NSString stringWithCharacters:&half length:1];
            } else if (quantityValue == 0.66f) {
                const unichar twoThirds = 0x2154;
                quantity = [NSString stringWithCharacters:&twoThirds length:1];
            } else if (quantityValue == 0.75f) {
                const unichar threeQuarters = 0xbe;
                quantity = [NSString stringWithCharacters:&threeQuarters length:1];
            }
            
            if (quantity)
            {
                [components addObject:quantity];
            }
            else
            {
                [components addObject:[ingredient.amount stringValue]];
            }
            
        }
        
        if (ingredient.unit)
        {
            [components addObject:(ingredient.unit)];
        }
        
        if (ingredient.name)
        {
            [components addObject:(ingredient.name)];
        }
        
        _title.text = [components componentsJoinedByString:@" "];
        
//        if (ingredient.adjective.name)
//        {
//            _subtitle.hidden = NO;
//            _subtitle.text = ingredient.adjective.name;
//        }
    }
}

@end

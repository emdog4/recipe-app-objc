//
//  TextFieldTableViewCell.m
//  RecipeHelper
//
//  Created by Emery Clark on 9/22/14.
//  Copyright (c) 2014 Emery Clark. All rights reserved.
//

#import "TextFieldTableViewCell.h"

@implementation TextFieldTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{    
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(self.class)];
    
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _title = [[UITextField alloc] init];
        _title.translatesAutoresizingMaskIntoConstraints = NO;
        _title.borderStyle = UITextBorderStyleNone;
        _title.textAlignment = NSTextAlignmentLeft;
        _title.placeholder = @"Ingredient Name";
        _title.font = [UIFont systemFontOfSize:20.0];
        _title.clearButtonMode = UITextFieldViewModeWhileEditing;
        _title.minimumFontSize = 14.0;
        
        NSDictionary *bindings = NSDictionaryOfVariableBindings(_title);

        [self.contentView addSubview:_title];
        
        NSMutableArray *constraints = [NSMutableArray array];
        
        //NSDictionary *metrics = @{@"left":@(self.contentView.layoutMargins.left)};
        
        [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_title]-|" options:0 metrics:nil views:bindings]];
        [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_title]-|" options:0 metrics:nil views:bindings]];
        
        [self.contentView addConstraints:constraints];
        
    }
    return self;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

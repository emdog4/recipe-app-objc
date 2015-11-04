//
//  CheckmarkAccessoryTableViewCell.m
//  RecipeHelper
//
//  Created by Emery Clark on 9/22/14.
//  Copyright (c) 2014 Emery Clark. All rights reserved.
//

#import "CheckmarkAccessoryTableViewCell.h"

@implementation CheckmarkAccessoryTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(self.class)];
    
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _title = [[UILabel alloc] init];
        _title.translatesAutoresizingMaskIntoConstraints = NO;
        _title.numberOfLines = 0;
        _title.textAlignment = NSTextAlignmentLeft;
        
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

//
//  RecipeListTableViewCell.m
//  RecipeHelper
//
//  Created by emdog4 on 7/9/14.
//  Copyright (c) 2014 Emery Clark. All rights reserved.
//

#import "RecipeListTableViewCell.h"


@interface RecipeListTableViewCell ()
{
    UILabel *_prepLabel;
    UILabel *_totalLabel;
    UILabel *_servesLabel;
    UILabel *_difficultyLabel;
    UILabel *_tagsLabel;
    
    UIButton *_mainButton;
}

@end

@implementation RecipeListTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(RecipeListTableViewCell.class)])
    {
        self.backgroundColor = [UIColor clearColor];
        
        _mainButton = [[UIButton alloc] init];
        _mainButton.translatesAutoresizingMaskIntoConstraints = NO;

        [_mainButton setImage:[UIImage imageNamed:@"Rectangle-1"] forState:UIControlStateNormal];
        [_mainButton setImage:[UIImage imageNamed:@"Rectangle-2"] forState:UIControlStateHighlighted];
        
        _recipeName = [[UILabel alloc] init];
        _recipeName.translatesAutoresizingMaskIntoConstraints = NO;
        _recipeName.font = [UIFont fontWithName:@"Helvetica Neue Regular" size:17.0];
        _recipeName.numberOfLines = 0;
        
        _prep = [[UILabel alloc] init];
        _total = [[UILabel alloc] init];
        _serves = [[UILabel alloc] init];
        _difficulty = [[UILabel alloc] init];
        _tags = [[UILabel alloc] init];
        
        _prepLabel = [[UILabel alloc] init];
        _prepLabel.text = NSLocalizedString(@"Prep Time", @"Prep Time");
        
        _totalLabel = [[UILabel alloc] init];
        _totalLabel.text = NSLocalizedString(@"Total Time", @"Total Time");
        
        _servesLabel = [[UILabel alloc] init];
        _servesLabel.text = NSLocalizedString(@"Serves", @"Serves");
        
        _difficultyLabel = [[UILabel alloc] init];
        _difficultyLabel.text = NSLocalizedString(@"Difficulty", @"Difficulty");
        
        _tagsLabel = [[UILabel alloc] init];
        _tagsLabel.text = NSLocalizedString(@"Tags", @"Tags");
        
        _prepLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _tagsLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _difficultyLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _servesLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _totalLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _tags.translatesAutoresizingMaskIntoConstraints = NO;
        _difficulty.translatesAutoresizingMaskIntoConstraints = NO;
        _serves.translatesAutoresizingMaskIntoConstraints = NO;
        _total.translatesAutoresizingMaskIntoConstraints = NO;
        _prep.translatesAutoresizingMaskIntoConstraints = NO;
        
        NSDictionary *_bindings = NSDictionaryOfVariableBindings(_recipeName, _prep, _total, _serves, _difficulty, _tags, _prepLabel, _totalLabel, _servesLabel, _difficultyLabel, _tagsLabel);
        
        for (NSString *key in [_bindings allKeys])
            [_mainButton addSubview:[_bindings objectForKey:key]];
        
        NSMutableArray *_constraints = [NSMutableArray array];
        
        [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_recipeName]-|" options:0 metrics:nil views:_bindings]];
        
        [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_prepLabel]-[_prep]-[_totalLabel]-[_total]-|" options:0 metrics:nil views:_bindings]];
        
        [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_servesLabel]-[_serves]-[_difficultyLabel]-[_difficulty]" options:0 metrics:nil views:_bindings]];
        
        [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_tagsLabel]-[_tags]-|" options:0 metrics:nil views:_bindings]];
        
        [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_recipeName]-[_prepLabel]-[_servesLabel]-[_tagsLabel]-|" options:0 metrics:nil views:_bindings]];
        
        [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_recipeName]-[_prep]-[_serves]-[_tags]-|" options:0 metrics:nil views:_bindings]];
        
        [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_recipeName]-[_totalLabel]-[_difficultyLabel]-[_tags]-|" options:0 metrics:nil views:_bindings]];
        
        [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_recipeName]-[_total]-[_difficulty]-[_tags]-|" options:0 metrics:nil views:_bindings]];
        
        [_mainButton addConstraints:_constraints];
        
        
        _bindings = NSDictionaryOfVariableBindings(_mainButton);
        
        [self.contentView addSubview:_mainButton];
        
        _constraints = [NSMutableArray array];
        
        [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_mainButton]-|" options:0 metrics:nil views:_bindings]];
        [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_mainButton]-|" options:0 metrics:nil views:_bindings]];

        [self.contentView addConstraints:_constraints];
        
        self.contentView.layoutMargins = UIEdgeInsetsMake(10, 25, 10, 25);

    }
    
    return self;
}

@end

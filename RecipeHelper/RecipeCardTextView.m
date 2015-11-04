//
//  RecipeCardTextView.m
//  RecipeHelper
//
//  Created by emdog4 on 7/11/14.
//  Copyright (c) 2014 Emery Clark. All rights reserved.
//

#import "RecipeCardTextView.h"

@implementation RecipeCardTextView

- (instancetype)init
{
    if (self = [super init])
    {
        // Defaults
        
        self.scrollEnabled = YES;
        
        self.bounces = YES;
        self.alwaysBounceVertical = YES;
        
        self.selectable = YES;
        self.editable = YES;

        self.autocorrectionType = UITextAutocorrectionTypeDefault;
        
        //Overrides
        
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        
        self.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
        
        self.autocapitalizationType = UITextAutocapitalizationTypeNone;
        
        self.backgroundColor = [UIColor whiteColor];
        self.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:35.0];
        
        self.textAlignment = NSTextAlignmentJustified;
        
        //self.contentInset = UIEdgeInsetsMake(0, 8, 0, 8);
    }
    
    return self;
}



@end

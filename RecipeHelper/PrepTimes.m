//
//  PrepTimes.m
//  RecipeHelper
//
//  Created by Emery Clark on 11/20/13.
//  Copyright (c) 2013 Emery Clark. All rights reserved.
//

#import "PrepTimes.h"

@implementation PlistModel

+ (instancetype)singleton
{
	static dispatch_once_t once;
	static id sharedInstance;
    
	dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    
	return sharedInstance;
}

- (instancetype)init
{
    if (self = [super init])
    {
        NSDictionary *recipeList = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"recipe" ofType:@"plist"]];
        
        self.timeValues = [recipeList objectForKey:@"timeValues"];
        self.timeUnits = [recipeList objectForKey:@"timeUnits"];
        self.serves = [recipeList objectForKey:@"serves"];
        self.difficulties = [recipeList objectForKey:@"difficulty"];
        self.categories = [recipeList objectForKey:@"category"];
    }
    return self;
}

#pragma mark - Convenience methods

- (NSString *)timeValueForIndex:(NSUInteger)index
{
    return [self.timeValues objectAtIndex:index];
}

- (NSString *)timeUnitForIndex:(NSUInteger)index
{
    return [self.timeUnits objectAtIndex:index];
}

- (NSString *)servesForIndex:(NSUInteger)index
{
    return [self.serves objectAtIndex:index];
}

- (NSString *)difficultyForIndex:(NSUInteger)index
{
    return [self.difficulties objectAtIndex:index];
}

- (NSString *)categoryForIndex:(NSUInteger)index
{
    return [self.categories objectAtIndex:index];
}

@end

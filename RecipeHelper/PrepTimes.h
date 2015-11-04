//
//  PrepTimes.h
//  RecipeHelper
//
//  Created by Emery Clark on 11/20/13.
//  Copyright (c) 2013 Emery Clark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlistModel : NSObject

+ (instancetype)singleton;

@property (strong, nonatomic) NSArray *timeValues;
@property (strong, nonatomic) NSArray *timeUnits;
@property (strong, nonatomic) NSArray *difficulties;
@property (strong, nonatomic) NSArray *categories;
@property (strong, nonatomic) NSArray *serves;

- (NSString *)timeValueForIndex:(NSUInteger)index;
- (NSString *)timeUnitForIndex:(NSUInteger)index;
- (NSString *)servesForIndex:(NSUInteger)index;
- (NSString *)difficultyForIndex:(NSUInteger)index;
- (NSString *)categoryForIndex:(NSUInteger)index;

@end

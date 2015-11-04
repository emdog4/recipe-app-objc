//
//  Ingredient.h
//  RecipeHelper
//
//  Created by Emery Clark on 9/20/14.
//  Copyright (c) 2014 Emery Clark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Recipe, Step;

@interface Ingredient : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * amount;
@property (nonatomic, retain) NSString * unit;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * preparation;
@property (nonatomic, retain) Recipe *recipe;
@property (nonatomic, retain) Step *step;

@end

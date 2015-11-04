//
//  Recipe.h
//  RecipeHelper
//
//  Created by Emery Clark on 9/20/14.
//  Copyright (c) 2014 Emery Clark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Cookware, Ingredient, Step, Tag;

@interface Recipe : NSManagedObject

@property (nonatomic, retain) NSNumber * difficulty;
@property (nonatomic, retain) NSNumber * fav;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDecimalNumber * prep;
@property (nonatomic, retain) NSNumber * rating;
@property (nonatomic, retain) NSNumber * serves;
@property (nonatomic, retain) NSDecimalNumber * total;
@property (nonatomic, retain) NSData * picture;
@property (nonatomic, retain) NSOrderedSet *ingredients;
@property (nonatomic, retain) NSOrderedSet *steps;
@property (nonatomic, retain) NSSet *tags;
@property (nonatomic, retain) NSSet *cookwares;
@end

@interface Recipe (CoreDataGeneratedAccessors)

- (void)insertObject:(Ingredient *)value inIngredientsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromIngredientsAtIndex:(NSUInteger)idx;
- (void)insertIngredients:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeIngredientsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInIngredientsAtIndex:(NSUInteger)idx withObject:(Ingredient *)value;
- (void)replaceIngredientsAtIndexes:(NSIndexSet *)indexes withIngredients:(NSArray *)values;
- (void)addIngredientsObject:(Ingredient *)value;
- (void)removeIngredientsObject:(Ingredient *)value;
- (void)addIngredients:(NSOrderedSet *)values;
- (void)removeIngredients:(NSOrderedSet *)values;
- (void)insertObject:(Step *)value inStepsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromStepsAtIndex:(NSUInteger)idx;
- (void)insertSteps:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeStepsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInStepsAtIndex:(NSUInteger)idx withObject:(Step *)value;
- (void)replaceStepsAtIndexes:(NSIndexSet *)indexes withSteps:(NSArray *)values;
- (void)addStepsObject:(Step *)value;
- (void)removeStepsObject:(Step *)value;
- (void)addSteps:(NSOrderedSet *)values;
- (void)removeSteps:(NSOrderedSet *)values;
- (void)addTagsObject:(Tag *)value;
- (void)removeTagsObject:(Tag *)value;
- (void)addTags:(NSSet *)values;
- (void)removeTags:(NSSet *)values;

- (void)addCookwaresObject:(Cookware *)value;
- (void)removeCookwaresObject:(Cookware *)value;
- (void)addCookwares:(NSSet *)values;
- (void)removeCookwares:(NSSet *)values;

@end

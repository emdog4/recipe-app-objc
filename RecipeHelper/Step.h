//
//  Step.h
//  RecipeHelper
//
//  Created by Emery Clark on 9/20/14.
//  Copyright (c) 2014 Emery Clark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Cookware, Ingredient, Recipe;

@interface Step : NSManagedObject

@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) Recipe *recipe;
@property (nonatomic, retain) NSSet *ingredients;
@property (nonatomic, retain) NSSet *cookwares;
@end

@interface Step (CoreDataGeneratedAccessors)

- (void)addIngredientsObject:(Ingredient *)value;
- (void)removeIngredientsObject:(Ingredient *)value;
- (void)addIngredients:(NSSet *)values;
- (void)removeIngredients:(NSSet *)values;

- (void)addCookwaresObject:(Cookware *)value;
- (void)removeCookwaresObject:(Cookware *)value;
- (void)addCookwares:(NSSet *)values;
- (void)removeCookwares:(NSSet *)values;

@end

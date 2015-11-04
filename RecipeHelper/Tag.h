//
//  Tag.h
//  RecipeHelper
//
//  Created by Emery Clark on 9/20/14.
//  Copyright (c) 2014 Emery Clark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Recipe;

@interface Tag : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Recipe *recipe;

@end

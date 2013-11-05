//
//  ShoppingList.h
//  RecipesWithCore
//
//  Created by Timothy Dooris on 11/3/13.
//  Copyright (c) 2013 Timothy Dooris. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Recipe;

@interface ShoppingList : NSManagedObject

@property (nonatomic, retain) NSSet *recipes;
@end

@interface ShoppingList (CoreDataGeneratedAccessors)

- (void)addRecipesObject:(Recipe *)value;
- (void)removeRecipesObject:(Recipe *)value;
- (void)addRecipes:(NSSet *)values;
- (void)removeRecipes:(NSSet *)values;

@end

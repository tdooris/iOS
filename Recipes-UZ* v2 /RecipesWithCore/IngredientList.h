//
//  IngredientList.h
//  RecipesWithCore
//
//  Created by Timothy Dooris on 11/1/13.
//  Copyright (c) 2013 Timothy Dooris. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Ingredient, Recipe;

@interface IngredientList : NSManagedObject

@property (nonatomic, retain) Recipe *recipe;
@property (nonatomic, retain) NSSet *ingredient;
@end

@interface IngredientList (CoreDataGeneratedAccessors)

- (void)addIngredientObject:(Ingredient *)value;
- (void)removeIngredientObject:(Ingredient *)value;
- (void)addIngredient:(NSSet *)values;
- (void)removeIngredient:(NSSet *)values;

@end

//
//  Recipe.h
//  RecipesWithCore
//
//  Created by Timothy Dooris on 11/4/13.
//  Copyright (c) 2013 Timothy Dooris. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class IngredientList, ShoppingList;

@interface Recipe : NSManagedObject

@property (nonatomic, retain) NSString * recipeName;
@property (nonatomic, retain) IngredientList *ingredientList;
@property (nonatomic, retain) ShoppingList *shoppingList;

@end

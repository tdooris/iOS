//
//  Ingredient.h
//  RecipesWithCore
//
//  Created by Timothy Dooris on 11/1/13.
//  Copyright (c) 2013 Timothy Dooris. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class IngredientList;

@interface Ingredient : NSManagedObject

@property (nonatomic, retain) NSString * ingredientName;
@property (nonatomic, retain) IngredientList *ingredientList;

@end
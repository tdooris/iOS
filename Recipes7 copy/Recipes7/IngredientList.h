//
//  IngredientList.h
//  Recipes7
//
//  Created by Timothy Dooris on 11/1/13.
//  Copyright (c) 2013 Timothy Dooris. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface IngredientList : NSManagedObject

@property (nonatomic, retain) NSSet *ingredient;
@end

@interface IngredientList (CoreDataGeneratedAccessors)

- (void)addIngredientObject:(NSManagedObject *)value;
- (void)removeIngredientObject:(NSManagedObject *)value;
- (void)addIngredient:(NSSet *)values;
- (void)removeIngredient:(NSSet *)values;

@end

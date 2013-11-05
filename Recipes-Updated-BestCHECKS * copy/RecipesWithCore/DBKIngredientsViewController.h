//
//  DBKIngredientsViewController.h
//  RecipesWithCore
//
//  Created by Timothy Dooris on 11/1/13.
//  Copyright (c) 2013 Timothy Dooris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"

@interface DBKIngredientsViewController : UITableViewController
@property NSManagedObjectContext *managedObjectContext;
@property NSArray *ingredientsArray;
@property Recipe *targetRecipe;
@end

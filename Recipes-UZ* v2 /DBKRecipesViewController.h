//
//  DBKRecipesViewController.h
//  RecipesWithCore
//
//  Created by Timothy Dooris on 11/1/13.
//  Copyright (c) 2013 Timothy Dooris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DBKRecipesViewController : UITableViewController
@property (nonatomic, strong) NSArray *recipesArray;
@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;



@end

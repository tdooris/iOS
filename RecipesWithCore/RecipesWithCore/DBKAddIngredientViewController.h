//
//  DBKAddIngredientViewController.h
//  RecipesWithCore
//
//  Created by Timothy Dooris on 11/1/13.
//  Copyright (c) 2013 Timothy Dooris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"

@interface DBKAddIngredientViewController : UIViewController<UITextFieldDelegate>
@property Recipe *recipe;
@end
//
//  DBKAddIngredientViewController.m
//  RecipesWithCore
//
//  Created by Timothy Dooris on 11/1/13.
//  Copyright (c) 2013 Timothy Dooris. All rights reserved.
//

#import "DBKAddIngredientViewController.h"
#import "Recipe.h"
#import "DBKAppDelegate.h"
#import "DBKIngredientsViewController.h"
#import "IngredientList.h"
#import "Ingredient.h"


@interface DBKAddIngredientViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property NSArray *theRecipeArray;
@end

@implementation DBKAddIngredientViewController
@synthesize textField, thisRecipe;
@synthesize theRecipeArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    textField.delegate = self;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStyleBordered target:self action:@selector(addIngredient)];
    self.navigationItem.rightBarButtonItem = item;
    
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(dismiss)];
    self.navigationItem.leftBarButtonItem = item2;
    
    
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (DBKAppDelegate *)appDelegate {
    return ((DBKAppDelegate *)[[UIApplication sharedApplication] delegate]);
}

- (void) addIngredient {
    if(textField.text.length>0){
        
        NSManagedObjectContext *context = [[self appDelegate] managedObjectContext];
        
        // Construct a fetch request
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Recipe"
                                                  inManagedObjectContext:context];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"recipeName==%@", thisRecipe.recipeName];
        NSLog(@"The recipe we have is %@", thisRecipe.recipeName);
        
        [fetchRequest setPredicate:predicate];
        [fetchRequest setEntity:entity];
        
        NSError *error = nil;
        self.theRecipeArray = [context executeFetchRequest:fetchRequest error:&error];
        Recipe *foundRecipe = [theRecipeArray objectAtIndex:0];
        NSLog(@"The recipe you found was %@", foundRecipe.recipeName);
        NSLog(@"Its ingredientList is %@", foundRecipe.ingredientList);
        
        
        // Create a new Ingredient entity
        Ingredient *newIngredient = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:context];
        
        // Set ingredientName
        newIngredient.ingredientName = self.textField.text;
        
        //if there is no ingredientList, then create one and assign it to foundRecipe.
        if (foundRecipe.ingredientList == nil) {
            IngredientList *newIngredientList = [NSEntityDescription insertNewObjectForEntityForName:@"IngredientList" inManagedObjectContext:context];
            foundRecipe.ingredientList = newIngredientList;
        }
        
        
        //Add newIngredient to the ingredientList of the chosen recipe.
        [foundRecipe.ingredientList addIngredientObject:newIngredient];
        
        
        //Save everything
        if ([context save:&error]) {
            NSLog(@"The save was successful!");
        } else {
            NSLog(@"The save wasn't successful: %@", [error userInfo]);
        }
        
        
    }
    //regardless of whether you added a new ingredient, you have to return to previous VC with recipe in tow.
    
    DBKIngredientsViewController *controller = [[DBKIngredientsViewController alloc] init];
    controller.targetRecipe = self.thisRecipe;
    NSLog(@"Leaving AddVC, with recipe %@ in tow.", thisRecipe.recipeName);
    [self.navigationController popViewControllerAnimated:YES];
 
        
}
    

- (void) dismiss {
    
    DBKIngredientsViewController *controller = [[DBKIngredientsViewController alloc] init];
    controller.targetRecipe = self.thisRecipe;
    NSLog(@"Leaving AddVC, with recipe %@ in tow.", thisRecipe.recipeName);
    [self.navigationController popViewControllerAnimated:YES];
}





@end

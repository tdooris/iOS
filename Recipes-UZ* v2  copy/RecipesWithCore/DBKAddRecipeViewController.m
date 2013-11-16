//
//  DBKAddRecipeViewController.m
//  RecipesWithCore
//
//  Created by Timothy Dooris on 11/1/13.
//  Copyright (c) 2013 Timothy Dooris. All rights reserved.
//

#import "DBKAddRecipeViewController.h"
#import "DBKRecipesViewController.h"
#import "Recipe.h"
#import "DBKAppDelegate.h"

@interface DBKAddRecipeViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;


@end

@implementation DBKAddRecipeViewController

@synthesize textField;


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
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStyleBordered target:self action:@selector(addRecipe)];
    self.navigationItem.rightBarButtonItem = item;
    
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(dismiss)];
    self.navigationItem.leftBarButtonItem = item2;
    
  //  id delegate = [[UIApplication sharedApplication] delegate];
  //  self.managedObjectContext = [delegate managedObjectContext];

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

- (void) addRecipe {
    if(textField.text.length>0){
        // Grab the context
        NSManagedObjectContext *context = [[self appDelegate] managedObjectContext];
        
        // Grab the Label entity
        Recipe *recipe = [NSEntityDescription insertNewObjectForEntityForName:@"Recipe" inManagedObjectContext:context];
        
        // Set label name
        recipe.recipeName = self.textField.text;
        
        
        // Save everything
        NSError *error = nil;
        if ([context save:&error]) {
            NSLog(@"The save was successful!");
        } else {
            NSLog(@"The save wasn't successful: %@", [error userInfo]);
        }
    
    [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        [self.navigationController popViewControllerAnimated:YES];
    }
        
}
- (void) dismiss {
    [self.navigationController popViewControllerAnimated:YES];

}



@end

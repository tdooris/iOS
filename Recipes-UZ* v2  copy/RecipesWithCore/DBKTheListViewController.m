//
//  DBKTheListViewController.m
//  RecipesWithCore
//
//  Created by Timothy Dooris on 11/2/13.
//  Copyright (c) 2013 Timothy Dooris. All rights reserved.
//
#import "DBKAppDelegate.h"
#import "DBKTheListViewController.h"
#import "Recipe.h"
#import "Ingredient.h"
#import "IngredientList.h"
#import "ShoppingList.h"


@interface DBKTheListViewController ()
@property Recipe *currentRecipe;
@property NSMutableArray *ingredientsArray;
@end

@implementation DBKTheListViewController
@synthesize  currentRecipe, ingredientsArray;

- (IBAction)clearList:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Warning" message:@"You are about to clear your shopping list." delegate: self cancelButtonTitle:@"No thanks." otherButtonTitles:@"Yes, clear it!", nil];
    [alert show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{ if (buttonIndex == 0)
    {
        NSLog(@"user pressed No Thanks");
    } else {
        [self clearAll];
    }
}

- (void) clearAll
{
    NSLog(@"It's working!!!");
    //How to clear all?
    
    //1. change checkmarks of all to 0.
    for (Ingredient *ingredient in ingredientsArray)
        ingredient.checkedOnList = [NSNumber numberWithBool:NO];
    
    //2.  find the parent shopping list and just assign .recipes to null
    
    Ingredient *ingredient = [ingredientsArray objectAtIndex:0];
    
    
    ingredient.ingredientList.recipe.shoppingList.recipes = nil;
    ingredientsArray = nil;
    [self.tableView reloadData];
    
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        NSLog(@"Ok init is being called.");
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    ingredientsArray = [NSMutableArray array];

    [self loadTableData];

}

- (void)viewDidLoad
{
    [super viewDidLoad];

  
    

    // Uncomment the following line to preserve selection between presentations.
       self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    NSManagedObjectContext *context = [[self appDelegate] managedObjectContext];
    NSError *error = nil;
    if ([context save:&error]) {
        NSLog(@"The save was successful!");
    } else {
        NSLog(@"The save wasn't successful: %@", [error userInfo]);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [ingredientsArray count];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//Put all ingredients from core shoppingList into an array so they are displayed!!
    // Configure the cell...
    NSString *ingredientName = [[NSString alloc] init];
    ingredientName = [[ingredientsArray objectAtIndex:indexPath.row] ingredientName];
    Ingredient *ingredient = [ingredientsArray objectAtIndex:indexPath.row];
//If ingredient.checkedOnList is yes, then you need to add the CellAccessoryCheckmark
    if (ingredient.checkedOnList == [NSNumber numberWithInt:1])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        NSLog(@"Adding a checkmark.");

    }
    NSLog(@"%@ is checked? %@", ingredientName, ingredient.checkedOnList);
    
    
    cell.textLabel.text = ingredientName;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //if it's already checked, then un-check it and change bool to no.
    if ([tableView cellForRowAtIndexPath:indexPath].accessoryType==UITableViewCellAccessoryCheckmark)
    {
        [tableView cellForRowAtIndexPath:indexPath].accessoryType=UITableViewCellAccessoryNone;
        Ingredient *ingredient = [ingredientsArray objectAtIndex:indexPath.row];
        ingredient.checkedOnList = [NSNumber numberWithBool:NO];
        NSLog(@"Did UNchecking %@ work? %@", ingredient.ingredientName, ingredient.checkedOnList);

        
    }
    else{
        [tableView cellForRowAtIndexPath:indexPath].accessoryType=UITableViewCellAccessoryCheckmark;
        Ingredient *ingredient = [ingredientsArray objectAtIndex:indexPath.row];
        ingredient.checkedOnList = [NSNumber numberWithBool:YES];
        NSLog(@"Did checking it off change the ingredient in the array? %@", ingredient.checkedOnList);


    }

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

- (DBKAppDelegate *)appDelegate {
    return ((DBKAppDelegate *)[[UIApplication sharedApplication] delegate]);
}

-(void) loadTableData
{

    NSLog(@"Checking for shoppingList and it's: %@",[[self appDelegate]theShoppingList]);
    
    //grab all Recipes from that shoppingList
    
    for (Recipe *recipe in [[self appDelegate]theShoppingList].recipes)
    {
    
        for (Ingredient *ingredient in recipe.ingredientList.ingredient)
        {
            [ingredientsArray addObject: ingredient];
        }
            
    }
    
}

@end

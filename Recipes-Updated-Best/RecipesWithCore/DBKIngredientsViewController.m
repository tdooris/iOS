//
//  DBKIngredientsViewController.m
//  RecipesWithCore
//
//  Created by Timothy Dooris on 11/1/13.
//  Copyright (c) 2013 Timothy Dooris. All rights reserved.
//

#import "DBKIngredientsViewController.h"
#import "DBKAddIngredientViewController.h"
#import "Recipe.h"
#import "DBKAppDelegate.h"
#import "IngredientList.h"

@interface DBKIngredientsViewController ()
@property NSArray *theRecipeArray;
@end

@implementation DBKIngredientsViewController
@synthesize ingredientsArray;
@synthesize targetRecipe;
@synthesize theRecipeArray;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    /* Here we call the method to load the table data */
    [self loadTableData];
    
    self.navigationItem.title = targetRecipe.recipeName;
    
}

- (void) viewDidLoad:(BOOL)animated
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStyleBordered target:self action:@selector(addIngredient)];
    self.navigationItem.rightBarButtonItem = item;

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
    static NSString *CellIdentifier = @"IngredientCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    //this might be wrong?!
    cell.textLabel.text = [ingredientsArray objectAtIndex:indexPath.row];
    return cell;
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
- (DBKAppDelegate *) appDelegate {
    return (DBKAppDelegate* )[[UIApplication sharedApplication] delegate];
}


- (void) loadTableData {
    
    NSManagedObjectContext *context = [[self appDelegate] managedObjectContext];
    
    // Construct a fetch request
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Recipe"
                                              inManagedObjectContext:context];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"recipeName==%@", targetRecipe.recipeName];

    [fetchRequest setPredicate:predicate];
    [fetchRequest setEntity:entity];

    
    NSError *error = nil;
    self.theRecipeArray = [context executeFetchRequest:fetchRequest error:&error];
    NSLog(@"The recipe you found was %@", [theRecipeArray objectAtIndex:0]);
    Recipe *foundRecipe = [theRecipeArray objectAtIndex:0];
    NSArray *ingredients = [foundRecipe.ingredientList.ingredient allObjects];
    ingredientsArray  = [ingredients valueForKey:@"ingredientName"];
    
    
    [self.tableView reloadData];
}

- (void) dismiss {
    [self.navigationController popViewControllerAnimated:YES];
    
}



- (void) addIngredient
{
    
    [self performSegueWithIdentifier:@"addIngredientSegue" sender:self];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"addIngredientSegue"]){
        
        DBKAddIngredientViewController *controller = (DBKAddIngredientViewController *)segue.destinationViewController;
        controller.thisRecipe = targetRecipe;
        NSLog(@"Pushing VC on top and passing %@", targetRecipe.recipeName);
        
    }
}






@end

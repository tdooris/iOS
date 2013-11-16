//
//  DBKRecipesViewController.m
//  RecipesWithCore
//
//  Created by Timothy Dooris on 11/1/13.
//  Copyright (c) 2013 Timothy Dooris. All rights reserved.
//

#import "DBKRecipesViewController.h"
#import "Recipe.h"
#import "DBKAppDelegate.h"
#import "DBKAddRecipeViewController.h"
#import "DBKIngredientsViewController.h"


@interface DBKRecipesViewController ()
@property Recipe *selectedRecipe;
@property (nonatomic, retain) NSMutableArray *filteredArray;


@end
@implementation DBKRecipesViewController
@synthesize recipesArray, selectedRecipe, filteredArray;


- (IBAction)enterEditMode:(id)sender {
    
    if ([self isEditing]){
        [sender setTitle:@"Edit"];
        [self setEditing:NO animated:YES];
        
    } else {
        [sender setTitle:@"Done"];
        [self setEditing:YES animated:YES];
    }
    
    
}


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
    
    //Not sure if this is the right place, but this will check for shopping list
    //if (there's no shopping list then...

    

    //[failedBankInfo setValue:@"Test Bank" forKey:@"name"];
    
    
    /* Here we call the method to load the table data */
    self.filteredArray =[NSMutableArray array];

    [self loadTableData];

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
    // Return the number of rows in the section
    return [filteredArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];    
    // Configure the cell...
    Recipe *recipe = [filteredArray objectAtIndex:indexPath.row];
    cell.textLabel.text = recipe.recipeName;
    
    return cell;
}
/*//Alternate colors
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row%2 == 0) {
        UIColor *altCellColor = [UIColor colorWithWhite:0.7 alpha:0.1];
        cell.backgroundColor = altCellColor;
    }
}
*/
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}




// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        NSString *str = cell.textLabel.text;
        

        
        NSManagedObjectContext *context = [[self appDelegate] managedObjectContext];
        NSError *error = nil;
        // Construct a fetch request
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Recipe"
                                                  inManagedObjectContext:context];
        
        [fetchRequest setEntity:entity];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"recipeName==%@", str];
        [fetchRequest setPredicate:predicate];
        NSArray *recipeToDelete = [context executeFetchRequest:fetchRequest error: &error];
        
        Recipe *recipe = [recipeToDelete objectAtIndex:0];
        
        //delete recipe from filteredArray
        [filteredArray removeObjectIdenticalTo:recipe];
        
        [context deleteObject: recipe];
        [context save:&error];
        
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


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

- (void) loadTableData {
    
    NSManagedObjectContext *context = [[self appDelegate] managedObjectContext];
    
    // Construct a fetch request
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Recipe"
                                              inManagedObjectContext:context];
    
    [fetchRequest setEntity:entity];
  /*
    // Add an NSSortDescriptor to sort the labels alphabetically
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    */
    
    NSError *error = nil;
    self.recipesArray = [context executeFetchRequest:fetchRequest error:&error];
#warning filtered warray
    for (Recipe * recipe in recipesArray)
    {
        [filteredArray addObject:recipe];
    }
    [self.tableView reloadData];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedRecipe = [filteredArray objectAtIndex:indexPath.row];
    NSLog(@"You have chosen %@", selectedRecipe.recipeName);
    [self performSegueWithIdentifier:@"showIngredientsSegue" sender:self];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"showIngredientsSegue"]){
        
        DBKIngredientsViewController *controller = (DBKIngredientsViewController *)segue.destinationViewController;
        controller.targetRecipe = selectedRecipe;

            }
}





@end

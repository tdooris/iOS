//
//  XYZRecipesViewController.m
//  Recipes
//
//  Created by Timothy Dooris on 10/30/13.
//  Copyright (c) 2013 Timothy Dooris. All rights reserved.
//

#import "XYZRecipesViewController.h"
#import "XYZRecipe.h"
#import "XYZAddRecipeViewController.h"

@interface XYZRecipesViewController ()

@property NSMutableArray *recipesList;

@end

@implementation XYZRecipesViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.recipesList = [[NSMutableArray alloc] init];
    [self loadInitialData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.recipesList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"XYZRecipeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    XYZRecipe *recipe = [self.recipesList objectAtIndex:indexPath.row];
    cell.textLabel.text = recipe.recipeName;
    
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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}


-(IBAction) unwindToRecipes:(UIStoryboardSegue *)segue{
    XYZAddRecipeViewController *source = [segue sourceViewController];
    XYZRecipe *recipe = source.recipe;
    if (recipe != nil){
        [self.recipesList addObject:recipe];
        [self.tableView reloadData];
    }
}
     
     -(void) loadInitialData
    {
        XYZRecipe *recipe1 = [[XYZRecipe alloc] init];
        recipe1.recipeName = @"Baked Orechiette";
        XYZRecipe *recipe2 = [[XYZRecipe alloc] init];
        
        
        
        recipe2.recipeName = @"Sun-dried Tomatoes w/Lemon Linguine";
        XYZRecipe *recipe3 = [[XYZRecipe alloc] init];
        recipe3.recipeName = @"Vegetarian Chili";
        [self.recipesList addObject:recipe1];
        [self.recipesList addObject:recipe2];
        [self.recipesList addObject:recipe3];
        
        
    }
     
     @end

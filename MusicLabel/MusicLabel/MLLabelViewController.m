//
//  MLBLLabelViewController.m
//  MusicLabel
//
//  Created by Carl Atupem on 5/7/13.
//  Copyright (c) 2013 StackMob. All rights reserved.
//

#import "MLLabelViewController.h"
//#import "MLArtistViewController.h"
//#import "MLLabelEntryViewController.h"

@interface MLBLLabelViewController ()

@end

/* Make these changes to MLBLLabelViewController.M */

@implementation MLBLLabelViewController

@synthesize labelArray;


- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    /* Here we call the method to load the table data */
    [self loadTableData];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItem)];
    
    self.navigationItem.rightBarButtonItem = item;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // We only need to return 1 for this table view
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // We'll return the count of the objects in labelArray
    return [labelArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    // Grab the label
    Label *label = [self.labelArray objectAtIndex:indexPath.row];
    // Set the text of the cell to the label name
    cell.textLabel.text = label.name;
    
    return cell;
}

// Add this method for slide to delete
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return UITableViewCellEditingStyleDelete;
    
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        NSManagedObjectContext *context = [[self appDelegate] managedObjectContext];
        
        // Grab the label
        Label *label = [self.labelArray objectAtIndex:indexPath.row];
        
        [context deleteObject:[context objectWithID:[label objectID]]];
        
        // Save everything
        NSError *error = nil;
        if ([context save:&error]) {
            NSLog(@"The save was successful!");
        } else {
            NSLog(@"The save wasn't successful: %@", [error userInfo]);
        }
        
        NSMutableArray *array = [self.labelArray mutableCopy];
        [array removeObjectAtIndex:indexPath.row];
        self.labelArray = array;
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


#pragma mark - Private methods
- (MLAppDelegate *)appDelegate {
    return (MLAppDelegate *)[[UIApplication sharedApplication] delegate];
}

// This method executes a fetch request and reloads the table view.
- (void) loadTableData {
    
    NSManagedObjectContext *context = [[self appDelegate] managedObjectContext];
    
    // Construct a fetch request
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Label"
                                              inManagedObjectContext:context];
    
    [fetchRequest setEntity:entity];
    
    // Add an NSSortDescriptor to sort the labels alphabetically
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    
    NSError *error = nil;
    self.labelArray = [context executeFetchRequest:fetchRequest error:&error];
    [self.tableView reloadData];
}
/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MLBLArtistViewController *artistViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ArtistViewController"];
    
    // Grab the label
    Label *label = [self.labelArray objectAtIndex:indexPath.row];
    
    artistViewController.labelID = [label objectID];
    
    [self.navigationController pushViewController:artistViewController animated:YES];
}

- (void) addItem {
    
    MLBLLabelEntryViewController *labelEntryViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LabelEntryViewController"];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:labelEntryViewController];
    
    [self presentViewController:navigationController animated:YES completion:nil];
    
}
*/
@end
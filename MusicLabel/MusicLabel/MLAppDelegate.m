//
//  MLAppDelegate.m
//  MusicLabel
//
//  Created by Timothy Dooris on 10/29/13.
//  Copyright (c) 2013 Timothy Dooris. All rights reserved.
//

#import "MLAppDelegate.h"
#import "Label.h"
#import "Artist.h"
#import "Album.h"


@implementation MLAppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self create];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"MusicLabel" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"MusicLabel.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark - Private methods

- (void) create {
    // Grab the context
    NSManagedObjectContext *context = [self managedObjectContext];
    
    // Grab the Label entity
    Label *label = [NSEntityDescription insertNewObjectForEntityForName:@"Label" inManagedObjectContext:context];
    
    // Set label name
    label.name = @"Diplomat Records";
    
    // Create a Date
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY"];
    NSDate *dateFounded = [dateFormatter dateFromString:@"2003"];
    
    // Set the year founded for the label
    label.founded = dateFounded;
    
    // Set the label genre
    label.genre = @"Rap/Hip-hop";
    
    // Insert the Artist entity
    Artist *artist = [NSEntityDescription insertNewObjectForEntityForName:@"Artist" inManagedObjectContext:context];
    
    // Set the artist attributes
    artist.name = @"Cam'Ron";
    artist.hometown = @"Harlem, NY";
    
    // Insert Album entity
    Album *album = [NSEntityDescription insertNewObjectForEntityForName:@"Album" inManagedObjectContext:context];
    
    // Set album attributes
    album.title = @"Come Home With Me";
    NSDate *releaseDate = [dateFormatter dateFromString:@"2002"];
    album.released = releaseDate;
    
    // Set relationships
    [label addArtistsObject:artist];
    [artist setLabel:label];
    [artist addAlbumsObject:album];
    [album setArtist:artist];
    
    // Save everything
    NSError *error = nil;
    if ([context save:&error]) {
        NSLog(@"The save was successful!");
    } else {
        NSLog(@"The save wasn't successful: %@", [error userInfo]);
    }
}


- (void) read {
    NSManagedObjectContext *context = [self managedObjectContext];
    
    // Construct a fetch request
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Label"
                                              inManagedObjectContext:context];
    
    [fetchRequest setEntity:entity];
    NSError *error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    for (Label *label in fetchedObjects) {
        // Log the label details
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"YYYY"];
        
        NSLog(@"%@, est. %@ (%@)", label.name, [dateFormatter stringFromDate:label.founded], label.genre);
        
        NSLog(@"\tArtists:");
        NSSet *artists = label.artists;
        for (Artist *artist in artists) {
            // Log the artist details
            NSLog(@"\t\t%@ (%@)", artist.name, artist.hometown);
            
            NSLog(@"\t\t\tAlbums:");
            NSSet *albums = artist.albums;
            for (Album *album in albums) {
                // Log the album details
                NSLog(@"\t\t\t\t%@ (%@)", album.title,  [dateFormatter stringFromDate:album.released]);
            }
        }
    }
}

- (void) update {
    // Grab the context
    NSManagedObjectContext *context = [self managedObjectContext];
    
    // Perform fetch request
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Label"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    // Date formatter comes in handy
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY"];
    
    // Grab the label
    Label *label = [fetchedObjects objectAtIndex:0];
    
    // Juelz Santana
    Artist *juelz = [NSEntityDescription insertNewObjectForEntityForName:@"Artist" inManagedObjectContext:context];
    juelz.name = @"Juelz Santana";
    juelz.hometown = @"Harlem, NY";
    
    // Juelz Santana albums
    Album *juelzAlbum = [NSEntityDescription insertNewObjectForEntityForName:@"Album" inManagedObjectContext:context];
    juelzAlbum.title = @"From Me to U";
    juelzAlbum.released = [dateFormatter dateFromString:@"2003"];
    [juelzAlbum setArtist:juelz];
    
    Album *juelzAlbum2 = [NSEntityDescription insertNewObjectForEntityForName:@"Album" inManagedObjectContext:context];
    juelzAlbum2.title = @"What The Game's Been Missing!";
    juelzAlbum2.released = [dateFormatter dateFromString:@"2005"];
    [juelzAlbum2 setArtist:juelz];
    
    // Set relationships
    [juelz addAlbums:[NSSet setWithObjects:juelzAlbum, juelzAlbum2, nil]];
    
    
    // Jim Jones
    Artist *jimmy = [NSEntityDescription insertNewObjectForEntityForName:@"Artist" inManagedObjectContext:context];
    jimmy.name = @"Jim Jones";
    jimmy.hometown = @"Harlem, NY";
    
    // Jim Jones albums
    Album *jimmyAlbum = [NSEntityDescription insertNewObjectForEntityForName:@"Album" inManagedObjectContext:context];
    jimmyAlbum.title = @"On My Way to Church";
    jimmyAlbum.released = [dateFormatter dateFromString:@"2004"];
    [jimmyAlbum setArtist:jimmy];
    
    Album *jimmyAlbum2 = [NSEntityDescription insertNewObjectForEntityForName:@"Album" inManagedObjectContext:context];
    jimmyAlbum2.title = @"Harlem: Diary of a Summer";
    jimmyAlbum2.released = [dateFormatter dateFromString:@"2005"];
    [jimmyAlbum2 setArtist:jimmy];
    
    Album *jimmyAlbum3 = [NSEntityDescription insertNewObjectForEntityForName:@"Album" inManagedObjectContext:context];
    jimmyAlbum3.title = @"Hustler's P.O.M.E. (Product of My Environment)";
    jimmyAlbum3.released = [dateFormatter dateFromString:@"2006"];
    [jimmyAlbum3 setArtist:jimmy];
    
    // Set relationships
    [jimmy addAlbums:[NSSet setWithObjects:jimmyAlbum, jimmyAlbum2, jimmyAlbum3, nil]];
    
    
    // Freekey Zekey
    Artist *freekey = [NSEntityDescription insertNewObjectForEntityForName:@"Artist" inManagedObjectContext:context];
    freekey.name = @"Freekey Zekey";
    freekey.hometown = @"Harlem, NY";
    
    Album *freekeyAlbum = [NSEntityDescription insertNewObjectForEntityForName:@"Album" inManagedObjectContext:context];
    freekeyAlbum.title = @"Book of Ezekiel";
    freekeyAlbum.released = [dateFormatter dateFromString:@"2007"];
    [freekeyAlbum setArtist:freekey];
    [freekey addAlbumsObject:freekeyAlbum];
    
    // Set relationships
    [label addArtists:[NSSet setWithObjects:juelz, jimmy, freekey, nil]];
    
    // Save everything
    if ([context save:&error]) {
        NSLog(@"The save was successful!");
    } else {
        NSLog(@"The save wasn't successful: %@", [error localizedDescription]);
    }
}

- (void) delete {
    // Grab the context
    NSManagedObjectContext *context = [self managedObjectContext];
    
    //  We're looking to grab an artist
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Artist"
                                              inManagedObjectContext:context];
    
    [fetchRequest setEntity:entity];
    
    // We specify that we only want Freekey Zekey
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", @"Freekey Zekey"];
    [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    // Grab the artist and delete
    Artist *freekey = [fetchedObjects objectAtIndex:0];
    [freekey.label removeArtistsObject:freekey];
    
    // Save everything
    if ([context save:&error]) {
        NSLog(@"The save was successful!");
    } else {
        NSLog(@"The save wasn't successful: %@", [error localizedDescription]);
    }
}



@end


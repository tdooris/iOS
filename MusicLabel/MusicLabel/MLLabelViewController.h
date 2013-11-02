//
//  MLLabelViewController.h
//  MusicLabel
//
//  Created by Timothy Dooris on 10/29/13.
//  Copyright (c) 2013 Timothy Dooris. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "MLAppDelegate.h"
#import "Label.h"

@interface MLBLLabelViewController : UITableViewController

// An array to house all of our fetched Label objects
@property (strong, nonatomic) NSArray *labelArray;

@end

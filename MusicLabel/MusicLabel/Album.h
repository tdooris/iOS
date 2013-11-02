//
//  Album.h
//  MusicLabel
//
//  Created by Timothy Dooris on 10/29/13.
//  Copyright (c) 2013 Timothy Dooris. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Artist;

@interface Album : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * released;
@property (nonatomic, retain) Artist *artist;

@end

//
//  Artist.h
//  MusicLabel
//
//  Created by Carl Atupem on 11/6/12.
//  Copyright (c) 2012 StackMob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Label;

@interface Artist : NSManagedObject

@property (nonatomic, retain) NSString * hometown;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Label *label;
@property (nonatomic, retain) NSSet *albums;
@end

@interface Artist (CoreDataGeneratedAccessors)

- (void)addAlbumsObject:(NSManagedObject *)value;
- (void)removeAlbumsObject:(NSManagedObject *)value;
- (void)addAlbums:(NSSet *)values;
- (void)removeAlbums:(NSSet *)values;

@end

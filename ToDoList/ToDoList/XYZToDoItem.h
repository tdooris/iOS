//
//  XYZToDoItem.h
//  ToDoList
//
//  Created by Timothy Dooris on 10/30/13.
//  Copyright (c) 2013 Timothy Dooris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYZToDoItem : NSObject

@property NSString *itemName;
@property BOOL completed;
@property (readonly) NSDate *creationDate;

@end

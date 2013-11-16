//
//  DBKRecipeCell.m
//  RecipesWithCore
//
//  Created by Timothy Dooris on 11/5/13.
//  Copyright (c) 2013 Timothy Dooris. All rights reserved.
//

#import "DBKRecipeCell.h"

@implementation DBKRecipeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

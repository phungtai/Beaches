//
//  Cell.m
//  BeachesIntroduction
//
//  Created by Mac on 10/23/13.
//  Copyright (c) 2013 MAC. All rights reserved.
//

#import "Cell.h"

@implementation Cell
@synthesize name, imageView, star, description;
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

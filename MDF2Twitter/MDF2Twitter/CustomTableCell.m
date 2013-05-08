//
//  CustomTableCell.m
//  MDF2Twitter
//
//  Created by Rueben Anderson on 2/12/13.
//  Copyright (c) 2013 Rueben Anderson. All rights reserved.
//

#import "CustomTableCell.h"

@implementation CustomTableCell

@synthesize cellDateLabel, cellTextLabel;

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

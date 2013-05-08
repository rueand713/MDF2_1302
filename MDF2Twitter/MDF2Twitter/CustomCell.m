//
//  CustomCell.m
//  MDF2Twitter
//
//  Created by Rueben Anderson on 2/13/13.
//  Copyright (c) 2013 Rueben Anderson. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

@synthesize tweetLabel, dateLabel, imageView;

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

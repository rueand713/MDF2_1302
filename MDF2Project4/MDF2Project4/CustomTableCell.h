//
//  CustomTableCell.h
//  MDF2Project4
//
//  Created by Rueben Anderson on 2/26/13.
//  Copyright (c) 2013 Rueben Anderson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableCell : UITableViewCell
{
    IBOutlet UILabel *movieTitle;
    IBOutlet UILabel *movieTimes;
    IBOutlet UIImageView *movieIcon;
}

@property (nonatomic, strong) UILabel *movieTitle;
@property (nonatomic, strong) UILabel *movieTimes;
@property (nonatomic, strong) UIImageView *movieIcon;

@end

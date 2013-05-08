//
//  CustomCell.h
//  MDF2Twitter
//
//  Created by Rueben Anderson on 2/13/13.
//  Copyright (c) 2013 Rueben Anderson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell
{
    IBOutlet UILabel *tweetLabel;
    IBOutlet UILabel *dateLabel;
    IBOutlet UIImageView *imageView;
}

@property (nonatomic, strong) UILabel *tweetLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UIImageView *imageView;

@end

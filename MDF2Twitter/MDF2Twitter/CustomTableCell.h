//
//  CustomTableCell.h
//  MDF2Twitter
//
//  Created by Rueben Anderson on 2/12/13.
//  Copyright (c) 2013 Rueben Anderson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableCell : UITableViewCell
{
    NSString *cellTextLabel;
    NSString *cellDateLabel;
}

@property (nonatomic, strong) NSString *cellTextLabel;
@property (nonatomic, strong) NSString *cellDateLabel;

@end

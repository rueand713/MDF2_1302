//
//  CustomHeaderLabel.h
//  MDF2Project4
//
//  Created by Rueben Anderson on 2/26/13.
//  Copyright (c) 2013 Rueben Anderson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomHeaderLabel : UIView
{
    IBOutlet UILabel *theatreName;
    IBOutlet UILabel *theatreLocation;
    IBOutlet UIImageView *theatreImage;
}

@property (nonatomic, strong) UILabel *theatreName;
@property (nonatomic, strong) UILabel *theatreLocation;
@property (nonatomic, strong) UIImageView *theatreImage;

@end

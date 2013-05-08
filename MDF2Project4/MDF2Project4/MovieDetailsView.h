//
//  MovieDetailsView.h
//  MDF2Project4
//
//  Created by Rueben Anderson on 2/26/13.
//  Copyright (c) 2013 Rueben Anderson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieDetailsView : UIViewController
{
    IBOutlet UILabel *titleLabel;
    IBOutlet UIImageView *imageView;
    IBOutlet UILabel *showtimesLabel;
    
    NSArray *movie;
}

-(IBAction)onClick:(id)sender;

@property (nonatomic, strong) NSArray *movie;

@end

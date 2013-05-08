//
//  DetailViewController.h
//  MDF2Twitter
//
//  Created by Rueben Anderson on 2/12/13.
//  Copyright (c) 2013 Rueben Anderson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
{
    NSDictionary *twitterData;
    
    IBOutlet UITextView *tweetTextView;
    IBOutlet UILabel *userHeaderLabel;
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *timeDateLabel;
    
    
}

@property (nonatomic, strong) NSDictionary *twitterData;

- (IBAction)onClick:(id)sender;

@end

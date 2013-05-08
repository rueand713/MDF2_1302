//
//  UserDetailsView.h
//  MDF2Twitter
//
//  Created by Rueben Anderson on 2/14/13.
//  Copyright (c) 2013 Rueben Anderson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserDetailsView : UIViewController
{
    IBOutlet UILabel *usernameLabel;
    IBOutlet UILabel *nameLabel;
    IBOutlet UITextView *descriptionView;
    IBOutlet UILabel *followersLabel;
    IBOutlet UILabel *followingLabel;
    IBOutlet UILabel *tweetsLabel;
    IBOutlet UIImageView *imageView;
    
    NSDictionary *tweetionary;
    UIImage *userImage;
}

@property (nonatomic, strong) NSDictionary *tweetionary;
@property (nonatomic, strong) UIImage *userImage;

-(IBAction)onClick:(id)sender;

@end

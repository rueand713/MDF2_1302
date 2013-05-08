//
//  UserDetailsView.m
//  MDF2Twitter
//
//  Created by Rueben Anderson on 2/14/13.
//  Copyright (c) 2013 Rueben Anderson. All rights reserved.
//

#import "UserDetailsView.h"

@interface UserDetailsView ()

@end

@implementation UserDetailsView

@synthesize tweetionary, userImage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    NSString *userName = [[tweetionary objectForKey:@"user"] objectForKey:@"screen_name"];
    
    if (userName)
    {
        // set the label text to the username
        usernameLabel.text = userName;
    }
    
    NSString *name = [[NSString alloc] initWithFormat:@"Name: %@", [[tweetionary objectForKey:@"user"] objectForKey:@"name"]];
    
    if (name)
    {
        // set the label text to the name
        nameLabel.text = name;
    }
    
    NSString *description = [[tweetionary objectForKey:@"user"] objectForKey:@"description"];
    
    if (description)
    {
        // set the textview text to the description
        descriptionView.text = description;
    }
    
    id followers = [[tweetionary objectForKey:@"user"] objectForKey:@"followers_count"];
    
    if (followers)
    {
        // set the followers
        followersLabel.text = [NSString stringWithFormat:@"%@", followers];
    }
    
    id following = [[tweetionary objectForKey:@"user"] objectForKey:@"friends_count"];
    
    if (following)
    {
        // set the number of following
        followingLabel.text = [NSString stringWithFormat:@"%@", following];
    }
    
    id numTweets = [[tweetionary objectForKey:@"user"] objectForKey:@"statuses_count"];
    
    if (numTweets)
    {
        // set the number of tweets
        tweetsLabel.text = [NSString stringWithFormat:@"%@", numTweets];
    }
    
    if (userImage != nil)
    {
        // set the image to the passed in image from the user timeline
        imageView.image = userImage;
    }
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)onClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    if (btn)
    {
        // dismiss the current view and return to the main feed view
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end

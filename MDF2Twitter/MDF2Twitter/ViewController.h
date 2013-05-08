//
//  ViewController.h
//  MDF2Twitter
//
//  Created by Rueben Anderson on 2/12/13.
//  Copyright (c) 2013 Rueben Anderson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Accounts/Accounts.h>
#import <Twitter/Twitter.h>
#import "DetailViewController.h"
#import "CustomCell.h"
#import "UserDetailsView.h"

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate,NSURLConnectionDataDelegate>
{
    IBOutlet UITableView *twitterFeed;
    
    NSArray *twitterArray;
    ACAccount *currentAccount;
    UIAlertView *loadingAlert;
    NSMutableData *requestData;
    UIImage *userImage;
    NSString *imageLink;
    NSURLConnection *connection;
    
    BOOL viewHasAppeared;
    BOOL connectionSent;
}

- (IBAction)onClick:(id)sender;
-(void)retrieveFeed;
-(UIAlertView *)showProgressView;

@end

//
//  ViewController.m
//  practiceAccounts
//
//  Created by Rueben Anderson on 2/12/13.
//  Copyright (c) 2013 Rueben Anderson. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize username;

- (void)viewDidLoad
{
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    
    if (accountStore)
    {
        ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
        
        if (accountType)
        {
            [accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error) {
                    if (granted)
                    {
                        NSArray *twitterAccounts = [accountStore accountsWithAccountType:accountType];
                        
                        if (twitterAccounts)
                        {
                            ACAccount *currentAccount = [twitterAccounts objectAtIndex:0];
                            
                            if (currentAccount)
                            {
                                
                                NSURL *urlTimeline = [[NSURL alloc] initWithString:@"https://api.twitter.com/1.1/statuses/user_timeline.json"];
                                
                                if (urlTimeline)
                                {
                                    TWRequest *request = [[TWRequest alloc] initWithURL:urlTimeline parameters:nil requestMethod:TWRequestMethodGET];
                                    
                                    if (request)
                                    {
                                        // set the request account to be the current account
                                        [request setAccount:currentAccount];
                                        
                                        [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                                            
                                            if ([urlResponse statusCode] == 200)
                                            {
                                                NSError *jsonError = nil;
                                                NSArray *info = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&jsonError];
                                                
                                                if (info)
                                                {
                                                    NSDictionary *thisTweet = [info objectAtIndex:0];
                                                    
                                                    if (thisTweet)
                                                    {
                                                        NSLog(@"%@", [thisTweet objectForKey:@"text"]);
                                                    }
                                                }
                                            }
                                        }];
                                    }
                                }
                            }
                        }
                    }
                }];
        }
    }
    
    // still out of scope...
    //NSLog(@"%@", username);
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    TWTweetComposeViewController *controller = [[TWTweetComposeViewController alloc] init];
    
    if (controller)
    {
        [controller setInitialText:@"This is my text"];
        
        [self presentViewController:controller animated:YES completion:nil];
        
        controller.completionHandler = ^(TWTweetComposeViewControllerResult res)
        {
            if (res == TWTweetComposeViewControllerResultDone)
            {
                NSLog(@"Message posted!");
            }
            else if (res == TWTweetComposeViewControllerResultCancelled)
            {
                NSLog(@"Message Cancelled!");
            }
        };
    }
    
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

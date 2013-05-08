//
//  DetailViewController.m
//  MDF2Twitter
//
//  Created by Rueben Anderson on 2/12/13.
//  Copyright (c) 2013 Rueben Anderson. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize twitterData;

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
    NSString *userName = [[twitterData objectForKey:@"user"] objectForKey:@"screen_name"];
    NSString *name = [[NSString alloc] initWithFormat:@"%@:", [[twitterData objectForKey:@"user"] objectForKey:@"name"]];
    NSString *tweet = [twitterData objectForKey:@"text"];
    NSString *date = [twitterData objectForKey:@"created_at"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    if (formatter)
    {
        // set the date format
        [formatter setDateFormat:@"EEE MM dd yyyy hh:mm aaa"];
        
        NSString *dateString = [formatter stringFromDate:(NSDate *)date];
        
        // if the dateString has been created properly with the formatted date
        // set the label to that otherwise set the label to the default styling
        if (dateString)
        {
            // set the time/Date label text to the formatted date string
            timeDateLabel.text = dateString;
        }
        else
        {
            // set the time/date label text to the unformatted date string
            timeDateLabel.text = date;
        }
    }
    
    // set the label text from the passed in twitter data
    nameLabel.text = name;
    userHeaderLabel.text = userName;
    tweetTextView.text = tweet;

    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated
{
        
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onClick:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    
    if (btn)
    {
        // dismiss the view and return to the tweets view
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end

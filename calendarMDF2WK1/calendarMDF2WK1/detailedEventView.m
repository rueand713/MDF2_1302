//
//  detailedEventView.m
//  calendarMDF2WK1
//
//  Created by Rueben Anderson on 2/6/13.
//  Copyright (c) 2013 Rueben Anderson. All rights reserved.
//

#import "detailedEventView.h"

@interface detailedEventView ()

@end

@implementation detailedEventView

@synthesize eventDate, eventLocation, eventTime, eventTitle, scheduleDelegate;

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
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    titleLabel.text = eventTitle;
    locationLabel.text = eventLocation;
    
    // formatter for the time string
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    if (formatter)
    {
        [formatter setDateFormat:@"HH:mm zzz"];
        
        // create a date string from the formatted
        timeLabel.text = [formatter stringFromDate:(NSDate*)eventDate];
        
        // set the format for the date
        [formatter setDateFormat:@"MM-dd-yyyy"];
        
         dateLabel.text = [formatter stringFromDate:(NSDate*)eventDate];;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)onClick:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    
    if (btn)
    {
        // dismiss the view and return to the eventList view
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


@end

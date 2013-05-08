//
//  detailedFictionalEventView.m
//  calendarMDF2WK1
//
//  Created by Rueben Anderson on 2/7/13.
//  Copyright (c) 2013 Rueben Anderson. All rights reserved.
//

#import "detailedFictionalEventView.h"

@interface detailedFictionalEventView ()

@end

@implementation detailedFictionalEventView

@synthesize defaultCalendar, passedEvent;

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
    NSLog(@"%@", [passedEvent description]);
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    // set the detail view label texts
    titleLabel.text = [passedEvent objectAtIndex:0];
    locationLabel.text = [passedEvent objectAtIndex:1];
    
    // formatter for the time string
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    if (dateFormatter)
    {
        // set the format for the date
        [dateFormatter setDateFormat:@"MM-dd-yyyy"];
        
        // set the label text to display the formatted NSDate
        dateLabel.text = [dateFormatter stringFromDate:[passedEvent objectAtIndex:2]];
        
        // set the format for the time
        [dateFormatter setDateFormat:@"HH:mm zzz"];
        
        // create a date string from the formatted NSDate
        timeLabel.text = [dateFormatter stringFromDate:[passedEvent objectAtIndex:3]];
    }
    
    
    [super viewDidAppear:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)onClick:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    
    if (btn && btn.tag == 0)
    {
        UIAlertView *savePrompt = [[UIAlertView alloc] initWithTitle:@"Confirmation" message:@"Are you sure you want to add the current event?" delegate:self cancelButtonTitle:@"Don't Save" otherButtonTitles:@"Save", nil];
        
        if (savePrompt)
        {
            // show the AlertView
            [savePrompt show];
        }
    }
    else
    {
        // dismiss the view and return to the eventList view
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        // call the method for creating events
        [self makeEvent:passedEvent];
        
        // dismiss the view and return to the eventList view
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

-(void)makeEvent:(NSArray*)eventObject
{
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    
    if (eventStore != nil)
    {
        [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error)
         {
             if (granted)
             {
                 NSString *timeString;
                 
                 // date object of the current date, ending date
                 // date object to be formatted for only the time
                 NSDate *startDate = [NSDate date];
                 NSDate *endDate = [eventObject objectAtIndex:2];
                // NSDate *time = [eventObject objectAtIndex:3];
                 
                 // formatter for the time string
                 NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                 
                 if (formatter)
                 {
                     [formatter setDateFormat:@"HH:mm zzz"];
                     
                     // create a date string from the formatted
                     timeString = [formatter stringFromDate:startDate];
                 }
                 
                 // the event title and location data being extracted from the
                 // passed in NSArray object
                 NSString *eventTitle = [eventObject objectAtIndex:0];
                 NSString *eventLocation = [eventObject objectAtIndex:1];
                 
                 
                 // begin event creation
                 EKEvent *newEvent = [EKEvent eventWithEventStore:eventStore];
                 
                 if (newEvent)
                 {
                     // set the new events properties
                     newEvent.title = eventTitle;
                     newEvent.location = eventLocation;
                     newEvent.startDate = startDate;
                     newEvent.endDate = endDate;
                     
                     // fetch the list of calendars
                     NSArray *calendars = [eventStore calendarsForEntityType:EKEntityTypeEvent];
                     
                     // create an empty array to hold the default cal and an empty string to hold the calender id
                     NSArray *defaultCal;
                     NSString *calId;
                     
                     if (calendars)
                     {
                         // iterate through the calendars looking for the calendar with a matching title
                         for (int i=0; i<[calendars count]; i++)
                         {
                             // create an EKEvent item object for title querying
                             EKCalendar *item = [calendars objectAtIndex:i];
                             
                             // check for a matching title string
                             if ([item.title isEqualToString:defaultCalendar])
                             {
                                 calId = item.calendarIdentifier;
                                 
                                 // match found initialize that empty array with the calendar item
                                 defaultCal = [[NSArray alloc] initWithObjects:item, nil];
                             }
                         }
                     }
                     
                     NSError *error;
                     
                     // save the event in the selected calendar
                     newEvent.calendar = [eventStore calendarWithIdentifier:calId];//[defaultCal objectAtIndex:0];
                     [eventStore saveEvent:newEvent span:EKSpanThisEvent commit:YES error:&error];
                 }
             }
             
         }];
    }
    
}


@end

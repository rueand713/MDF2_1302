//
//  ViewController.m
//  calendarMDF2WK1
//
//  Created by Rueben Anderson on 2/5/13.
//  Copyright (c) 2013 Rueben Anderson. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize  calArr;

- (void)viewDidLoad
{
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    
    if (eventStore != nil)
    {
        [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error)
         {
             if (granted)
             {
                 NSArray *calendars = [eventStore calendarsForEntityType:EKEntityTypeEvent];
                 
                 if (calendars)
                 {
                     NSUserDefaults *saveCal = [NSUserDefaults standardUserDefaults];
                     
                     if (saveCal)
                     {
                         for (int i=0; i<[calendars count]; i++)
                         {
                             EKEvent *event = [calendars objectAtIndex:i];
                             NSString *eventString = [[NSString alloc] initWithFormat:@"_eventstore %i", i];
                             
                             [saveCal setValue:event.title forKey:eventString];
                             
                             [saveCal synchronize];
                         }
                     }
                 }
             }
             
         }];
    }
    
    // create the swipe gesture functionality for the label
    swiper = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeToScreen:)];
    swiper.direction = UISwipeGestureRecognizerDirectionRight;
    [swipeRightLabel addGestureRecognizer:swiper];
    
    // set the default firstRun attempt to yes and nil the default calendar
    firstRun = @"yes";
    defaultCalendar = nil;
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    // create a NSUserDefault object for loading the defaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // if the object is created and this is not the first time the application has run
    // the current calendar will be loaded into the defaults. this will be done each time the
    // screen returns from selecting the default calendar. the first run check is to ensure no
    // null data is loaded as a NSUserDefault
    if (defaults)
    {
        NSString *defFRTemp = [defaults objectForKey:@"firstRun"];
        
        // check to make sure the firstRun is not nil
        if (defFRTemp != nil)
        {
            // load the firstRun value from the defaults dictionary
            firstRun = [defaults objectForKey:@"firstRun"];
        }
        
        NSString *defCalTemp = [defaults objectForKey:@"calendar"];
        
        // check to make sure the calendar is not nil
        if (defCalTemp != nil)
        {
            // load the selected calendar from the defaults dictionary
            defaultCalendar = [defaults objectForKey:@"calendar"];
            
            // set the calendar label text
            currentCalendarLabel.text = defaultCalendar;
        }
        
        
    }
    else if (!firstRun || [firstRun isEqualToString:@"yes"])
    {
        // the app has ran once now so set the firstRun variable to no
        firstRun = @"no";
    }

    
    [super viewDidAppear:YES];
}

// callback function from the custom delegate
-(void) calWarp:(NSString*)defCal
{
    // set the local string to the passed in selected string value
    defaultCalendar = defCal;
    
    // create a NSUserDefault object for saving the default calendar
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // if the defaults object is created properly proceed to save the data to defaults
    if (defaults)
    {
        // save the selected calendar into the defaults dictionary and the firstRun value
        [defaults setObject:defaultCalendar forKey:@"calendar"];
        [defaults setObject:firstRun forKey:@"firstRun"];
        
        // commit the save
        [defaults synchronize];
    }
}

-(void)swipeToScreen:(UISwipeGestureRecognizer*)recognizer
{
    // if the label is swiped right and a default calendar has been selected the event view will be presented
    if (recognizer.direction == UISwipeGestureRecognizerDirectionRight && defaultCalendar != nil)
    {
        eventListView *eventList = [[eventListView alloc] initWithNibName:@"eventListView" bundle:nil];
        
        if (eventList)
        {
            // pass in the retrieved/selected calendar
            eventList.defaultCalendar = defaultCalendar;
            
            [self presentViewController:eventList animated:YES completion:nil];
        }
    }
}

-(IBAction)onClick:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    
    if (btn)
    {
        chooseCalendarView *calendarView = [[chooseCalendarView alloc] initWithNibName:@"chooseCalendarView" bundle:nil];
        
        if (calendarView)
        {
            // set the callback handler to self
            calendarView.calDelegate = self;
            
            // call the calendar view
            [self presentViewController:calendarView animated:YES completion:nil];
        }
    }
}



@end

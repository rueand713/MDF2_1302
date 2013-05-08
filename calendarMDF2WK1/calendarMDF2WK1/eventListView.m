//
//  eventListView.m
//  calendarMDF2WK1
//
//  Created by Rueben Anderson on 2/6/13.
//  Copyright (c) 2013 Rueben Anderson. All rights reserved.
//

#import "eventListView.h"

@interface eventListView ()

@end

@implementation eventListView

@synthesize events, defaultCalendar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        reloadTable = NO;
        
        // fetch the events data
        [self fetchData];
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
    eventStore = [[EKEventStore alloc] init];
    
    if (eventStore != nil)
    {
        [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error)
         {
             if (granted)
             {
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
                 
                 // create a date object of the current date
                 NSDate *today = [NSDate date];
                 
                 // create a date object of the date one year from today
                 NSDate *yrLater = [[NSDate date] dateByAddingTimeInterval:86400];
                 
                 NSPredicate *predicate = [eventStore predicateForEventsWithStartDate:today endDate:yrLater calendars:defaultCal];
                 
                 NSArray *predicateEvents = [eventStore eventsMatchingPredicate:predicate];
                 
                 if (predicateEvents)
                 {
                     NSUserDefaults *eventData = [NSUserDefaults standardUserDefaults];
                     
                     if (eventData)
                     {
                         for (int i=0; i<[predicateEvents count]; i++)
                        {
                            EKEvent *event = [predicateEvents objectAtIndex:i];
                            NSString *eventTitle = [[NSString alloc] initWithFormat:@"_event %i title", i];
                            NSString *eventLocation = [[NSString alloc] initWithFormat:@"_event %i location", i];
                            NSString *eventEndDate = [[NSString alloc] initWithFormat:@"_event %i end", i];
                            NSString *eventStartDate = [[NSString alloc] initWithFormat:@"_event %i start", i];
                            
                            [eventData setValue:event.title forKey:eventTitle];
                            [eventData setValue:event.location forKey:eventLocation];
                            [eventData setValue:event.endDate forKey:eventEndDate];
                            [eventData setObject:event.startDate forKey:eventStartDate];
                            
                            [eventData synchronize];
                        }
                     }
                 }
             }
             
         }];
    }
    
    // set the label text to the default calendar string
    calendarName.text = defaultCalendar;
    
    // fetch the event data
    [self fetchData];
    
    if (reloadTable)
    {
        // refresh the table
        [eventsTableView reloadData];
        
        // set the table to not refresh next time
        reloadTable = NO;
    }
    
    [super viewDidAppear:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // return the number of rows based on the number of events
    return [events count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell";
    
    UITableViewCell *cell = [eventsTableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil)
    {
        // create a new cell if the previous method resulted in nil
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
       /* NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:nil options:nil];
        
        for (UIView *view in views)
        {
            if ([view isKindOfClass:[customCell class]])
            {
                cell = (customCell*)view;
            }
        }*/
    }
    
    // set the cell text to the text of the events
    cell.textLabel.text = [[events objectAtIndex:indexPath.row] objectAtIndex:0];
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    detailedEventView *detailView = [[detailedEventView alloc] initWithNibName:@"detailedEventView" bundle:nil];
    
    if (detailView)
    {
        // set data in the detail view
        detailView.eventTitle = [[events objectAtIndex:indexPath.row] objectAtIndex:0];
        detailView.eventTime = [[events objectAtIndex:indexPath.row] objectAtIndex:3];
        detailView.eventLocation = [[events objectAtIndex:indexPath.row] objectAtIndex:1];
        detailView.eventDate = [[events objectAtIndex:indexPath.row] objectAtIndex:2];
        
        // call the detail view
        [self presentViewController:detailView animated:YES completion:nil];
    }
}

-(IBAction)onClick:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    
    if (btn)
    {
        // create the object view for the fictional events to schedule to the calendar
        fictionalEventsView *ficView = [[fictionalEventsView alloc] initWithNibName:@"fictionalEventsView" bundle:nil];
        
        if (ficView)
        {
            // set the table to be refreshed
            reloadTable = YES;
            
            // pass in the default calendar
            ficView.defaultCalendar = defaultCalendar;
            
            // present the scheduling view (dummy data to add)
            [self presentViewController:ficView animated:YES completion:nil];
        }
    }
}

-(void)fetchData
{
    // reset the events array
    events = nil;
    
    // reload data into memory
    NSUserDefaults *loadEvent = [NSUserDefaults standardUserDefaults];
    
    if (loadEvent)
    {
        // set the loop defaults
        int i = 0;
        BOOL loop = YES;
        
        // loop through the defaults until an object returns nil
        // set the retrieved data to an array
        while (loop == YES) {
            
            // create some NSString objects to test for nil in the defaults
            // if the mainKey returns nil then the event doesn't exist
            NSString *mainKey = [[NSString alloc] initWithFormat:@"_event %i title", i];
            NSString *fetchTitle = [loadEvent objectForKey:mainKey];
            
            if (fetchTitle != nil)
            {
                // create formatted key strings
                NSString *endDateKey = [[NSString alloc] initWithFormat:@"_event %i end", i];
                NSString *startDateKey = [[NSString alloc] initWithFormat:@"_event %i start", i];
                NSString *locKey = [[NSString alloc] initWithFormat:@"_event %i location", i];
                
                // create some container strings to house the data from the defaults
                NSString *fetchEndDate = [loadEvent objectForKey:endDateKey];
                NSString *fetchStartDate = [loadEvent objectForKey:startDateKey];
                NSString *fetchLocation = [loadEvent objectForKey:locKey];
                
                // create a temp array to house all of the event properties
                NSArray *thisArray = [[NSArray alloc] initWithObjects:fetchTitle, fetchLocation, fetchEndDate, fetchStartDate, nil];
                
                // if the mutable events is nil initialize it with the temp array
                // otherwise insert the object
                if (!events)
                {
                    events = [[NSMutableArray alloc] initWithObjects:thisArray, nil];
                }
                else
                {
                    [events insertObject:thisArray atIndex:0];
                }
            }
            else if (fetchTitle == nil)
            {
                // set the loop to end
                loop = NO;
            }
            
            i++;
        }
    }

}

@end

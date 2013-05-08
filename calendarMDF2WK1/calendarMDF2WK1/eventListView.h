//
//  eventListView.h
//  calendarMDF2WK1
//
//  Created by Rueben Anderson on 2/6/13.
//  Copyright (c) 2013 Rueben Anderson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EventKit/EventKit.h>
#import "detailedEventView.h"
#import "fictionalEventsView.h"


@interface eventListView : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *events;
    NSString *defaultCalendar;
    EKEventStore *eventStore;
    
    IBOutlet UILabel *calendarName;
    IBOutlet UITableView *eventsTableView;
    
    BOOL reloadTable;
}

-(IBAction)onClick:(id)sender;
-(void)fetchData;

@property (strong) NSMutableArray *events;
@property (strong) NSString *defaultCalendar;

@end

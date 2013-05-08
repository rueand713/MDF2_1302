//
//  fictionalEventsView.h
//  calendarMDF2WK1
//
//  Created by Rueben Anderson on 2/7/13.
//  Copyright (c) 2013 Rueben Anderson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EventKit/EventKit.h>
#import "detailedFictionalEventView.h"



@interface fictionalEventsView : UIViewController
{
    IBOutlet UITableView *dummyView;
    
    NSArray *fictionalEvents;
    NSString *defaultCalendar;
}

-(IBAction)onClick:(id)sender;

@property (strong) NSString *defaultCalendar;

@end

//
//  detailedFictionalEventView.h
//  calendarMDF2WK1
//
//  Created by Rueben Anderson on 2/7/13.
//  Copyright (c) 2013 Rueben Anderson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EventKit/EventKit.h>

@interface detailedFictionalEventView : UIViewController
{
    IBOutlet UILabel *titleLabel;
    IBOutlet UILabel *locationLabel;
    IBOutlet UILabel *timeLabel;
    IBOutlet UILabel *dateLabel;
    IBOutlet UIButton *addEventButton;
    
    NSString *defaultCalendar;
    NSArray *passedEvent;

}

-(IBAction)onClick:(id)sender;
-(void)makeEvent:(NSArray*)eventObject;

@property (strong) NSString *defaultCalendar;
@property (strong) NSArray *passedEvent;
@end

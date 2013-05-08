//
//  detailedEventView.h
//  calendarMDF2WK1
//
//  Created by Rueben Anderson on 2/6/13.
//  Copyright (c) 2013 Rueben Anderson. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol sendScheduleData <NSObject>

@required
-(void)transmitEventData:(NSString*)title eventDate:(NSDate*)date eventLoc:(NSString*)location eventTime:(NSString*)time;

@end

@interface detailedEventView : UIViewController <UIAlertViewDelegate>
{
    NSString *eventTitle;
    NSString *eventLocation;
    NSString *eventTime;
    NSString *eventDate;
    
    IBOutlet UILabel *titleLabel;
    IBOutlet UILabel *locationLabel;
    IBOutlet UILabel *timeLabel;
    IBOutlet UILabel *dateLabel;
    IBOutlet UIButton *addEventButton;
    
    id<sendScheduleData> scheduleDelegate;
}

@property (strong) NSString *eventTitle;
@property (strong) NSString *eventLocation;
@property (strong) NSString *eventTime;
@property (strong) NSString *eventDate;
@property (strong) id<sendScheduleData> scheduleDelegate;

-(IBAction)onClick:(id)sender;

@end

//
//  ViewController.h
//  calendarMDF2WK1
//
//  Created by Rueben Anderson on 2/5/13.
//  Copyright (c) 2013 Rueben Anderson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "chooseCalendarView.h"
#import <EventKit/EventKit.h>
#import "eventListView.h"


@interface ViewController : UIViewController <sendCalendar>
{
    IBOutlet UIButton *defaultCalendarButton;
    IBOutlet UILabel *currentCalendarLabel;
    IBOutlet UILabel *swipeRightLabel;
    UISwipeGestureRecognizer *swiper;
    
    NSString *defaultCalendar;
    NSString *firstRun;
    NSMutableArray *calArr;
}

-(void)swipeToScreen:(UISwipeGestureRecognizer*)recognizer;
-(IBAction)onClick:(id)sender;

@property (strong) NSMutableArray *calArr;

@end

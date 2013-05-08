//
//  chooseCalendarView.h
//  calendarMDF2WK1
//
//  Created by Rueben Anderson on 2/6/13.
//  Copyright (c) 2013 Rueben Anderson. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol sendCalendar <NSObject>

@required
-(void) calWarp:(NSString*)defCal;

@end

@interface chooseCalendarView : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView *calendarView;
    
    NSString *selectedCalendar;
    NSMutableArray*myCalendars;
    
    id<sendCalendar> calDelegate;
}

@property (strong) id<sendCalendar> calDelegate;
@property (strong, retain) NSMutableArray *myCalendars;

@end

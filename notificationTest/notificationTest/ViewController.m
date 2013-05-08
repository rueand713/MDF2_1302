//
//  ViewController.m
//  notificationTest
//
//  Created by Rueben Anderson on 2/5/13.
//  Copyright (c) 2013 Rueben Anderson. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    // cancels all schedules notifications
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    NSDate *myDate = [[NSDate date] dateByAddingTimeInterval:10];
    
        UILocalNotification *myNotification = [[UILocalNotification alloc] init];
        
        if (myNotification != nil)
        {
            myNotification.fireDate = myDate;
            myNotification.timeZone = [NSTimeZone localTimeZone];
            myNotification.alertBody = @"Meep Meep!";
            myNotification.alertAction = @"Shoo!";
            
            [[UIApplication sharedApplication] scheduleLocalNotification:myNotification];
        }
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

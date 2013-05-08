//
//  chooseCalendarView.m
//  calendarMDF2WK1
//
//  Created by Rueben Anderson on 2/6/13.
//  Copyright (c) 2013 Rueben Anderson. All rights reserved.
//

#import "chooseCalendarView.h"

@interface chooseCalendarView ()

@end

@implementation chooseCalendarView

@synthesize calDelegate, myCalendars;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSUserDefaults *loadCal = [NSUserDefaults standardUserDefaults];
        
        if (loadCal)
        {
            // set the looping parameters
            BOOL loop = YES;
            int i = 0;
            
            // loop through the defaults as long as the keyFormatter doesn't cause the nilWeb to go nil
            while (loop == YES)
            {
                NSString *keyFormatter = [[NSString alloc] initWithFormat:@"_eventstore %i", i];
                NSString *nilWeb = [loadCal objectForKey:keyFormatter];
                
                // check if the string is nil, if it is nil then there should be no more calendars stored
                // and the loop should cancel otherwise it will continue loading the calendars
                if (nilWeb != nil)
                {
                    if (myCalendars == nil)
                    {
                        // initialize with the first string
                        myCalendars = [[NSMutableArray alloc] initWithObjects:nilWeb, nil];
                    }
                    else
                    {
                        // insert any of the remaining strings
                        [myCalendars insertObject:nilWeb atIndex:0];
                    }
                }
                else if (nilWeb == nil)
                {
                    // set the loop to cancel
                    loop = NO;
                }
                
                // incrementer
                i++;
            }
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // return the number of calendars for the rows
    return [myCalendars count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell";
    
    UITableViewCell *cell = [calendarView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    // set the cell row text based on the calendar selected
    cell.textLabel.text = [myCalendars objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // set a temp string to the cell row text
    NSString *cellTitle = [myCalendars objectAtIndex:indexPath.row];
    
    // call the custom delegate and pass in the selected row text
    [calDelegate calWarp:cellTitle];
    
    // dismiss the view and return to the main view
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

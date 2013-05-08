//
//  fictionalEventsView.m
//  calendarMDF2WK1
//
//  Created by Rueben Anderson on 2/7/13.
//  Copyright (c) 2013 Rueben Anderson. All rights reserved.
//

#import "fictionalEventsView.h"

@interface fictionalEventsView ()

@end

@implementation fictionalEventsView

@synthesize defaultCalendar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    // 1 hour 3600 - 1 day 86400 - 1 week 604800 - 1 month 2592000 - 1 year 31104000
    
    // create event array objects for inserting into the fictionalEvents array
    NSArray *ficEvent1 = [[NSArray alloc] initWithObjects:@"Rodeo Houston", @"Houston, Tx", [[NSDate date] dateByAddingTimeInterval:3600], [[NSDate date] dateByAddingTimeInterval:3600], nil];
    NSArray *ficEvent2 = [[NSArray alloc] initWithObjects:@"Go To Zoo", @"Houston, Tx", [[NSDate date] dateByAddingTimeInterval:86400], [[NSDate date] dateByAddingTimeInterval:7200], nil];
    NSArray *ficEvent3 = [[NSArray alloc] initWithObjects:@"Grams B-Day", @"Conroe, Tx", [[NSDate date] dateByAddingTimeInterval:432000], [[NSDate date] dateByAddingTimeInterval:8700], nil];
    NSArray *ficEvent4 = [[NSArray alloc] initWithObjects:@"Sandy Beaches", @"Miami, Fl", [[NSDate date] dateByAddingTimeInterval:604800], [[NSDate date] dateByAddingTimeInterval:10800], nil];
    NSArray *ficEvent5 = [[NSArray alloc] initWithObjects:@"Visit Fullsail", @"Winter Park, Fl", [[NSDate date] dateByAddingTimeInterval:691200], [[NSDate date] dateByAddingTimeInterval:13600], nil];
    NSArray *ficEvent6 = [[NSArray alloc] initWithObjects:@"Rock Concert", @"Austin, Tx", [[NSDate date] dateByAddingTimeInterval:950400], [[NSDate date] dateByAddingTimeInterval:16000], nil];
    NSArray *ficEvent7 = [[NSArray alloc] initWithObjects:@"Date Night", @"Houston, Tx", [[NSDate date] dateByAddingTimeInterval:1987200], [[NSDate date] dateByAddingTimeInterval:10000], nil];
    NSArray *ficEvent8 = [[NSArray alloc] initWithObjects:@"Business Trip", @"Los Angeles, Ca", [[NSDate date] dateByAddingTimeInterval:2592000], [[NSDate date] dateByAddingTimeInterval:-7200], nil];
    NSArray *ficEvent9 = [[NSArray alloc] initWithObjects:@"Fun Day At The Park", @"Houston, Tx", [[NSDate date] dateByAddingTimeInterval:3196800], [[NSDate date] dateByAddingTimeInterval:-3600], nil];
    NSArray *ficEvent10 = [[NSArray alloc] initWithObjects:@"Visit the Museum", @"New York, Ny", [[NSDate date] dateByAddingTimeInterval:3801600], [[NSDate date] dateByAddingTimeInterval:-1000], nil];
    NSArray *ficEvent11 = [[NSArray alloc] initWithObjects:@"Fun Day At The Beach", @"Galveston, Tx", [[NSDate date] dateByAddingTimeInterval:5184000], [[NSDate date] dateByAddingTimeInterval:0], nil];
    NSArray *ficEvent12 = [[NSArray alloc] initWithObjects:@"Go To Movies", @"Houston, Tx", [[NSDate date] dateByAddingTimeInterval:5788800], [[NSDate date] dateByAddingTimeInterval:1800], nil];
    
    
    // create a list of fictional events
    fictionalEvents = [[NSArray alloc] initWithObjects:ficEvent1, ficEvent2, ficEvent3, ficEvent4, ficEvent5, ficEvent6, ficEvent7, ficEvent8, ficEvent9, ficEvent10, ficEvent11, ficEvent12, nil];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)onClick:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    
    if (btn)
    {
        // dismiss the view and return to parent
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // return the number of calendars for the rows
    return [fictionalEvents count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell";
    
    UITableViewCell *cell = [dummyView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    // set the cell row text based on the calendar selected
    cell.textLabel.text = [[fictionalEvents objectAtIndex:indexPath.row] objectAtIndex:0];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    detailedFictionalEventView *detailView = [[detailedFictionalEventView alloc] initWithNibName:@"detailedFictionalEventView" bundle:nil];
    
    if (detailView)
    {
        // pass in the selected fictional event data
        detailView.passedEvent = [fictionalEvents objectAtIndex:indexPath.row];
        
        // pass in the default calendar
        detailView.defaultCalendar = defaultCalendar;
        
        // present the ficitional list detail view
        [self presentViewController:detailView animated:YES completion:nil];
    }
}


@end

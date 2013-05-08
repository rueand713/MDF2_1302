//
//  ViewController.m
//  deviceTest
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
    UIDevice *myDevice = [UIDevice currentDevice];
    
    if (myDevice)
    {
        [self writeToConsole:@"The name of this device is: " object:myDevice];
    }
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)writeToConsole:(NSString*)text object:(id)object
{
    if ([object isKindOfClass:[UIDevice class]])
    {
        UIDevice *object = [UIDevice currentDevice];
        
        NSLog(@"%@ %@", text, object.name);
    }
}

@end

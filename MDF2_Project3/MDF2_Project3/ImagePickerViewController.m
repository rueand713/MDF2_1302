//
//  ImagePickerViewController.m
//  MDF2_Project3
//
//  Created by Rueben Anderson on 2/20/13.
//  Copyright (c) 2013 Rueben Anderson. All rights reserved.
//

#import "ImagePickerViewController.h"


typedef enum
{
    PHOTOCAPTURE = 0,
    VIDEOCAPTURE,
    VIEWALBUM
}captureModes;


@implementation ImagePickerViewController

@synthesize delegate, captureMode;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        pickerDisplay = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    if (pickerDisplay == YES)
    {
        pickerDisplay = NO;
        
        // present the picker view based on the passed in capturing parameter
        [self capturePhotoAndVideo:captureMode];
    }
    else if (pickerDisplay == NO)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

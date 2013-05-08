//
//  PhotoAlbumController.m
//  MDF2_Project3
//
//  Created by Rueben Anderson on 2/21/13.
//  Copyright (c) 2013 Rueben Anderson. All rights reserved.
//

#import "PhotoAlbumController.h"
#import "alertViewClass.h"

@interface PhotoAlbumController ()

@end

@implementation PhotoAlbumController

@synthesize mediaInfo;

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
    // create an UIImage object
    UIImage *currentImage = [mediaInfo objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    if (currentImage)
    {
        // set the image view to the selected image
        photoView.image = currentImage;
    }
    else if (!currentImage)
    {
        // show an error message
        [alertViewClass showAlertWithMessage:@"Alert" message:@"Error loading the image." confirmText:nil cancelText:@"Ok"];
    }
        
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    if (btn)
    {
        // dismiss the current view
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end

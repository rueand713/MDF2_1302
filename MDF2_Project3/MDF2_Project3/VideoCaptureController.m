//
//  VideoCaptureController.m
//  MDF2_Project3
//
//  Created by Rueben Anderson on 2/20/13.
//  Copyright (c) 2013 Rueben Anderson. All rights reserved.
//

#import "VideoCaptureController.h"
#import "alertViewClass.h"

@interface VideoCaptureController ()

@end

@implementation VideoCaptureController

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
    // NSURL for extracting the media url.
    NSURL *url = [mediaInfo valueForKey:UIImagePickerControllerMediaURL];
    
    // NSString for holding the path of the previous URL
    NSString *path = [url path];
    
    // set the textview text to the path of the movie
    videoURLView.text = path;
    
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
        if (btn.tag == 0)
        {
            // show a alert that the save has been cancelled
            [alertViewClass showAlertWithMessage:@"Alert" message:@"Save cancelled." confirmText:nil cancelText:@"Ok"];
            
            // don't save and dismiss the view
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else if (btn.tag == 1)
        {
            // create a NSURL object to hold the media url from the dictionary
            NSURL *urlString = [mediaInfo valueForKey:UIImagePickerControllerMediaURL];
            
            if (urlString)
            {
                // convert the url to string for the saving path
                NSString *videoPath = [urlString path];
                
                // save the video
                UISaveVideoAtPathToSavedPhotosAlbum(videoPath, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
            }
        }
    }
}

- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error != nil)
    {
        // an error occurred show error prompt
        [alertViewClass showAlertWithMessage:@"Alert" message:@"Error occurred while saving video." confirmText:nil cancelText:@"Ok"];
        
        // dismiss the view
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else if (error == nil)
    {
        // no errors, show success message
        [alertViewClass showAlertWithMessage:@"Alert" message:@"The video was saved successfully." confirmText:nil cancelText:@"Ok"];
        
        // no errors occurred dismiss the view
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end

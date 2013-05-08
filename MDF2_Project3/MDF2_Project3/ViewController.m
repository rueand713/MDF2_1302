//
//  ViewController.m
//  MDF2_Project3
//
//  Created by Rueben Anderson on 2/18/13.
//  Copyright (c) 2013 Rueben Anderson. All rights reserved.
//

#import "ViewController.h"
#import "PhotoCaptureController.h"
#import "VideoCaptureController.h"
#import "PhotoAlbumController.h"
#import <MobileCoreServices/MobileCoreServices.h>

typedef enum
{
    PHOTOCAPTURE = 0,
    VIDEOCAPTURE,
    VIEWALBUM
}captureModes;

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
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
            // present the picker view for photo capturing
            [self capturePhotoAndVideo:PHOTOCAPTURE];
        }
        else if (btn.tag == 1)
        {
            // present the picker view for video capturing
            [self capturePhotoAndVideo:VIDEOCAPTURE];
        }
        else if (btn.tag == 2)
        {
            // present the picker view for album viewing
            [self capturePhotoAndVideo:VIEWALBUM];
        }
    }
}

- (void)capturePhotoAndVideo:(int)typeOfCapture
{
    // set the global reference to the type of capture
    captureMode = typeOfCapture;
    
    // create the image picker instance
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    // set the imagePickerController source for camera as default
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    // don't allow the image to be edited as default
    imagePicker.allowsEditing = NO;
    
    // determine the capturing mode for the picker and change the parameters that those require only
    if (typeOfCapture == PHOTOCAPTURE)
    {
        // allow the image to be edited
        imagePicker.allowsEditing = YES;
    }
    else if (typeOfCapture == VIDEOCAPTURE)
    {
        imagePicker.videoQuality = UIImagePickerControllerQualityTypeMedium;
        
        imagePicker.mediaTypes = [NSArray arrayWithObjects:(NSString*) kUTTypeMovie, nil];
    }
    else if (typeOfCapture == VIEWALBUM)
    {
        // set the picker source to the photo library
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    // set up the picker delegate
    imagePicker.delegate = self;
    
    // present the imagePickerController
    [self presentViewController:imagePicker animated:YES completion:nil];
    
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
   // NSLog(@"%@", [info description]);
    
    // dismiss the picker view
    [self dismissViewControllerAnimated:YES completion:^{
        if (captureMode == PHOTOCAPTURE)
        {
            // create an instance of the photoCapture view
            PhotoCaptureController *photoViewer = [[PhotoCaptureController alloc] initWithNibName:@"PhotoCaptureController" bundle:nil];
            
            if (photoViewer)
            {
                // pass in the copied info dictionary
                photoViewer.mediaInfo = info;
                
                // present the photo viewing view
                [self presentViewController:photoViewer animated:YES completion:nil];
            }
        }
        else if (captureMode == VIDEOCAPTURE)
        {
            // create an instance of the videoCapture view
            VideoCaptureController *videoCapture = [[VideoCaptureController alloc] initWithNibName:@"VideoCaptureController" bundle:nil];
            
            if (videoCapture)
            {
                // pass in the copied info dictionary
                videoCapture.mediaInfo = info;
                
                // present the video saving view
                [self presentViewController:videoCapture animated:YES completion:nil];
            }
        }
        else if (captureMode == VIEWALBUM)
        {
            // create an instance of the album view
            PhotoAlbumController *albumView = [[PhotoAlbumController alloc] initWithNibName:@"PhotoAlbumController" bundle:nil];
            
            if (albumView)
            {
                // pass in the copied info dictionary
                albumView.mediaInfo = info;
                
                // present the photo viewer
                [self presentViewController:albumView animated:YES completion:nil];
            }
        }
    }];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    // dismiss the pickerController view
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end

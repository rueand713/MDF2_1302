//
//  PhotoCaptureController.m
//  MDF2_Project3
//
//  Created by Rueben Anderson on 2/20/13.
//  Copyright (c) 2013 Rueben Anderson. All rights reserved.
//

#import "PhotoCaptureController.h"
#import "alertViewClass.h"

@interface PhotoCaptureController ()

@end

@implementation PhotoCaptureController

@synthesize mediaInfo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // init the array
        saveLog = [[NSMutableArray alloc] init];
        
        // init the int counter
        didBothImagesSaveYet = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    // create a UIImage of the original image from the passed in dictionary
    originalImage = [mediaInfo objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    if (originalImage)
    {
        // set the image of the original imageView
        originalImageView.image = originalImage;
    }
    
    // create a UIImage of the scaled image from the passed in dictionary
    scaledImage = [mediaInfo objectForKey:@"UIImagePickerControllerEditedImage"];
    
    if (scaledImage)
    {
        // set the image of the scaled imageView
        scaledImageView.image = scaledImage;
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
        if (btn.tag == 0)
        {
            // show a alert that the save has been cancelled
            [alertViewClass showAlertWithMessage:@"Alert" message:@"Save cancelled." confirmText:nil cancelText:@"Ok"];
            
            // don't save and dismiss the view
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else if (btn.tag == 1)
        {
            // save the original image
            UIImageWriteToSavedPhotosAlbum(originalImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
            
            // save the scaled image
            UIImageWriteToSavedPhotosAlbum(scaledImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        }
    }
}


- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error == nil)
    {
        // no errors, insert string into save log array
        [saveLog insertObject:@"Photo saved successfully." atIndex:0];
    }
    else if (error != nil)
    {
        // create an error string
        NSString *errorString;
        
        // modify the error string based on which image file is saving
        if (didBothImagesSaveYet == 0)
        {
            errorString = @"Error with original image.";
        }
        else if (didBothImagesSaveYet == 1)
        {
            errorString = @"Error with scaled image.";
        }
        
        // since an error occurred, insert string into save log array
        [saveLog insertObject:errorString atIndex:0];
    }
    
    if (didBothImagesSaveYet == 1)
    {
        NSString *logIndex1 = [saveLog objectAtIndex:0];
        NSString *logIndex2 = [saveLog objectAtIndex:1];
        
        if ([logIndex1 isEqualToString:logIndex2])
        {
            [alertViewClass showAlertWithMessage:@"Alert" message:@"Photos saved successfully!" confirmText:nil cancelText:@"Ok"];
        }
        else if ([logIndex1 isEqualToString:@"Photo saved successfully"])
        {
            // index 0 didn't have the error so the fault must be with index 1
            [alertViewClass showAlertWithMessage:@"Alert" message:@"Error occurred with the scaled image." confirmText:nil cancelText:@"Ok"];
        }
        else if ([logIndex2 isEqualToString:@"Photo saved successfully"])
        {
            // index 1 didn't have the error so the fault must be with index 0
            [alertViewClass showAlertWithMessage:@"Alert" message:@"Error occurred with the original image." confirmText:nil cancelText:@"Ok"];
        }
        
        // dismiss the view
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    // increment the save counter
    didBothImagesSaveYet++;
}


@end

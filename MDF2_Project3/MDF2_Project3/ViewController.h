//
//  ViewController.h
//  MDF2_Project3
//
//  Created by Rueben Anderson on 2/18/13.
//  Copyright (c) 2013 Rueben Anderson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    int captureMode;
    NSDictionary *infoDict;
}

- (void)capturePhotoAndVideo:(int)captureType;
- (IBAction)onClick:(id)sender;

@end

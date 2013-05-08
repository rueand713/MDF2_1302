//
//  PhotoCaptureController.h
//  MDF2_Project3
//
//  Created by Rueben Anderson on 2/20/13.
//  Copyright (c) 2013 Rueben Anderson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoCaptureController : UIViewController
{
    IBOutlet UIImageView *originalImageView;
    IBOutlet UIImageView *scaledImageView;

    NSDictionary *mediaInfo;
    UIImage *originalImage;
    UIImage *scaledImage;
    NSMutableArray *saveLog;
    
    int didBothImagesSaveYet;
}

- (IBAction)onClick:(id)sender;

@property (nonatomic, strong) NSDictionary *mediaInfo;

@end

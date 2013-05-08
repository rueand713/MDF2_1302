//
//  VideoCaptureController.h
//  MDF2_Project3
//
//  Created by Rueben Anderson on 2/20/13.
//  Copyright (c) 2013 Rueben Anderson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoCaptureController : UIViewController
{
    IBOutlet UITextView *videoURLView;
    
    NSDictionary *mediaInfo;
}

- (IBAction)onClick:(id)sender;

@property (nonatomic, strong) NSDictionary *mediaInfo;

@end

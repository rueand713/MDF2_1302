//
//  ImagePickerViewController.h
//  MDF2_Project3
//
//  Created by Rueben Anderson on 2/20/13.
//  Copyright (c) 2013 Rueben Anderson. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol infoSender <NSObject>

@required
-(void)setMediaInfoDictionary:(NSDictionary *)relayInfo;

@end

@interface ImagePickerViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    int captureMode;
    BOOL pickerDisplay;
    id<infoSender> delegate;
}

- (void)capturePhotoAndVideo:(int)captureMode;

@property (nonatomic, strong) id<infoSender> delegate;
@property int captureMode;
@end

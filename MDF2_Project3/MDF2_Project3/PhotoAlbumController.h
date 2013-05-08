//
//  PhotoAlbumController.h
//  MDF2_Project3
//
//  Created by Rueben Anderson on 2/21/13.
//  Copyright (c) 2013 Rueben Anderson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoAlbumController : UIViewController
{
    IBOutlet UIImageView *photoView;
    
    NSDictionary *mediaInfo;
}

- (IBAction)onClick:(id)sender;

@property (nonatomic, strong) NSDictionary *mediaInfo;

@end

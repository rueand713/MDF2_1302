//
//  MovieView.h
//  MDF2Project4
//
//  Created by Rueben Anderson on 2/26/13.
//  Copyright (c) 2013 Rueben Anderson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface MovieView : UIViewController
{
    IBOutlet UIView *movieView;
    IBOutlet UILabel *titleLabel;
    
    NSArray *movie;
    MPMoviePlayerController *moviePlayer;
    UIAlertView *loadingIndicator;
}

-(IBAction)onClick:(id)sender;
- (UIAlertView *)createAlertObject:(NSString *)title message:(NSString *)message;

@property (nonatomic, strong) NSArray *movie;

@end

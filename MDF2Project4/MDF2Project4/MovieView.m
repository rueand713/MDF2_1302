//
//  MovieView.m
//  MDF2Project4
//
//  Created by Rueben Anderson on 2/26/13.
//  Copyright (c) 2013 Rueben Anderson. All rights reserved.
//

#import "MovieView.h"

@interface MovieView ()

@end

@implementation MovieView

@synthesize movie;

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
    // register a notification with the notification center
    NSNotificationCenter *notification = [NSNotificationCenter defaultCenter];
    
    if (notification)
    {
        [notification addObserver:self selector:@selector(removeLoadAlert:) name:MPMoviePlayerLoadStateDidChangeNotification object:moviePlayer];
    }
    
    // set the movie title label
    titleLabel.text = [movie objectAtIndex:0];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)removeLoadAlert:(NSNotification *)notification
{
    // when the loadState is ready resume the movie playback
    if (moviePlayer.loadState == 3)
    {
        // dismiss the activity indicator alert
        [loadingIndicator dismissWithClickedButtonIndex:0 animated:YES];
        
        // resume playing the video file
        [moviePlayer play];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)onClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    if (btn)
    {
        if (btn.tag == 0)
        {
            // dismiss the view
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else if (btn.tag == 1)
        {
            // stop the video from playing
            if (moviePlayer)
            {
                [moviePlayer stop];
            }
        }
        else if (btn.tag == 2)
        {
            loadingIndicator = [self createAlertObject:@"Buffering" message:@"Please wait.."];
            
            if (loadingIndicator)
            {
                // show the progress alert
                [loadingIndicator show];
            }
            
            // create a URL object from the movie URL string
            NSURL *movieURL = [NSURL URLWithString:[movie objectAtIndex:3]];
            
            // initialize the moviePlayer with the movie URL
            moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:movieURL];
            
            if (moviePlayer)
            {
                // add the movie player view as the movieView subView
                [movieView addSubview:moviePlayer.view];
                
                // set the movie frame size to the subview frame size
                moviePlayer.view.frame = CGRectMake(0.0f, 0.0f, movieView.frame.size.width, movieView.frame.size.height);
                
                // set the movieplayer defaults
                moviePlayer.fullscreen = NO;
                moviePlayer.controlStyle = MPMovieControlStyleNone;
                
                // play the video from the passed in URL in the movie player
                [moviePlayer play];
                
                // pause the video for loading; will resume when the notification is hit
                [moviePlayer pause];
                
            }
        }
    }
}

- (UIAlertView *)createAlertObject:(NSString *)title message:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    
    if (alert)
    {
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        
        if (indicator)
        {
            // set the indicator location
            indicator.center = CGPointMake(145.0f, 95.0f);
            
            // start animating the indicator
            [indicator startAnimating];
            
            // add the indicator to the view
            [alert addSubview:indicator];
        }
    }
    
    return alert;
}

@end

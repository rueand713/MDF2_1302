//
//  MovieDetailsView.m
//  MDF2Project4
//
//  Created by Rueben Anderson on 2/26/13.
//  Copyright (c) 2013 Rueben Anderson. All rights reserved.
//

#import "MovieDetailsView.h"
#import "MovieView.h"

typedef enum
{
    TRAILER = 0,
    BACKBTN
}btnDefs;

@implementation MovieDetailsView

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
    // set the text labels to their appropriate values from the movie object
    titleLabel.text = [movie objectAtIndex:0];
    showtimesLabel.text = [movie objectAtIndex:1];
    
    // set the imageView image to the movie poster image
    imageView.image = [UIImage imageNamed:[movie objectAtIndex:2]];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
        if (btn.tag == TRAILER)
        {
            MovieView *trailerView = [[MovieView alloc] initWithNibName:@"MovieView" bundle:nil];
            
            if (trailerView)
            {
                // pass in the movie object
                trailerView.movie = movie;
                
                // present the movie view
                [self presentViewController:trailerView animated:YES completion:nil];
            }
        }
        else if (btn.tag == BACKBTN)
        {
            // dismiss the view
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
}

@end

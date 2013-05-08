//
//  ViewController.m
//  MDF2Project4
//
//  Created by Rueben Anderson on 2/26/13.
//  Copyright (c) 2013 Rueben Anderson. All rights reserved.
//

#import "ViewController.h"
#import "CustomTableCell.h"
#import "CustomHeaderLabel.h"
#import "MovieDetailsView.h"

typedef enum
{
    AFTEREARTH = 0,
    DESPICABLE2,
    ESCAPEFROMEARTH,
    FASTFURIOUS6,
    GREATPOWERFUL,
    IDENTITYTHIEF
}movieURLNames;

@implementation ViewController

- (void)viewDidLoad
{
    //initialize the section counter to 0
    sectionCount = 0;
    
    // block that will create the movie object data on the fly
    createMovieObject = ^(NSString *title, NSString *showTime, NSString *posterName, NSString *urlString)
    {
        // creates the array of movie data and returns it from the block
        NSArray *movie = [[NSArray alloc] initWithObjects:title, showTime, posterName, urlString, nil];
        
        return movie;
    };
    
    // create an array of the movie posters (images) to be used
    NSArray *moviePosters = [[NSArray alloc] initWithObjects:@"after_earth.jpg", @"dark_skies.jpg", @"despicable_me_2.jpg", @"hansel_and_gretel.jpg", @"escape_from_planet_earth.jpg", @"jack_the_giant_slayer.jpg", @"fast_and_furious_6.jpg", @"life_of_pi.jpg", @"lincoln.jpg", @"the_great_and_powerful.jpg", @"mama.jpg", @"a_good_day_to_die_hard.jpg", @"identity_thief.jpg", @"django_unchained.jpg", @"21_and_over.jpg", nil];
    
    // create an array of the video urls to be used
    NSArray *videoURL = [[NSArray alloc] initWithObjects:@"http://dl.dropbox.com/u/68223018/after_earth_trailer.mp4", @"http://dl.dropbox.com/u/68223018/dark_skies_trailer.mp4", @"http://dl.dropbox.com/u/68223018/despicable_me_2_trailer.mp4", @"http://dl.dropbox.com/u/68223018/hansel_and_gretel_trailer.mp4", @"http://dl.dropbox.com/u/68223018/escape_from_planet_earth_trailer.mp4", @"http://dl.dropbox.com/u/68223018/jack_the_giant_slayer_trailer.mp4", @"http://dl.dropbox.com/u/68223018/fast_furious_6_trailer.mp4", @"http://dl.dropbox.com/u/68223018/life_of_pi_trailer.mp4", @"http://dl.dropbox.com/u/68223018/lincoln_trailer.mp4", @"http://dl.dropbox.com/u/68223018/great_and_powerful_trailer.mp4", @"http://dl.dropbox.com/u/68223018/mama_trailer.mp4", @"http://dl.dropbox.com/u/68223018/a_good_day_to_die_hard_trailer.mp4", @"http://dl.dropbox.com/u/68223018/identity_thief_trailer.mp4", @"http://dl.dropbox.com/u/68223018/django_unchained_trailer.mp4", @"http://dl.dropbox.com/u/68223018/21_and_over_trailer.mp4", nil];
    
    // create an array of the movie titles to be used
    NSArray *movieTitles = [[NSArray alloc] initWithObjects:@"After Earth", @"Dark Skies", @"Despicable Me 2", @"Hansel & Gretel", @"Escape From Planet Earth", @"Jack The Giant Slayer", @"Fast and Furious 6", @"Life of Pi", @"Lincoln", @"The Great And Powerful", @"Mama", @"A Good Day To Die Hard", @"Identity Theif", @"Django Unchained", @"21 And Over", nil];
    
    // create an array of the movie times to be used
    NSArray *movieTimes = [[NSArray alloc] initWithObjects:@"2:00 PM | 5:00 PM | 7:32 PM", @"1:00 PM | 3:45 PM | 5:15 PM", @"12:15 PM | 2:14 PM | 4:20 PM", @"4:29 PM | 6:32 PM | 8:15 PM", @"6:15 PM | 8:40 PM | 10:20 PM", @"7:20 PM | 9:19 PM | 11:40 PM", @"12:05 PM | 2:25 PM | 4:55 PM", @"11:22 AM | 1:15 PM | 3:08 PM", @"1:55 PM | 4:00 PM | 7:43 PM", @"11:30 AM | 3:00 PM | 5:25 PM", @"7:45 PM | 10:10 PM | 12:00 AM", @"2:10 PM | 4:44 PM | 5:10 PM", @"7:25 PM | 9:36 PM | 12:12 AM", @"5:35 PM | 7:55 PM | 8:20 PM", @"6:00 PM | 8:18 PM | 12:30 AM", nil];
    
    
    // loop through 15 times to create the movie list of data
    for (int i = 0; i < [movieTitles count]; i++)
    {
        // create an movieObject to be placed into the movies array
        NSArray *movie = createMovieObject([movieTitles objectAtIndex:i], [movieTimes objectAtIndex:i], [moviePosters objectAtIndex:i], [videoURL objectAtIndex:i]);
        
        if (movie)
        {
            if (movies)
            {
                // if movies has been initialized already, insert the new movie object
                [movies insertObject:movie atIndex:0];
            }
            else
            {
                // since this is the first time movies needs to be initialized
                
                // initialize the movies array
                movies = [[NSMutableArray alloc] initWithObjects:movie, nil];
            }
        }
    }
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// sets the number of rows in the sections
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

// creates a custom cell using the customTableCell nib
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // to keep track of the cells in the section
    sectionCount = indexPath.row + (indexPath.section * 5);
    
    NSString *cellId = @"cell";
    
    // attempt to reuse a cell
    CustomTableCell *cell = [movieTableView dequeueReusableCellWithIdentifier:cellId];
    
    // if the cell is nil
    if (cell == nil)
    {
        // create a custom cell from the CustomTableCell nib
        NSArray *cellNib = [[NSBundle mainBundle] loadNibNamed:@"CustomTableCell" owner:self options:nil];
        
        if (cellNib)
        {
            // set the cell to the casted nib returned at index 0
            cell = (CustomTableCell *)[cellNib objectAtIndex:0];
        }
    }
    
    // create an image with a movie poster file
    NSString *posterFile = [[movies objectAtIndex: sectionCount] objectAtIndex: 2];
    UIImage *movieImage = [UIImage imageNamed:posterFile];
    
    if (movieImage)
    {
        // set the cell imageView image to the new UIImage
        cell.movieIcon.image = movieImage;
    }
    
    // set the cell text for the movie title and showtimes
    cell.movieTitle.text = [[movies objectAtIndex:sectionCount] objectAtIndex:0];
    cell.movieTimes.text = [[movies objectAtIndex:sectionCount] objectAtIndex:1];
    
    return cell;
}

// sets the height of the cell rows
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

// function fires when the table cell is touched
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // variable to for referencing the correct index of the movies array
    // using the row and section from the index path
    NSInteger section = indexPath.row + (indexPath.section * 5);
    
    MovieDetailsView *movieDetails = [[MovieDetailsView alloc] initWithNibName:@"MovieDetailsView" bundle:nil];
    
    if (movieDetails)
    {
        // pass in the selected movie object
        movieDetails.movie = [movies objectAtIndex:section];
        
        // present the movie details view
        [self presentViewController:movieDetails animated:YES completion:nil];
    }
}

// set the number of sections in the table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

// this method creates a custom table header using the custom CustomHeaderLabel nib
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray *headerNib = [[NSBundle mainBundle] loadNibNamed:@"CustomHeaderLabel" owner:self options:nil];
    
    CustomHeaderLabel *headerView = (CustomHeaderLabel *)[headerNib objectAtIndex:0];
    
    if (headerView)
    {
        // create the header data objects
        UIImage *theatreImage;
        NSString *cinemaName = @"";
        NSString *cinemaLocation = @"";
        
        // set the table header data based on the section
        if (section == 0)
        {
            theatreImage = [UIImage imageNamed:@"theatre1.jpg"];
            cinemaName = @"AMC 290";
            cinemaLocation = @"Houston, Tx";
        }
        else if (section == 1)
        {
            theatreImage = [UIImage imageNamed:@"theatre2.jpg"];
            cinemaName = @"Lowels Theatre";
            cinemaLocation = @"Memorial City, Tx";
        }
        else if (section == 2)
        {
            theatreImage = [UIImage imageNamed:@"theatre3.jpg"];
            cinemaName = @"Edwards Theatre";
            cinemaLocation = @"Woodlands, Tx";
        }
        
        // assign the data to the table header objects
        headerView.theatreName.text = cinemaName;
        headerView.theatreLocation.text = cinemaLocation;
        headerView.theatreImage.image = theatreImage;
    }
    
    return headerView;
}

// changes the header height
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

@end

//
//  ViewController.m
//  MDF2Twitter
//
//  Created by Rueben Anderson on 2/12/13.
//  Copyright (c) 2013 Rueben Anderson. All rights reserved.
//

#import "ViewController.h"

typedef enum
{
    REFRESHTWEET = 0,
    POSTATWEET,
    VIEWPROFILE
}twitterButtons;

@implementation ViewController


- (void)viewDidLoad
{
    // view hasn't appeared. This will keep the alertView from creating before the view is loaded
    viewHasAppeared = NO;
    
    // set the connectionSent to no so the UIImage will be fetched
    connectionSent = NO;
    
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    
    if (accountStore)
    {
        ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
        
        if (accountType)
        {
            [accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error) {
                if (granted)
                {
                    NSArray *twitterAccounts = [accountStore accountsWithAccountType:accountType];
                    
                    if (twitterAccounts)
                    {
                        // grab the current account
                        currentAccount = [twitterAccounts objectAtIndex:0];
                        
                        // set the viewHasAppeared signaling the view has loaded and will be presented
                        // safe for showing UiAlertViews
                        viewHasAppeared = YES;

                    }
                }
            }];
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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *viewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    
    if (viewController)
    {
        // create an NSDictionary from the twitterArray
        NSDictionary *tweetData = [twitterArray objectAtIndex:indexPath.row];
        
        // pass the tweetData dictionary to the detail view
        viewController.twitterData = tweetData;
        
        // present the detailed view controller
        [self presentViewController:viewController animated:YES completion:nil];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // if the array comes back nil the data hasn't finished fetching yet so return 0
    // otherwise return the number of objects in the twitter array
    if (twitterArray)
    {
        return [twitterArray count];
    }
    else
    {
        return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cell";
    
    CustomCell *cell = [twitterFeed dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell)
    {
        NSArray *cellNib = [[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:self options:nil];
        
        // cycle through the views in the celNib array
        for (UIView *view in cellNib)
        {
            // when the CustomCell class is found set the cell to the view
            if ([view isKindOfClass:[CustomCell class]])
            {
                // cast the view to class of CustomCell
                cell = (CustomCell *)view;
            }
        }
    }
    
    // set the default nil cell text
    cell.tweetLabel.text = @"";
    cell.dateLabel.text = @"";
    
    
    // if twitterArray exists create the cell text from the object at the current index
    if (twitterArray)
    {
        // create a dictionary of the first object in the twitter array
        NSDictionary *thisTweet = [twitterArray objectAtIndex:indexPath.row];
        
        // check if thisTweet is valid object
        if (thisTweet)
        {
            // call the function to initiate downloading the user image
            [self imageRetrieval:imageLink];
            
            //NSLog(@"%@", [thisTweet description]);
            cell.tweetLabel.text = (NSString *)[thisTweet objectForKey:@"text"];
            cell.dateLabel.text = (NSString *)[thisTweet objectForKey:@"created_at"];
            
            if (userImage != nil)
            {
                // set the image of the imageView of the cell
                cell.imageView.image = userImage;
            }
        }
    }
    
    return cell;
}


-(void)viewDidAppear:(BOOL)animated
{
        // fetch the twitter timeline when the view is shown
        [self retrieveFeed];
    
    [super viewDidAppear:animated];
}


- (IBAction)onClick:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    
    if (btn && btn.tag == REFRESHTWEET)
    {
        // refresh the twitter feed
        [self retrieveFeed];
    }
    else if (btn && btn.tag == POSTATWEET)
    {
        // post a tweet
        TWTweetComposeViewController *controller = [[TWTweetComposeViewController alloc] init];
        
        if (controller)
        {
            [controller setInitialText:@"Posted from"];
            
            [self presentViewController:controller animated:YES completion:nil];
            
            controller.completionHandler = ^(TWTweetComposeViewControllerResult res)
            {
                if (res == TWTweetComposeViewControllerResultDone)
                {
                    NSLog(@"Message posted!");
                    
                    [self dismissViewControllerAnimated:YES completion:nil];
                }
                else if (res == TWTweetComposeViewControllerResultCancelled)
                {
                    NSLog(@"Message Cancelled!");
                    
                    // dismiss the compose tweet view
                    [self dismissViewControllerAnimated:YES completion:nil];
                }
            };
        }
    }
    else if (btn && btn.tag == VIEWPROFILE)
    {
        UserDetailsView *userDetails = [[UserDetailsView alloc] initWithNibName:@"UserDetailsView" bundle:nil];
        
        if (userDetails)
        {
            // create an NSDictionary from the twitterArray
            NSDictionary *tweetData = [twitterArray objectAtIndex:0];
            
            if (tweetData)
            {
                // pass in the tweet data dictionary
                userDetails.tweetionary = tweetData;
                
                // pass in the user image
                userDetails.userImage = userImage;
                
                [self presentViewController:userDetails animated:YES completion:nil];
            }
        }
    }
}


// this function is called for each timeline fetch
-(void)retrieveFeed
{
    if (viewHasAppeared == YES)
    {
        // create the alertView from the returned object
        loadingAlert = [self showProgressView];
        
        // present the progress indicator UIAlertView
        [loadingAlert show];
    }
    
    if (currentAccount)
    {
        // the twitter timeline url string
        NSURL *urlTimeline = [[NSURL alloc] initWithString:@"https://api.twitter.com/1.1/statuses/user_timeline.json"];
        
        // if the url is created properly create the TWRequet object based on the NSURL
        if (urlTimeline)
        {
            TWRequest *request = [[TWRequest alloc] initWithURL:urlTimeline parameters:nil requestMethod:TWRequestMethodGET];
            
            // if the TWRequest object request is created properly continue to perform the request
            if (request)
            {
                // set the request account to be the current account
                [request setAccount:currentAccount];
                
                [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                    
                    if ([urlResponse statusCode] == 200)
                    {
                        NSError *jsonError = nil;
                        twitterArray = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&jsonError];
                        
                        if (twitterArray)
                        {
                            // create a dictionary of the first object in the twitter array
                            NSDictionary *thisTweet = [twitterArray objectAtIndex:0];
                                
                            // check if thisTweet is valid object
                            if (thisTweet)
                            {
                                // set the profile image url for loading up in NSURLConnection
                                imageLink = (NSString *)[[thisTweet objectForKey:@"user"] objectForKey:@"profile_image_url"];
                            }
                            
                            // refresh the tweets tableview
                            [twitterFeed reloadData];
                            
                        }
                    }
                }];
            }
        }
    }
    
    if (viewHasAppeared == YES)
    {
        // dismiss the progress indicator UIAlertView
        [loadingAlert dismissWithClickedButtonIndex:0 animated:YES];
    }
    
}


// returns a UIAlertView
-(UIAlertView *)showProgressView
{
    // create the alert view object for displaying when the tweets are being retreieved
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Fetching Tweets" message:@"Please wait..." delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
        
        if (alertView != nil)
        {
            // create the actvity indicator for the UIAlertView
            UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            
            // if the indicator is created properly set the location in the alertview, animate it and add it to the view
            if (indicator)
            {
                // tried to fetch the bounds on the alert view but returned 0
                // set the width and height manually
                float width = 140.0f; //+ (alertView.bounds.size.width/2.0f);
                float height = 95.0f; //+ (alertView.frame.size.height/2.0f);
                
                // set the location of the indicator on the alert view
                indicator.center = CGPointMake(width, height);
                
                // set the indicator to animate
                [indicator startAnimating];
                
                // add the progress indicator to the view
                [alertView addSubview:indicator];
            }
        }

    return alertView;
}


-(void)imageRetrieval:(NSString*)imageURL
{
    // check if the passed in url is valid
    if (imageURL)
    {
    
        // nils out the request data
        requestData = nil;
        
        if (connection)
        {
            // cancels any ongoing connection sequences
            [connection cancel];
        }
            
        // create the NSURL from the passed in imageURL
        NSURL *url = [[NSURL alloc] initWithString:imageURL];
    
        if (url)
        {
            // create the url request object
            NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        
            if (request)
            {
                // create the connection
                connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
            
                if (connection)
                {
                    // set the requestData to nil for appending
                    requestData = nil;
                }
            }
        
            // set the variable to YES to prevent refetchting the image
            connectionSent = YES;
        }
    }
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // check if data is valid
    if (data)
    {
        // check if the requestData object has been created before
        if (!requestData)
        {
            // if not, create the object from the data
            requestData = [[NSMutableData alloc] initWithData:data];
        }
        else
        {
            // otherwise, append the data to the data already stored
            [requestData appendData:data];
        }
    }
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // create an image from the requestData
    UIImage *dataImage = [UIImage imageWithData:requestData];
    
    if (dataImage)
    {
        // set the userImage to newly formed image from the NSConnection
        userImage = dataImage;
        
        // image is successfully downloaded reload the table to display the file
        [twitterFeed reloadData];
    }
}

@end

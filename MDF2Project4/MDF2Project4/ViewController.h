//
//  ViewController.h
//  MDF2Project4
//
//  Created by Rueben Anderson on 2/26/13.
//  Copyright (c) 2013 Rueben Anderson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView *movieTableView;
    
    NSInteger sectionCount;
    
    NSMutableArray *movies;
    NSArray * (^createMovieObject)(NSString*, NSString*, NSString*, NSString*);
}

@end

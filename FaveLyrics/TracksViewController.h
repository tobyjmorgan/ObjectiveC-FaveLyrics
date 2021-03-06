//
//  TracksViewController.h
//  FaveLyrics
//
//  Created by redBred LLC on 12/29/16.
//  Copyright © 2016 redBred. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+NetworkAlert.h"

@interface TracksViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (nonatomic) NSInteger albumID;

@end

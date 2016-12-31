//
//  AlbumsViewController.h
//  FaveLyrics
//
//  Created by redBred LLC on 12/29/16.
//  Copyright © 2016 redBred. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlbumsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (nonatomic) NSInteger artistID;

@end

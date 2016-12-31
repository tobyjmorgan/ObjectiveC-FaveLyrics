//
//  ArtistSearchViewController.h
//  FaveLyrics
//
//  Created by redBred LLC on 12/28/16.
//  Copyright © 2016 redBred. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArtistSearchViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

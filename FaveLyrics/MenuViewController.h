//
//  MenuViewController.h
//  FaveLyrics
//
//  Created by redBred LLC on 12/28/16.
//  Copyright © 2016 redBred. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *headerView;

@end

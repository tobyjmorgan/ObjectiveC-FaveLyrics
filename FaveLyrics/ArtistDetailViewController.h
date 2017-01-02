//
//  ArtistDetailViewController.h
//  FaveLyrics
//
//  Created by redBred LLC on 1/2/17.
//  Copyright © 2017 redBred. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Artist.h"

@interface ArtistDetailViewController : UIViewController

@property (nonatomic, strong) Artist *artist;

@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *country;
@property (strong, nonatomic) IBOutlet UILabel *rating;
@property (strong, nonatomic) IBOutlet UILabel *genres;
@property (strong, nonatomic) IBOutlet UITextView *twitter;
@end

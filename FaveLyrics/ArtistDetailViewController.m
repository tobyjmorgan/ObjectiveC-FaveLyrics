//
//  ArtistDetailViewController.m
//  FaveLyrics
//
//  Created by redBred LLC on 1/2/17.
//  Copyright © 2017 redBred. All rights reserved.
//

#import "ArtistDetailViewController.h"

@interface ArtistDetailViewController ()

@end

@implementation ArtistDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.name.text = self.artist.name;
    self.country.text = self.artist.country;
    self.rating.text = [NSString stringWithFormat:@"%ld", (long)self.artist.rating];
    self.genres.text = [self.artist.genres componentsJoinedByString:@", "];
    self.twitter.text = self.artist.twitterURL;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

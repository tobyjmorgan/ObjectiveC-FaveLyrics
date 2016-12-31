//
//  AlbumsViewController.m
//  FaveLyrics
//
//  Created by redBred LLC on 12/29/16.
//  Copyright © 2016 redBred. All rights reserved.
//

#import "AlbumsViewController.h"
#import "APIClient.h"
#import "Album.h"
#import "Endpoint.h"
#import "TracksViewController.h"
#import "AlbumCollectionViewCell.h"
#import "SAMCache.h"

@interface AlbumsViewController ()

@property (nonatomic, strong) NSMutableArray *results;
@property (nonatomic) NSInteger lastAlbumSelected;

@end

@implementation AlbumsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.results = [[NSMutableArray alloc] init];
    
    self.activityIndicator.hidden = YES;
    [self.activityIndicator stopAnimating];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self performFetch];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)performFetch {
    
    self.activityIndicator.hidden = NO;
    [self.activityIndicator startAnimating];
    
    APIClient *client = [APIClient sharedInstance];
    
    Endpoint *endpoint = [[Endpoint alloc] initAsAlbumsGetWithArtistID:self.artistID];
    
    [client fetchRequestWithEndpoint:endpoint completionHandler:^(BOOL success, NSDictionary * _Nullable results) {
        
        self.activityIndicator.hidden = YES;
        [self.activityIndicator stopAnimating];
        
        self.results = [[endpoint albumsFromResults:results] mutableCopy];
        [self.collectionView reloadData];
    }];
}




/////////////////////////////////////////////
// MARK: Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"Tracks"]) {
        
        TracksViewController *vc = (TracksViewController *)segue.destinationViewController;
        
        vc.albumID = self.lastAlbumSelected;
    }
}



/////////////////////////////////////////////
// MARK: UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.results.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    AlbumCollectionViewCell *cell = (AlbumCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"AlbumCell" forIndexPath:indexPath];
    
    cell.containingView.layer.cornerRadius = 10;

    Album *album = [self.results objectAtIndex:indexPath.row];
    cell.albumTitleLabel.text = album.name;
    cell.trackCount.text = [NSString stringWithFormat:@"%ld", (long)album.trackCount];
    cell.photoURLString = album.coverArt100;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    Album *album = [self.results objectAtIndex:indexPath.row];
    
    self.lastAlbumSelected = album.albumID;
    
    [self performSegueWithIdentifier:@"Tracks" sender:self];
}


@end

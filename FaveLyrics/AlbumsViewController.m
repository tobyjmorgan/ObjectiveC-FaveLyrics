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
#import "AlbumCell.h"

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
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
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
        [self.tableView reloadData];
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
// MARK: UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.results.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AlbumCell *cell = (AlbumCell *)[tableView dequeueReusableCellWithIdentifier:@"AlbumCell"];
    
    Album *album = [self.results objectAtIndex:indexPath.row];
    cell.albumTitleLabel.text = album.name;
    cell.albumVanityLabel.text = album.vanityID;
    cell.trackCount.text = [NSString stringWithFormat:@"Tracks: %ld", (long)album.trackCount];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Album *album = [self.results objectAtIndex:indexPath.row];
    
    self.lastAlbumSelected = album.albumID;
    
    [self performSegueWithIdentifier:@"Tracks" sender:self];
}


@end

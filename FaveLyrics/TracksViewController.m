//
//  TracksViewController.m
//  FaveLyrics
//
//  Created by redBred LLC on 12/29/16.
//  Copyright © 2016 redBred. All rights reserved.
//

#import "TracksViewController.h"
#import "APIClient.h"
#import "Track.h"
#import "Endpoint.h"
#import "LyricsViewController.h"
#import "StandardCell.h"

@interface TracksViewController ()

@property (nonatomic, strong) NSMutableArray *results;
@property (nonatomic) NSInteger lastTrackSelected;
@property (nonatomic, strong) NSString *lyricURLOfLastTrackSelected;

@end

@implementation TracksViewController

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
    
    Endpoint *endpoint = [[Endpoint alloc] initAsTracksGetWithAlbumID:self.albumID];
    
    [client fetchRequestWithEndpoint:endpoint completionHandler:^(BOOL success, NSString * _Nullable message, NSDictionary * _Nullable results) {
        
        if (success) {
            
            self.activityIndicator.hidden = YES;
            [self.activityIndicator stopAnimating];
            
            self.results = [[endpoint tracksFromResults:results] mutableCopy];
            [self.tableView reloadData];
            
        } else {
            
            // UIView category for presenting network alert messages
            [self presentNetworkAlertMessage:message];
        }
    }];
}




/////////////////////////////////////////////
// MARK: Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"ShowLyrics"]) {
        
        LyricsViewController *vc = (LyricsViewController *)segue.destinationViewController;
        
        vc.trackID = self.lastTrackSelected;
        vc.lyricsURL = self.lyricURLOfLastTrackSelected;
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
    
    StandardCell *cell = (StandardCell *)[tableView dequeueReusableCellWithIdentifier:@"AlbumCell"];
    
    Track *track = [self.results objectAtIndex:indexPath.row];
    cell.titleLabel.text = track.name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Track *track = [self.results objectAtIndex:indexPath.row];
    
    self.lastTrackSelected = track.trackID;
    self.lyricURLOfLastTrackSelected = track.trackShareURL;
    
    [self performSegueWithIdentifier:@"ShowLyrics" sender:self];
}

@end

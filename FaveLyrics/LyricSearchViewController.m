//
//  LyricSearchViewController.m
//  FaveLyrics
//
//  Created by redBred LLC on 12/30/16.
//  Copyright © 2016 redBred. All rights reserved.
//

#import "LyricSearchViewController.h"
#import "APIClient.h"
#import "Endpoint.h"
#import "TrackPlus.h"
#import "LyricsViewController.h"
#import "TrackPlusCell.h"

@interface LyricSearchViewController ()

@property (nonatomic, strong) NSMutableArray *results;
@property (nonatomic) NSInteger lastTrackSelected;
@property (nonatomic, strong) NSString *lyricURLOfLastTrackSelected;

@end

@implementation LyricSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.results = [[NSMutableArray alloc] init];
    
    self.activityIndicator.hidden = YES;
    [self.activityIndicator stopAnimating];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.searchBar.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    [self.tableView reloadData];
}

- (void)performFetchWithQueryString:(NSString *)queryString {
    
    self.activityIndicator.hidden = NO;
    [self.activityIndicator startAnimating];
    
    APIClient *client = [APIClient sharedInstance];
    
    Endpoint *endpoint = [[Endpoint alloc] initAsTrackSearchWithLyricQuery:queryString];
    
    [client fetchRequestWithEndpoint:endpoint completionHandler:^(BOOL success, NSString * _Nullable message, NSDictionary * _Nullable results) {
        
        if (success) {
            
            self.activityIndicator.hidden = YES;
            [self.activityIndicator stopAnimating];
            
            self.results = [[endpoint trackPlusesFromResults:results] mutableCopy];
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
    
    TrackPlusCell *cell = (TrackPlusCell *)[tableView dequeueReusableCellWithIdentifier:@"TrackPlusCell"];
    
    TrackPlus *track = [self.results objectAtIndex:indexPath.row];
    cell.trackTitleLabel.text = track.name;
    cell.albumLabel.text = track.albumName;
    cell.artistLabel.text = track.artistName;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TrackPlus *track = [self.results objectAtIndex:indexPath.row];
    self.lastTrackSelected = track.trackID;
    self.lyricURLOfLastTrackSelected = track.trackShareURL;
    
    [self performSegueWithIdentifier:@"ShowLyrics" sender:self];
}





/////////////////////////////////////////////
// MARK: UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
    self.activityIndicator.hidden = YES;
    [self.activityIndicator stopAnimating];
    
    // TODO: cancel any searches that are underway
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    
    if (self.searchBar.text != nil) {
        
        [self.results removeAllObjects];
        [self.tableView reloadData];
        
        [self performFetchWithQueryString:self.searchBar.text];
    }
}

@end

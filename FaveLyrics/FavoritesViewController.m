//
//  FavoritesViewController.m
//  FaveLyrics
//
//  Created by redBred LLC on 12/30/16.
//  Copyright © 2016 redBred. All rights reserved.
//

#import "FavoritesViewController.h"
#import "TrackPlus.h"
#import "LyricsViewController.h"
#import "APIClient.h"
#import "Endpoint.h"
#import "Model.h"
#import "TrackPlusCell.h"

@interface FavoritesViewController ()

@property (nonatomic, strong) NSMutableArray *results;
@property (nonatomic) NSInteger lastTrackSelected;
@property (nonatomic, strong) NSString *lyricURLOfLastTrackSelected;

@end

@implementation FavoritesViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.results = [[NSMutableArray alloc] init];
    
    self.activityIndicator.hidden = YES;
    [self.activityIndicator stopAnimating];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    // remove old values from results array
    [self.results removeAllObjects];
    
    [self.tableView reloadData];
    
    // refetch favorites
    [self performFetch];
}

- (void)performFetch {
    
    Model *model = [Model sharedInstance];

    NSArray *favorites = [model allFavoriteTracks];
    
    if (favorites.count > 0) {
        
        self.activityIndicator.hidden = NO;
        [self.activityIndicator startAnimating];
        
        APIClient *client = [APIClient sharedInstance];
        
        for (NSNumber *favorite in favorites) {
            
            Endpoint *endpoint = [[Endpoint alloc] initAsTrackGetWithTrackID:[favorite integerValue]];
            
            [client fetchRequestWithEndpoint:endpoint completionHandler:^(BOOL success, NSDictionary * _Nullable results) {
                
                self.activityIndicator.hidden = YES;
                [self.activityIndicator stopAnimating];
                
                TrackPlus *track = [endpoint trackPlusFromResults:results];
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.results.count inSection:0];
                [self.results addObject:track];
                
                [self.tableView beginUpdates];
                [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                [self.tableView endUpdates];
            }];
        }
    }
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
    cell.albumLabel.text =  [NSString stringWithFormat:@"Album: %@", track.albumName];
    cell.artistLabel.text =  [NSString stringWithFormat:@"by %@", track.artistName];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TrackPlus *track = [self.results objectAtIndex:indexPath.row];
    
    self.lastTrackSelected = track.trackID;
    self.lyricURLOfLastTrackSelected = track.trackShareURL;
    
    [self performSegueWithIdentifier:@"ShowLyrics" sender:self];
}



@end

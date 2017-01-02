//
//  ArtistSearchViewController.m
//  FaveLyrics
//
//  Created by redBred LLC on 12/28/16.
//  Copyright © 2016 redBred. All rights reserved.
//

#import "ArtistSearchViewController.h"
#import "APIClient.h"
#import "Endpoint.h"
#import "Artist.h"
#import "AlbumsViewController.h"
#import "StandardDisclosureCell.h"
#import "ArtistDetailViewController.h"

@interface ArtistSearchViewController ()

@property (nonatomic, strong) NSMutableArray *results;
@property (nonatomic, strong) Artist *lastArtistSelected;

@end

@implementation ArtistSearchViewController

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

- (void)viewWillDisappear:(BOOL)animated {
    
    // TODO: why does this not detect it is returning to parent?
    if (self.isMovingToParentViewController) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
    
    [super viewWillDisappear:animated];
}

// fetch request to support this table view
- (void)performFetchWithQueryString:(NSString *)queryString {
    
    self.activityIndicator.hidden = NO;
    [self.activityIndicator startAnimating];

    APIClient *client = [APIClient sharedInstance];
    
    Endpoint *endpoint = [[Endpoint alloc] initAsArtistSearchWithArtistNameQuery:queryString];
    
    [client fetchRequestWithEndpoint:endpoint completionHandler:^(BOOL success, NSString * _Nullable message,NSDictionary * _Nullable results) {
        
        if (success) {
            
            self.activityIndicator.hidden = YES;
            [self.activityIndicator stopAnimating];
            
            self.results = [[endpoint artistsFromResults:results] mutableCopy];
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
    
    if ([segue.identifier isEqualToString:@"Albums"]) {
        
        AlbumsViewController *vc = (AlbumsViewController *)segue.destinationViewController;
        
        vc.artistID = self.lastArtistSelected.artistID;
        
    } else if ([segue.identifier isEqualToString:@"ArtistDetail"]) {
        
        ArtistDetailViewController *vc = (ArtistDetailViewController *)segue.destinationViewController;
        
        vc.artist = self.lastArtistSelected;
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
    
    StandardDisclosureCell *cell = (StandardDisclosureCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    Artist *artist = [self.results objectAtIndex:indexPath.row];
    cell.titleLabel.text = artist.name;
    [cell.disclosureButton addTarget:self action:@selector(onDisclosure:) forControlEvents:UIControlEventTouchUpInside];
    cell.disclosureButton.tag = indexPath.row;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Artist *artist = [self.results objectAtIndex:indexPath.row];
    self.lastArtistSelected = artist;
        
    [self performSegueWithIdentifier:@"Albums" sender:self];
}

- (void)onDisclosure:(UIButton *)sender {
    
    Artist *artist = [self.results objectAtIndex:sender.tag];
    self.lastArtistSelected = artist;
    
    [self performSegueWithIdentifier:@"ArtistDetail" sender:self];
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

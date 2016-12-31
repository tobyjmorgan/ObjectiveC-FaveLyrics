//
//  MenuViewController.m
//  FaveLyrics
//
//  Created by redBred LLC on 12/28/16.
//  Copyright © 2016 redBred. All rights reserved.
//

#import "MenuViewController.h"

#define MenuButtonMyLyrics @"My Fave Lyrics"
#define MenuButtonNewLyrics @"Find New Lyrics"
#define MenuButtonGoBack @"< Go Back"
#define MenuButtonFindArtist @"   Find Artist"
#define MenuButtonFindLyric @"   Find Lyric"

@interface MenuViewController ()

@property (nonatomic, strong) NSMutableArray *menuOptions;
@property (nonatomic, strong) NSMutableArray *nextOptions;
@property (nonatomic, strong) NSMutableArray *prevOptions;

@end


@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.menuOptions = [[NSMutableArray alloc] init];
    self.nextOptions = [[NSMutableArray alloc] init];
    self.prevOptions = [[NSMutableArray alloc] init];
    [self.menuOptions addObjectsFromArray:@[MenuButtonMyLyrics, MenuButtonNewLyrics]];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.headerView.layer.cornerRadius = 20.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];

    [super viewWillDisappear:animated];
}

- (void)deleteCells {

    if (self.menuOptions.count > 0 ) {
        
        // we need the index BEFORE the action has occurred - since we will delete it
        NSInteger lastItemIndex = self.menuOptions.count-1;
        
        [self.menuOptions removeLastObject];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastItemIndex inSection:0];
        
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        [self deleteCells];
        
    } else {
        
        [self.tableView endUpdates];

        // add new cells
        [self.tableView beginUpdates];
        [self performSelector:@selector(addCells) withObject:nil afterDelay:0.6];
    }
}

- (void)addCells {
    
    if (self.nextOptions.count > 0) {
        
        [self.menuOptions addObject:[self.nextOptions firstObject]];
        [self.nextOptions removeObjectAtIndex:0];
        
        // we need the index AFTER the action has occurred - since we will insert it
        NSInteger lastItemIndex = self.menuOptions.count-1;
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastItemIndex inSection:0];
        
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];

        [self addCells];
        
    } else {
        
        [self.tableView endUpdates];

        // done - do nothing
    }
}




/////////////////////////////////////////////
// MARK: UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.menuOptions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.menuOptions[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.nextOptions.count > 0) {
        // do nothing, we are still doing the buttons
        return;
    }
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    NSString *label = cell.textLabel.text;
    
    if ([label isEqualToString:MenuButtonMyLyrics]) {
        
        [self performSegueWithIdentifier:@"Favorites" sender:self];

    } else if ([label isEqualToString:MenuButtonNewLyrics]) {
        
        // replace buttons with new set
        self.prevOptions = [self.menuOptions mutableCopy];
        [self.nextOptions addObjectsFromArray:@[MenuButtonGoBack, MenuButtonFindArtist, MenuButtonFindLyric]];
        
        [self.tableView beginUpdates];
        [self deleteCells];
        
    } else if ([label isEqualToString:MenuButtonGoBack]) {
        
        // replace buttons with set before last change
        self.nextOptions = self.prevOptions;
        
        [self.tableView beginUpdates];
        [self deleteCells];
        
    } else if ([label isEqualToString:MenuButtonFindArtist]) {
        
        [self performSegueWithIdentifier:@"ArtistSearch" sender:self];
        
    } else if ([label isEqualToString:MenuButtonFindLyric]) {
        
        [self performSegueWithIdentifier:@"LyricSearch" sender:self];
    }
    
}



@end





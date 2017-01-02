//
//  MenuViewController.m
//  FaveLyrics
//
//  Created by redBred LLC on 12/28/16.
//  Copyright © 2016 redBred. All rights reserved.
//

#import "MenuViewController.h"
#import "Model.h"

#define MenuButtonMyLyrics @"My Fave Lyrics"
#define MenuButtonNewLyrics @"Find New Lyrics"
#define MenuButtonGoBack @"< Go Back"
#define MenuButtonFindArtist @"   Find Artist"
#define MenuButtonFindLyric @"   Find Lyric"

@interface MenuViewController ()

@property (nonatomic, strong) NSArray *menuOptions;
@property (nonatomic, strong) NSMutableArray *currentMenuPage;
@property (nonatomic) NSInteger currentPageIndex;
@property (nonatomic) NSInteger lastPageIndex;

@end


@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.headerView.layer.cornerRadius = 20.0;
    
    [self refreshMenuOptions];
    self.currentPageIndex = 0;
    self.currentMenuPage = [self.menuOptions[self.currentPageIndex] mutableCopy];
    
    [self.tableView reloadData];

    [self performWelcome];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // may need to refresh the menu if all favorites have been cleared out
    if ([self refreshMenuOptions] && self.currentPageIndex == 0) {
        
        self.currentMenuPage = [self.menuOptions[self.currentPageIndex] mutableCopy];
        [self.tableView reloadData];
    }
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

// welcome message on first visit to app
- (void)performWelcome {
    
    Model *model = [Model sharedInstance];
    
    if (!model.beenRunBefore) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Welcome" message:@"This app is designed to allow you to find the lyrics to your favorite songs. You can 'favorite' any lyrics you love by tappng the heart in the lower right corner of the Lyrics Screen." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"Cool!" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}

// menu options change based on whether user has any favorites
- (BOOL)refreshMenuOptions {
    
    NSMutableArray *oldPageOne = self.menuOptions[0];
    NSInteger oldPageOneCount = oldPageOne.count;
    
    Model *model = [Model sharedInstance];

    NSInteger newPageOneCount;
    
    if ([model allFavoriteTracks].count > 0) {
        self.menuOptions = @[@[MenuButtonMyLyrics, MenuButtonNewLyrics], @[MenuButtonGoBack, MenuButtonFindArtist, MenuButtonFindLyric]];
        newPageOneCount = 2;
    } else {
        self.menuOptions = @[@[MenuButtonNewLyrics], @[MenuButtonGoBack, MenuButtonFindArtist, MenuButtonFindLyric]];
        newPageOneCount = 1;
    }
    
    return !(newPageOneCount == oldPageOneCount);
}

// clear out old menu options one by one (nice animation)
- (void)deleteCells {

    if (self.currentMenuPage.count > 0) {

        // we need the index BEFORE the action has occurred - since we will delete it
        NSInteger lastItemIndex = self.currentMenuPage.count-1;
        
        [self.currentMenuPage removeLastObject];

        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastItemIndex inSection:0];
        
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        [self deleteCells];
    
    } else {
        
        [self.tableView endUpdates];

        // add new cells
        [self.tableView beginUpdates];
        [self performSelector:@selector(addCells) withObject:nil afterDelay:0.2];
    }
}

// add in new menu options one by one (nice animation)
- (void)addCells {

    NSArray *newPage = self.menuOptions[self.currentPageIndex];
    NSInteger currentCount = self.currentMenuPage.count;
    if (currentCount < newPage.count) {

        [self.currentMenuPage addObject:newPage[currentCount]];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:currentCount inSection:0];
        
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
    
    return self.currentMenuPage.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.text = self.currentMenuPage[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    NSString *label = cell.textLabel.text;
    
    // determine which option was selected and perform appropriate action
    if ([label isEqualToString:MenuButtonMyLyrics]) {
        
        [self performSegueWithIdentifier:@"Favorites" sender:self];

    } else if ([label isEqualToString:MenuButtonNewLyrics]) {
        
        // replace buttons with new set
        self.lastPageIndex = self.currentPageIndex;
        self.currentPageIndex = 1;
        
        [self.tableView beginUpdates];
        [self deleteCells];
        
    } else if ([label isEqualToString:MenuButtonGoBack]) {
        
        // replace buttons with set before last change
        self.lastPageIndex = self.currentPageIndex;
        self.currentPageIndex = 0;

        [self.tableView beginUpdates];
        [self deleteCells];
        
    } else if ([label isEqualToString:MenuButtonFindArtist]) {
        
        [self performSegueWithIdentifier:@"ArtistSearch" sender:self];
        
    } else if ([label isEqualToString:MenuButtonFindLyric]) {
        
        [self performSegueWithIdentifier:@"LyricSearch" sender:self];
    }
    
}



@end





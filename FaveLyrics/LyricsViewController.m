//
//  LyricsViewController.m
//  FaveLyrics
//
//  Created by redBred LLC on 12/29/16.
//  Copyright © 2016 redBred. All rights reserved.
//

#import "LyricsViewController.h"
#import "Model.h"

@interface LyricsViewController ()

@end

@implementation LyricsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView.delegate = self;

    Model *model = [Model sharedInstance];

    if ([model isFavoriteTrack:self.trackID]) {
        self.fullHeartImage.hidden = NO;
    } else {
        self.fullHeartImage.hidden = YES;
    }
    
    if (self.lyricsURL != nil && self.lyricsURL.length > 5) {
        
        NSURL *url = [NSURL URLWithString:self.lyricsURL];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        [self.webView loadRequest:request];
    }
        
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onDismissToMenu)];
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.webView addGestureRecognizer:swipe];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)onDismissToMenu {
    [self.navigationController popToRootViewControllerAnimated:YES];
}



/////////////////////////////////////////////
// MARK: UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    self.activityIndicator.hidden = NO;
    [self.activityIndicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.activityIndicator.hidden = YES;
    [self.activityIndicator stopAnimating];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    self.activityIndicator.hidden = YES;
    [self.activityIndicator stopAnimating];
}



- (IBAction)onFavorite {
    
    Model *model = [Model sharedInstance];
    
    if ([model isFavoriteTrack:self.trackID]) {
        
        [model removeTrackFromFavorites:self.trackID];
        self.fullHeartImage.hidden = YES;
        
    } else {
        
        [model addTrackToFavorites:self.trackID];
        self.fullHeartImage.hidden = NO;
    }
}

@end

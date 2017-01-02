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
        self.emptyHeart.hidden = YES;
    } else {
        self.fullHeartImage.hidden = YES;
        self.emptyHeart.hidden = NO;
    }
    
    [self startHeartBeat];
    
    // N.B. using web view to load the web page that has the lyrics
    // the API only provided a stub of the lyrics in development mode
    // plus it seemed like a good way to vary things up a bit
    
    if (self.lyricsURL != nil && self.lyricsURL.length > 5) {
        
        NSURL *url = [NSURL URLWithString:self.lyricsURL];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        [self.webView loadRequest:request];
    }
    
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchWasOut:)];
    [self.webView addGestureRecognizer:pinch];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

// determine type of pinch gesture
- (void)pinchWasOut:(UIPinchGestureRecognizer *)gestureRecognizer {
    
    if (gestureRecognizer.scale < 1) {
        [self onShrink];
    }
}

// perform shrink animation
- (void)onShrink {
    
    [UIView animateWithDuration:0.75 animations:^{
        
        self.view.transform = CGAffineTransformMakeScale(0.1, 0.1);
        self.view.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        // had to delay this, pop was getting called before you could see the animation, even though
        // the pop was being called on completion.
        [self performSelector:@selector(onDismissToMenu) withObject:nil afterDelay:0.4];
        
    }];
}

- (void)onDismissToMenu {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

// heart beat animation for favorite button
- (void)startHeartBeat {
    
    [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat | UIViewAnimationOptionCurveEaseInOut animations:^{
        
        self.fullHeartImage.transform = CGAffineTransformMakeScale(0.8,0.8);
    } completion:nil];
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
        self.emptyHeart.hidden = NO;
        
    } else {
        
        [model addTrackToFavorites:self.trackID];
        self.fullHeartImage.hidden = NO;
        self.emptyHeart.hidden = YES;
    }
}

@end

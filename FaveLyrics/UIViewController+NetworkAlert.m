//
//  UIViewController+NetworkAlert.m
//  FaveLyrics
//
//  Created by redBred LLC on 1/2/17.
//  Copyright © 2017 redBred. All rights reserved.
//

#import "UIViewController+NetworkAlert.h"

@implementation UIViewController (NetworkAlert)

- (void)presentNetworkAlertMessage:(NSString *)message {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Network Alert" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"S'all Good" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end

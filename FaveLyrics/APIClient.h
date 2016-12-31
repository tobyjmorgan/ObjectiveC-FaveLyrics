//
//  APIClient.h
//  FaveLyrics
//
//  Created by redBred LLC on 12/27/16.
//  Copyright © 2016 redBred. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Endpoint;

@interface APIClient : NSObject

+ sharedInstance;
- (void)fetchRequestWithEndpoint:(Endpoint * _Nonnull)endpoint completionHandler:(void (^ _Nonnull)(BOOL success, NSDictionary * _Nullable results))completion;

@end

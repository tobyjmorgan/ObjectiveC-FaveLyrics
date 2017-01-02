//
//  Model.h
//  FaveLyrics
//
//  Created by redBred LLC on 12/30/16.
//  Copyright © 2016 redBred. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject

+ sharedInstance;
- (NSArray *)allFavoriteTracks;
- (BOOL)isFavoriteTrack:(NSInteger)trackID;
- (void)addTrackToFavorites:(NSInteger)trackID;
- (void)removeTrackFromFavorites:(NSInteger)trackID;
- (BOOL)beenRunBefore;

@end

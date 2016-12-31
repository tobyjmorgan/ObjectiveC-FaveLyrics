//
//  TrackPlus.m
//  FaveLyrics
//
//  Created by redBred LLC on 12/30/16.
//  Copyright © 2016 redBred. All rights reserved.
//

#import "TrackPlus.h"
#import "HTTPKey.h"

@implementation TrackPlus

- (instancetype)init {
    return nil;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    self = [super init];
    
    if (self) {
        self.trackID = [[dictionary valueForKey:HTTPKey_track_id] integerValue];
        self.name = [dictionary valueForKey:HTTPKey_track_name];
        self.rating = [[dictionary valueForKey:HTTPKey_track_rating] integerValue];
        self.trackLength = [[dictionary valueForKey:HTTPKey_track_length] integerValue];
        self.commonTrackID = [[dictionary valueForKey:HTTPKey_commontrack_id] integerValue];
        
        self.instrumental = [[dictionary valueForKey:HTTPKey_instrumental] boolValue];
        self.explicitLyrics = [[dictionary valueForKey:HTTPKey_explicit] boolValue];
        self.hasLyrics = [[dictionary valueForKey:HTTPKey_has_lyrics] boolValue];
        self.lyricsID = [[dictionary valueForKey:HTTPKey_lyrics_id] integerValue];
        self.numFavorite = [[dictionary valueForKey:HTTPKey_num_favourite] integerValue];
        self.trackShareURL = [dictionary valueForKey:HTTPKey_track_share_url];
        self.firstReleaseDate = [dictionary valueForKey:HTTPKey_first_release_date];
        
        self.artistID = [[dictionary valueForKey:HTTPKey_artist_id] integerValue];
        self.artistName = [dictionary valueForKey:HTTPKey_artist_name];

        self.albumID = [[dictionary valueForKey:HTTPKey_album_id] integerValue];
        self.albumName = [dictionary valueForKey:HTTPKey_album_name];
    }
    
    return self;
}

@end

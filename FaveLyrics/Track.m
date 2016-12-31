//
//  Track.m
//  FaveLyrics
//
//  Created by redBred LLC on 12/27/16.
//  Copyright © 2016 redBred. All rights reserved.
//

#import "Track.h"
#import "HTTPKey.h"

@implementation Track

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
        
    }
    
    return self;
}

@end

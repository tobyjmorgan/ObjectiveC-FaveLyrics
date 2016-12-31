//
//  Album.m
//  FaveLyrics
//
//  Created by redBred LLC on 12/23/16.
//  Copyright © 2016 redBred. All rights reserved.
//

#import "Album.h"
#import "HTTPKey.h"

@implementation Album

- (instancetype)init {
    return nil;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    self = [super init];
    
    if (self) {
        self.albumID = [[dictionary valueForKey:HTTPKey_album_id] integerValue];
        self.name = [dictionary valueForKey:HTTPKey_album_name];
        self.rating = [[dictionary valueForKey:HTTPKey_album_rating] integerValue];
        self.trackCount = [[dictionary valueForKey:HTTPKey_album_track_count] integerValue];
        self.releaseDate = [dictionary valueForKey:HTTPKey_album_release_date];
        self.releaseType = [dictionary valueForKey:HTTPKey_album_release_type];
        self.label = [dictionary valueForKey:HTTPKey_album_label];
        self.copyright = [dictionary valueForKey:HTTPKey_album_copyright];
        self.coverArt100 = [dictionary valueForKey:HTTPKey_album_coverart_100x100];
        self.vanityID = [dictionary valueForKey:HTTPKey_album_vanity_id];
        
    }
    
    return self;
}

@end

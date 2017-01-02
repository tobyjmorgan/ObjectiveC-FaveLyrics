//
//  Endpoint.m
//  FaveLyrics
//
//  Created by redBred LLC on 12/27/16.
//  Copyright © 2016 redBred. All rights reserved.
//

#import "Endpoint.h"
#import "HTTPKey.h"
#import "Artist.h"
#import "Album.h"
#import "Track.h"
#import "TrackPlus.h"

@interface Endpoint()

@property (nonatomic, strong) NSDictionary *properties;
@property (nonatomic, strong) NSString *baseURLWithEndpoint;

@end


static NSString *baseURL = @"https://api.musixmatch.com/ws/1.1";

@implementation Endpoint

- (instancetype)init {
    return nil;
}

- (instancetype)initAsArtistSearchWithArtistNameQuery:(NSString *)nameQuery {
    
    self = [super init];
    
    if (self) {
        
        self.baseURLWithEndpoint = [baseURL stringByAppendingString:@"/artist.search?"];
        self.properties = @{
                            HTTPKey_q_artist : nameQuery,
                            HTTPKey_s_artist_rating : @"desc"
                            };
    }
    
    return self;
}

- (instancetype)initAsAlbumsGetWithArtistID:(NSInteger)artistID {
    
    self = [super init];
    
    if (self) {
        
        self.baseURLWithEndpoint = [baseURL stringByAppendingString:@"/artist.albums.get?"];
        self.properties = @{
                            HTTPKey_artist_id : [NSString stringWithFormat:@"%ld", (long)artistID],
                            HTTPKey_s_album_release_date : @"asc",
                            HTTPKey_s_album_rating : @"desc"
                            };
    }
    
    return self;
}

- (instancetype)initAsTracksGetWithAlbumID:(NSInteger)albumID {
    
    self = [super init];
    
    if (self) {
        
        self.baseURLWithEndpoint = [baseURL stringByAppendingString:@"/album.tracks.get?"];
        self.properties = @{
                            HTTPKey_album_id : [NSString stringWithFormat:@"%ld", (long)albumID]
                            };
    }
    
    return self;
}

- (instancetype)initAsTrackSearchWithLyricQuery:(NSString *)lyricQuery {
    
    self = [super init];
    
    if (self) {
        
        self.baseURLWithEndpoint = [baseURL stringByAppendingString:@"/track.search?"];
        self.properties = @{
                            HTTPKey_q_lyrics : lyricQuery,
                            HTTPKey_s_track_rating : @"desc"
                            };
    }
    
    return self;
}

- (instancetype)initAsArtistGetWithArtistID:(NSInteger)artistID {
    
    self = [super init];
    
    if (self) {
        
        self.baseURLWithEndpoint = [baseURL stringByAppendingString:@"/artist.get?"];
        self.properties = @{
                            HTTPKey_artist_id : [NSString stringWithFormat:@"%ld", (long)artistID]
                            };
    }
    
    return self;
}

- (instancetype)initAsTrackGetWithTrackID:(NSInteger)trackID {
    
    self = [super init];
    
    if (self) {
        
        self.baseURLWithEndpoint = [baseURL stringByAppendingString:@"/track.get?"];
        self.properties = @{
                            HTTPKey_track_id : [NSString stringWithFormat:@"%ld", (long)trackID]
                            };
    }
    
    return self;
}



- (NSURL *)urlForEndpoint {
    
    NSMutableString *urlString = [self.baseURLWithEndpoint mutableCopy];
    
    // standard parameters
    urlString = [[urlString stringByAppendingString:@"format=json&apikey=1a74cec8d49e65ceb033bc5874c926eb&page_size=100&"] mutableCopy];
    
    for(NSString* key in self.properties) {
        
        NSString *value = [self.properties valueForKey:key];
        
        NSString *cleanValue = [value stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        
        urlString = [[urlString stringByAppendingString:[NSString stringWithFormat:@"%@=%@&", key, cleanValue]] mutableCopy];
    }
    
    // remove the last ampersand - if there is one
    if ([urlString hasSuffix:@"&"]) {
        urlString = [[urlString substringToIndex:urlString.length-1] mutableCopy];
    }
    
    return [NSURL URLWithString:urlString];
}

- (NSArray *)artistsFromResults:(NSDictionary *)resultsDictionary {
    
    NSDictionary *objectsDict = [resultsDictionary valueForKeyPath:HTTPKeyPath_artist_search_results];
    
    NSMutableArray *objects = [[NSMutableArray alloc] init];
    
    for (NSDictionary *objectDict in [objectsDict valueForKey:HTTPKey_artist]) {
        
        Artist *artist = [[Artist alloc] initWithDictionary:objectDict];
        [objects addObject:artist];
    }
    
    return objects;
}

- (Artist *)artistFromResults:(NSDictionary *)resultsDictionary {
    
    NSDictionary *objectDict = [resultsDictionary valueForKeyPath:HTTPKeyPath_artist_get_result];
    
    Artist *artist = [[Artist alloc] initWithDictionary:objectDict];
    
    return artist;
}

- (NSArray *)albumsFromResults:(NSDictionary *)resultsDictionary {
    
    NSDictionary *objectsDict = [resultsDictionary valueForKeyPath:HTTPKeyPath_albums_get_results];
    
    NSMutableArray *objects = [[NSMutableArray alloc] init];
    
    for (NSDictionary *objectDict in [objectsDict valueForKey:HTTPKey_album]) {
        
        Album *album = [[Album alloc] initWithDictionary:objectDict];
        
        if (album.releaseDate.length > 4) {
            
            [objects addObject:album];
        }
    }
    
    return objects;
}

- (NSArray *)tracksFromResults:(NSDictionary *)resultsDictionary {
    
    NSDictionary *objectsDict = [resultsDictionary valueForKeyPath:HTTPKeyPath_tracks_get_results];
    
    NSMutableArray *objects = [[NSMutableArray alloc] init];
    
    for (NSDictionary *objectDict in [objectsDict valueForKey:HTTPKey_track]) {
        
        Track *track = [[Track alloc] initWithDictionary:objectDict];
        [objects addObject:track];
    }
    
    return objects;
}

- (TrackPlus *)trackPlusFromResults:(NSDictionary *)resultsDictionary {
    
    NSDictionary *objectDict = [resultsDictionary valueForKeyPath:HTTPKeyPath_track_get_result];
    
    TrackPlus *track = [[TrackPlus alloc] initWithDictionary:objectDict];
    
    return track;
}

- (NSArray *)trackPlusesFromResults:(NSDictionary *)resultsDictionary {
    
    NSDictionary *objectsDict = [resultsDictionary valueForKeyPath:HTTPKeyPath_tracks_get_results];
    
    NSMutableArray *objects = [[NSMutableArray alloc] init];
    
    for (NSDictionary *objectDict in [objectsDict valueForKey:HTTPKey_track]) {
        
        TrackPlus *track = [[TrackPlus alloc] initWithDictionary:objectDict];
        [objects addObject:track];
    }
    
    return objects;
}


@end

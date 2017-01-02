//
//  Endpoint.h
//  FaveLyrics
//
//  Created by redBred LLC on 12/27/16.
//  Copyright © 2016 redBred. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Artist;
@class TrackPlus;

@interface Endpoint : NSObject

// multiple inits - one for each endpoint type
- (instancetype)initAsArtistSearchWithArtistNameQuery:(NSString *)nameQuery;
- (instancetype)initAsAlbumsGetWithArtistID:(NSInteger)artistID;
- (instancetype)initAsTracksGetWithAlbumID:(NSInteger)albumID;
- (instancetype)initAsTrackSearchWithLyricQuery:(NSString *)lyricQuery;
- (instancetype)initAsArtistGetWithArtistID:(NSInteger)artistID;
- (instancetype)initAsTrackGetWithTrackID:(NSInteger)trackID;

// gets the correct url info for the specific endpoint
- (NSURL *)urlForEndpoint;

// equivalent to parser methods - turns dictionary results in to appropriate objects/arrays of objects
- (NSArray *)artistsFromResults:(NSDictionary *)resultsDictionary;
- (Artist *)artistFromResults:(NSDictionary *)resultsDictionary;
- (NSArray *)albumsFromResults:(NSDictionary *)resultsDictionary;
- (NSArray *)tracksFromResults:(NSDictionary *)resultsDictionary;
- (TrackPlus *)trackPlusFromResults:(NSDictionary *)resultsDictionary;
- (NSArray *)trackPlusesFromResults:(NSDictionary *)resultsDictionary;

@end

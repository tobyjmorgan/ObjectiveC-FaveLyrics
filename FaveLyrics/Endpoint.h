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

- (instancetype)initAsArtistSearchWithArtistNameQuery:(NSString *)nameQuery;
- (instancetype)initAsAlbumsGetWithArtistID:(NSInteger)artistID;
- (instancetype)initAsTracksGetWithAlbumID:(NSInteger)albumID;
- (instancetype)initAsTrackSearchWithLyricQuery:(NSString *)lyricQuery;
- (instancetype)initAsArtistGetWithArtistID:(NSInteger)artistID;
- (instancetype)initAsTrackGetWithTrackID:(NSInteger)trackID;

- (NSURL *)urlForEndpoint;
- (NSArray *)artistsFromResults:(NSDictionary *)resultsDictionary;
- (Artist *)artistFromResults:(NSDictionary *)resultsDictionary;
- (NSArray *)albumsFromResults:(NSDictionary *)resultsDictionary;
- (NSArray *)tracksFromResults:(NSDictionary *)resultsDictionary;
- (TrackPlus *)trackPlusFromResults:(NSDictionary *)resultsDictionary;
- (NSArray *)trackPlusesFromResults:(NSDictionary *)resultsDictionary;

@end

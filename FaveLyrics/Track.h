//
//  Track.h
//  FaveLyrics
//
//  Created by redBred LLC on 12/27/16.
//  Copyright © 2016 redBred. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Track : NSObject

@property (nonatomic) NSInteger trackID;
@property (nonatomic, strong) NSString* name;
@property (nonatomic) NSInteger rating;
@property (nonatomic) NSInteger trackLength;
@property (nonatomic) NSInteger commonTrackID;
@property (nonatomic) BOOL instrumental;
@property (nonatomic) BOOL explicitLyrics;
@property (nonatomic) BOOL hasLyrics;
@property (nonatomic) NSInteger lyricsID;
@property (nonatomic) NSInteger numFavorite;
@property (nonatomic, strong) NSString* trackShareURL;
@property (nonatomic, strong) NSString* firstReleaseDate;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

//
//  Artist.m
//  FaveLyrics
//
//  Created by redBred LLC on 12/22/16.
//  Copyright © 2016 redBred. All rights reserved.
//

#import "Artist.h"
#import "HTTPKey.h"

@implementation Artist

- (instancetype)init {
    return nil;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    self = [super init];
    
    if (self) {
        self.artistID = [[dictionary valueForKey:HTTPKey_artist_id] integerValue];
        self.name = [dictionary valueForKey:HTTPKey_artist_name];
        self.country = [dictionary valueForKey:HTTPKey_artist_country];
        self.rating = [[dictionary valueForKey:HTTPKey_artist_rating] integerValue];
        self.twitterURL = [dictionary valueForKey:HTTPKey_artist_twitter_url];
    
        NSArray *primaryGenres = [dictionary valueForKeyPath:HTTPKeyPath_primary_genres];
        NSArray *secondaryGenres = [dictionary valueForKeyPath:HTTPKeyPath_secondary_genres];
        
        NSMutableArray *genres = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dict in [primaryGenres arrayByAddingObjectsFromArray:secondaryGenres]) {
            
            NSString *genreName = [dict valueForKey:HTTPKey_music_genre_name];
            [genres addObject:genreName];
        }
        
        self.genres = genres;
    }
    
    return self;
}

@end

//
//  Model.m
//  FaveLyrics
//
//  Created by redBred LLC on 12/30/16.
//  Copyright © 2016 redBred. All rights reserved.
//

/////////////////////////////////////////////////////////////////////////
// Thanks to Abhijit on stackoverflow for nifty singleton solution
// http://stackoverflow.com/questions/5381085/how-to-create-singleton-class-in-objective-c

#import "Model.h"

#define UserDefaultsKey_Favorites       @"Favorites"

@interface Model()

@property (nonatomic, strong) NSUserDefaults *defaults;

@end


@implementation Model

static Model *singletonObject = nil;

+ (id) sharedInstance
{
    if (! singletonObject) {
        
        singletonObject = [[Model alloc] init];
    }
    
    return singletonObject;
}

- (id)init
{
    if (! singletonObject) {
        
        singletonObject = [super init];
        self.defaults = [NSUserDefaults standardUserDefaults];
    }
    
    return singletonObject;
}

- (NSArray *)allFavoriteTracks {
    
    NSArray *favorites = [self.defaults objectForKey:UserDefaultsKey_Favorites];
    
    if (favorites == nil) favorites = @[];
    
    return favorites;
}

- (BOOL)isFavoriteTrack:(NSInteger)trackID {
    
    for (NSNumber *favorite in [self allFavoriteTracks]) {
        
        if ([favorite integerValue] == trackID) {
            
            return YES;
        }
    }
    
    return NO;
}

- (void)addTrackToFavorites:(NSInteger)trackID {
    
    if (![self isFavoriteTrack:trackID]) {
        
        NSMutableArray *oldFavorites = [[self allFavoriteTracks] mutableCopy];
        
        [oldFavorites insertObject:[NSNumber numberWithInteger:trackID] atIndex:0];
        
        [self.defaults setObject:(NSArray *)oldFavorites forKey:UserDefaultsKey_Favorites];
        [self.defaults synchronize];
    }
}

- (void)removeTrackFromFavorites:(NSInteger)trackID {
    
    if ([self isFavoriteTrack:trackID]) {
        
        NSMutableArray *oldFavorites = [[self allFavoriteTracks] mutableCopy];
        
        [oldFavorites removeObject:[NSNumber numberWithInteger:trackID]];
        
        [self.defaults setObject:(NSArray *)oldFavorites forKey:UserDefaultsKey_Favorites];
        [self.defaults synchronize];
    }
}


@end

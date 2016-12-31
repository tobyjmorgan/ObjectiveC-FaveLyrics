//
//  Album.h
//  FaveLyrics
//
//  Created by redBred LLC on 12/23/16.
//  Copyright © 2016 redBred. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Album : NSObject

@property (nonatomic) NSInteger albumID;
@property (nonatomic, strong) NSString* name;
@property (nonatomic) NSInteger rating;
@property (nonatomic) NSInteger trackCount;
@property (nonatomic, strong) NSString* releaseDate;
@property (nonatomic, strong) NSString* releaseType;
@property (nonatomic, strong) NSString* label;
@property (nonatomic, strong) NSString* copyright;
@property (nonatomic, strong) NSString* coverArt100;
@property (nonatomic, strong) NSString *vanityID;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

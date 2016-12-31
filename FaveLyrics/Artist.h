//
//  Artist.h
//  FaveLyrics
//
//  Created by redBred LLC on 12/22/16.
//  Copyright © 2016 redBred. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Artist : NSObject

@property (nonatomic) NSInteger artistID;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* country;
@property (nonatomic) NSInteger rating;
@property (nonatomic, strong) NSArray* genres;
@property (nonatomic, strong) NSString* twitterURL;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

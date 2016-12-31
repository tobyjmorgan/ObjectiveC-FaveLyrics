//
//  AlbumCollectionViewCell.m
//  FaveLyrics
//
//  Created by redBred LLC on 12/31/16.
//  Copyright © 2016 redBred. All rights reserved.
//

#import "AlbumCollectionViewCell.h"
#import <SAMCache.h>

@implementation AlbumCollectionViewCell

- (void)setPhotoURLString:(NSString *)photoURLString {
    
    _photoURLString = photoURLString;
    
    UIImage *cachedPhoto = [[SAMCache sharedCache] imageForKey:photoURLString];
    
    if (cachedPhoto) {
        self.photo.image = cachedPhoto;
        return;
    }
    
    NSURL *url = [[NSURL alloc] initWithString:photoURLString];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDownloadTask *task  = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        
        if (error == nil && httpResponse.statusCode == 200 && location != nil) {

            NSData *data = [[NSData alloc] initWithContentsOfURL:location];
            UIImage *image = [[UIImage alloc] initWithData:data];
            [[SAMCache sharedCache] setImage:image forKey:self.photoURLString];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.photo.image = image;
            });
        }
    }];
    
    [task resume];
}

@end

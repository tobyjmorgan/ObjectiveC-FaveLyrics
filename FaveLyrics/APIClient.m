//
//  APIClient.m
//  FaveLyrics
//
//  Created by redBred LLC on 12/27/16.
//  Copyright © 2016 redBred. All rights reserved.
//

/////////////////////////////////////////////////////////////////////////
// Thanks to Abhijit on stackoverflow for nifty singleton solution
// http://stackoverflow.com/questions/5381085/how-to-create-singleton-class-in-objective-c

#import "APIClient.h"
#import "Endpoint.h"

@interface APIClient()

@property (nonatomic, weak) NSURLSession *session;

@end


@implementation APIClient

////////////////////////////////////////////////
// singleton code
static APIClient *singletonObject = nil;

+ (id) sharedInstance
{
    if (! singletonObject) {
        
        singletonObject = [[APIClient alloc] init];
    }
    
    return singletonObject;
}

// stops init being called inadvertently - just returns the shared instance instead
- (id)init
{
    if (! singletonObject) {
        
        singletonObject = [super init];
        self.session = [NSURLSession sharedSession];
    }
    
    return singletonObject;
}
////////////////////////////////////////////////

- (void)fetchRequestWithEndpoint:(Endpoint * _Nonnull)endpoint completionHandler:(void (^ _Nonnull)(BOOL success, NSString * _Nullable message, NSDictionary * _Nullable results))completion {
    
    NSLog(@"Request: %@", [endpoint.urlForEndpoint absoluteString]);
    
    NSURLRequest *request = [NSURLRequest requestWithURL:endpoint.urlForEndpoint];
    
    NSURLSessionDownloadTask *task = [self.session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        BOOL success = YES;
        NSDictionary *responseDict = nil;
        NSString *message = @"";
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        
        NSLog(@"Response location: %@", [location absoluteString]);
        NSLog(@"HTTP Response status code: %ld", (long)httpResponse.statusCode);
        
        if (error != nil || httpResponse.statusCode != 200 || location == nil) {
            
            if (error != nil) {
                
                message = [NSString stringWithFormat:@"Problem fetching results: %@", error.localizedDescription];
                
            } else {
                
                message = [NSString stringWithFormat:@"Problem fetching results"];
            }
            
            success = NO;
            
        } else {
            
            NSData *data = [[NSData alloc] initWithContentsOfURL:location];
            
            if (data == nil) {
                
                success = NO;
                message = [NSString stringWithFormat:@"Unable to load temp file to NSData"];
            
            } else {
                
                responseDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                
                if (responseDict == nil) {
                    success = NO;
                    message = [NSString stringWithFormat:@"Unable to serialize NSData to JSON"];
                }

            }
        }        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(success, message, responseDict);
        });
    }];
    
    [task resume];
}

@end

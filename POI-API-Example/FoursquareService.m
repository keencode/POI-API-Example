//
//  FoursquareService.m
//  POI-API-Example
//
//  Created by Yee Peng Chia on 8/1/12.
//  Copyright (c) 2012 Keen Code LLC, Corp. All rights reserved.
//

#import "FoursquareService.h"
#import "FSNConnection.h"

// Enter your Foursquare developer keys
#define FSQ_CLIENT_ID     @""
#define FSQ_CLIENT_SECRET @""

@interface FoursquareService ()

@end

@implementation FoursquareService

@synthesize delegate = _delegate;

#pragma mark - Data loading

- (void)searchVenuesForLocation:(CLLocation *)location
{
    NSURL *url = [NSURL URLWithString:@"https://api.foursquare.com/v2/venues/search"];    
    NSString *locationStr = [NSString stringWithFormat:@"%f,%f", location.coordinate.latitude, location.coordinate.longitude];
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                locationStr, @"ll",
                                FSQ_CLIENT_ID, @"client_id",
                                FSQ_CLIENT_SECRET, @"client_secret",
                                @"20120702", @"v", // api version date
                                nil];
    
    FSNConnection *connection = [FSNConnection withUrl:url
                                                method:FSNRequestMethodGET
                                               headers:nil
                                            parameters:parameters
                                            parseBlock:^id(FSNConnection *c, NSError **error) {
                                               NSDictionary *d = [c.responseData dictionaryFromJSONWithError:error];
                                               if (!d) return nil;
                                                // example error handling.
                                                // since the demo ships with invalid credentials,
                                                // running it will demonstrate proper error handling.
                                                // in the case of the 4sq api, the meta json in the response holds error strings,
                                                // so we create the error based on that dictionary.
                                                if (c.response.statusCode != 200) {
                                                   *error = [NSError errorWithDomain:@"FSAPIErrorDomain"
                                                                                code:1
                                                                            userInfo:[d objectForKey:@"meta"]];
                                                }
                                                return c;
                                            }
                                            completionBlock:^(FSNConnection *c) {
                                                NSLog(@"complete: %@\n\nerror: %@\n\n", c, c.error);
                                                if (!c.error) {
                                                    NSError *error = nil;
                                                    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:c.responseData
                                                                                                         options:kNilOptions
                                                                                                           error:&error];
                                                    
                                                    if (!error) {
                                                        [self.delegate foursquareService:self searchVenuesDidComplete:json];
                                                    } else {
                                                        [self.delegate foursquareService:self searchVenuesDidFail:error];
                                                    }
                                                } else {
                                                    [self.delegate foursquareService:self searchVenuesDidFail:c.error];
                                                }
                                            }
                                            progressBlock:^(FSNConnection *c) {
                                                NSLog(@"progress: %@: %.2f/%.2f", c, c.uploadProgress, c.downloadProgress);
                                            }];
    
    [connection start];
}

@end

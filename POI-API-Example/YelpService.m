//
//  YelpService.m
//  POI-API-Example
//
//  Created by Peng on 9/25/12.
//  Copyright (c) 2012 Keen Code LLC. All rights reserved.
//

#import "YelpService.h"
#import "OAConsumer.h"
#import "OAToken.h"
#import "OAHMAC_SHA1SignatureProvider.h"
#import "OAMutableURLRequest.h"

// Enter your Yelp developer keys
#define YELP_CONSUMER_KEY        @""
#define YELP_CONSUMER_SECRET     @""
#define YELP_TOKEN               @""
#define YELP_TOKEN_SECRET        @""

@implementation YelpService

@synthesize delegate = _delegate;
@synthesize connection = _connection;
@synthesize responseData = _responseData;

#pragma mark - Data loading

- (void)searchVenuesForLocation:(CLLocation *)location
{
    NSString *urlStr = [NSString stringWithFormat:@"http://api.yelp.com/v2/search?ll=%f,%f",
                        location.coordinate.latitude, location.coordinate.longitude];
    NSURL *URL = [NSURL URLWithString:urlStr];
    
    OAConsumer *consumer = [[OAConsumer alloc] initWithKey:YELP_CONSUMER_KEY secret:YELP_CONSUMER_SECRET];
    OAToken *token = [[OAToken alloc] initWithKey:YELP_TOKEN secret:YELP_TOKEN_SECRET];
    
    id<OASignatureProviding, NSObject> provider = [[OAHMAC_SHA1SignatureProvider alloc] init];
    NSString *realm = nil;
    
    OAMutableURLRequest *request = [[OAMutableURLRequest alloc] initWithURL:URL
                                                                   consumer:consumer
                                                                      token:token
                                                                      realm:realm
                                                          signatureProvider:provider];
    [request prepare];
    
    self.responseData = [[NSMutableData alloc] init];
    
    self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [self.connection start];
}

#pragma mark - NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.responseData = [NSMutableData data];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.responseData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *responseString = [[NSString alloc] initWithData:self.responseData
                                                      encoding:NSUTF8StringEncoding];
    NSDictionary *response = nil;
    NSError *error = nil;
    
    response = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding]
                                               options:0
                                                 error:&error];
//    NSLog(@"connectionDidFinishLoading:%@", response);
    
    [self.delegate yelpService:self searchVenuesDidComplete:response];
    
    self.connection = nil;
    self.responseData = nil;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self.delegate yelpService:self searchVenuesDidFail:error];
    self.connection = nil;
    self.responseData = nil;
}


@end

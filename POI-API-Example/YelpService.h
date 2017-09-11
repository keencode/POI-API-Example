//
//  YelpService.h
//  POI-API-Example
//
//  Created by Peng on 9/25/12.
//  Copyright (c) 2012 Keen Code LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@class YelpService;

@protocol YelpServiceDelegate <NSObject>

- (void)yelpService:(YelpService *)service searchVenuesDidComplete:(NSDictionary *)data;

- (void)yelpService:(YelpService *)service searchVenuesDidFail:(NSError *)error;

@end

@interface YelpService : NSObject <NSURLConnectionDelegate>

@property (nonatomic, weak) id <YelpServiceDelegate> delegate;
@property (nonatomic, strong) NSURLConnection *connection;
@property (nonatomic, strong) NSMutableData *responseData;

- (void)searchVenuesForLocation:(CLLocation *)location;

@end

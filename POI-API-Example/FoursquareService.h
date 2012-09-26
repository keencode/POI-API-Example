//
//  FoursquareService.h
//  POI-API-Example
//
//  Created by Yee Peng Chia on 8/1/12.
//  Copyright (c) 2012 Cocoa Star Apps, Corp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@class FoursquareService;

@protocol FoursquareServiceDelegate <NSObject>

- (void)foursquareService:(FoursquareService *)service searchVenuesDidComplete:(NSDictionary *)data;

- (void)foursquareService:(FoursquareService *)service searchVenuesDidFail:(NSError *)error;

@end

@interface FoursquareService : NSObject

@property (nonatomic, weak) id <FoursquareServiceDelegate> delegate;

- (void)searchVenuesForLocation:(CLLocation *)location;

@end

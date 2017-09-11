//
//  YelpVenue.h
//  POI-API-Example
//
//  Created by Peng on 9/25/12.
//  Copyright (c) 2012 Keen Code LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface YelpVenue : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) CLLocation *clLocation;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end

//
//  FSVenue.h
//  POI-API-Example
//
//  Created by Yee Peng Chia on 8/2/12.
//  Copyright (c) 2012 Keen Code LLC, Corp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface FSVenue : NSObject

@property (nonatomic, copy) NSString *name;
//@property (nonatomic, copy) NSString *referralId;
//@property (nonatomic, strong) FSSpecials *specials;
//@property (nonatomic, strong) FSStats *stats;
//@property (nonatomic, assign) BOOL verified;
//@property (nonatomic, strong) FSMenu *menu;
//@property (nonatomic, copy) NSString *url;

@property (nonatomic, strong) CLLocation *clLocation;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end

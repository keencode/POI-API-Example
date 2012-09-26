//
//  YelpVenue.m
//  POI-API-Example
//
//  Created by Peng on 9/25/12.
//  Copyright (c) 2012 Cocoa Star Apps. All rights reserved.
//

#import "YelpVenue.h"

@implementation YelpVenue

@synthesize name;
@synthesize clLocation;

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.name = [dictionary objectForKey:@"name"];
        
//        NSLog(@"location:%@", [dictionary objectForKey:@"location"]);
        NSDictionary *locationDict = [[dictionary objectForKey:@"location"] objectForKey:@"coordinate"];
        self.clLocation = [[CLLocation alloc] initWithLatitude:[[locationDict objectForKey:@"latitude"] floatValue]
                                                     longitude:[[locationDict objectForKey:@"longitude"] floatValue]];
        
        NSLog(@"YelpVenue:%@, %f, %f", self.name, self.clLocation.coordinate.latitude, self.clLocation.coordinate.longitude);
    }
    
    return self;
}

@end

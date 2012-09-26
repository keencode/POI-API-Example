//
//  FSVenue.m
//  POI-API-Example
//
//  Created by Yee Peng Chia on 8/2/12.
//  Copyright (c) 2012 Cocoa Star Apps, Corp. All rights reserved.
//

#import "FSVenue.h"

@implementation FSVenue

@synthesize name;
@synthesize clLocation = _clLocation;

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.name = [dictionary objectForKey:@"name"];
        
        NSDictionary *locationDict = [dictionary objectForKey:@"location"];
        self.clLocation = [[CLLocation alloc] initWithLatitude:[[locationDict objectForKey:@"lat"] floatValue]
                                                     longitude:[[locationDict objectForKey:@"lng"] floatValue]];
        
//        NSLog(@"FSVenue:%@, %f, %f", self.name, self.clLocation.coordinate.latitude, self.clLocation.coordinate.longitude);
    }
    
    return self;
}

@end

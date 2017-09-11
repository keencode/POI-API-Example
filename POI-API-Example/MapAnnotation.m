//
//  MapAnnotation.m
//  POI-API-Example
//
//  Created by Yee Peng Chia on 8/1/12.
//  Copyright (c) 2012 Keen Code LLC, Corp. All rights reserved.
//

#import "MapAnnotation.h"

@implementation MapAnnotation

@synthesize coordinate = _coordinate;
@synthesize title = _title;
@synthesize subtitle = _subtitle;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate addressDictionary:(NSDictionary *)addressDictionary
{
    self = [super initWithCoordinate:coordinate addressDictionary:addressDictionary];
    if (self) {
        self.coordinate = coordinate;
    }
    
    return self;
}

@end

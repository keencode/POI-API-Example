//
//  MapAnnotation.h
//  POI-API-Example
//
//  Created by Yee Peng Chia on 8/1/12.
//  Copyright (c) 2012 Keen Code LLC, Corp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MapAnnotation : MKPlacemark

@property (nonatomic, readwrite, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subtitle;

@end

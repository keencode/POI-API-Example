//
//  SecondViewController.h
//  POI-API-Example
//
//  Created by Peng on 9/25/12.
//  Copyright (c) 2012 Cocoa Star Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "YelpService.h"

@interface YelpViewController : UIViewController <YelpServiceDelegate, MKMapViewDelegate>

@property (nonatomic, strong) IBOutlet MKMapView *mapView;

@property (nonatomic, strong) CLLocation *currentLocation;
@property (nonatomic, assign) MKCoordinateSpan defaultSpan;
@property (nonatomic, assign) MKCoordinateSpan currentSpan;
@property (nonatomic, strong) NSMutableArray *annotationsArr;
@property (nonatomic, strong) NSMutableDictionary *annotationsDict;

@property (nonatomic, strong) YelpService *yelpService;
@property (nonatomic, strong) NSArray *pointsOfInterest;

@end

//
//  SecondViewController.m
//  POI-API-Example
//
//  Created by Peng on 9/25/12.
//  Copyright (c) 2012 Keen Code LLC. All rights reserved.
//

#import "YelpViewController.h"
#import "MapAnnotation.h"
#import "YelpVenue.h"

@interface YelpViewController ()

- (void)updateMapView;

@end

@implementation YelpViewController

@synthesize mapView = _mapView;
@synthesize yelpService = _yelpService;
@synthesize currentLocation = _currentLocation;
@synthesize pointsOfInterest = _pointsOfInterest;
@synthesize currentSpan = _currentSpan;
@synthesize defaultSpan = _defaultSpan;
@synthesize annotationsArr = _annotationsArr;
@synthesize annotationsDict = _annotationsDict;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.annotationsArr = [NSMutableArray array];
    self.annotationsDict = [NSMutableDictionary dictionary];
    
    self.mapView.mapType = MKMapTypeStandard;
    self.mapView.showsUserLocation = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.currentLocation = [[CLLocation alloc] initWithLatitude:40.712840 longitude:-74.007742];
    self.mapView.centerCoordinate = self.currentLocation.coordinate;
    
    // Initialize the current span
    CLLocationDegrees latitudeDelta = 0.00474;
    CLLocationDegrees longitudeDelta = 0.00688;
    self.defaultSpan = MKCoordinateSpanMake(latitudeDelta, longitudeDelta);
    
    // Set the map's viewable region
    MKCoordinateRegion viewRegion = MKCoordinateRegionMake(self.currentLocation.coordinate, self.defaultSpan);
    [self.mapView setRegion:viewRegion animated:NO];
    
    // Call the Yelp api
    self.yelpService = [[YelpService alloc] init];
    self.yelpService.delegate = self;
    [self.yelpService searchVenuesForLocation:self.currentLocation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - YelpService delegate methods

- (void)yelpService:(YelpService *)service searchVenuesDidComplete:(NSDictionary *)data
{
    //    NSLog(@"searchVenuesDidComplete:%@", data);
    NSArray *venues = [data objectForKey:@"businesses"];
    
    if (venues != nil && [venues count] > 0) {
        NSMutableArray *venuesArr = [[NSMutableArray alloc] initWithCapacity:[venues count]];
        NSDictionary *item = nil;
        YelpVenue *venue = nil;
        
        for (item in venues) {
            //            NSLog(@"item:%@", item);
            // Create the FSVenue object
            venue = [[YelpVenue alloc] initWithDictionary:item];
            [venuesArr addObject:venue];
        }
        
        self.pointsOfInterest = [NSArray arrayWithArray:venuesArr];
        self.annotationsArr = [NSMutableArray arrayWithCapacity:[venuesArr count]];
        self.annotationsDict = [NSMutableDictionary dictionaryWithCapacity:[venuesArr count]];
        
        [self updateMapView];
    }
}

- (void)yelpService:(YelpService *)service searchVenuesDidFail:(NSError *)error
{
    NSLog(@"searchVenuesDidFail:%@", [error userInfo]);
}

#pragma mark - Instance method

- (void)updateMapView
{
    // Create Annotations and add them to the MapView
    NSMutableArray *newAnnotations = [[NSMutableArray alloc] init];
    YelpVenue *venue = nil;
    MapAnnotation *annotation = nil;
    
    for (venue in self.pointsOfInterest)
    {
        if ([self.annotationsDict objectForKey:venue.name] == nil) {
            CLLocationCoordinate2D targetCoord = venue.clLocation.coordinate;
            annotation = [[MapAnnotation alloc] initWithCoordinate:targetCoord
                                                 addressDictionary:nil];
            
            annotation.title = venue.name;
            [self.annotationsDict setValue:annotation forKey:annotation.title];
        } else {
            annotation = (MapAnnotation *)[self.annotationsDict objectForKey:venue.name];
        }
        
        [newAnnotations addObject:annotation];
    }
    
    // Loop through annotationsArr to remove unused annotations
    for (annotation in self.annotationsArr) {
        if (![newAnnotations containsObject:annotation]) {
            [self.mapView removeAnnotation:annotation];
        }
    }
    
    // Add new annotations
    for (annotation in newAnnotations) {
        if (![self.annotationsArr containsObject:annotation]) {
            [self.mapView addAnnotation:annotation];
        }
    }
    
    self.annotationsArr = newAnnotations;
}

#pragma mark - MapViewDelegate implementation

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"mapAnnotation"];
    
    if (annotationView) {
        [annotationView prepareForReuse];
    } else {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                                         reuseIdentifier:@"mapAnnotation"];
    }
    
    annotationView.canShowCallout = YES;
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    // Zooms the mapView to fit the annotation views
    MKMapRect zoomRect = MKMapRectNull;
    for (id <MKAnnotation> annotation in mapView.annotations)
    {
        MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.1, 0.1);
        if (MKMapRectIsNull(zoomRect)) {
            zoomRect = pointRect;
        } else {
            zoomRect = MKMapRectUnion(zoomRect, pointRect);
        }
    }
    
    [mapView setVisibleMapRect:zoomRect animated:YES];
}

@end

//
//  FacebookService.swift
//  POI-API-Example
//
//  Created by Yee Peng Chia on 9/24/17.
//  Copyright © 2017 Keen Code LLC. All rights reserved.
//

import Foundation
import CoreLocation
import FacebookCore

class FacebookService {
    
    static func fetchPlaces(with location: CLLocation,
                            successHandler: @escaping ((_ points: [Venue]) -> Void),
                            failureHandler: @escaping ((_ error: Error) -> Void)) {
        
//        let placesManager = FBSDKPlace
//        
//        FBSDKPlacesManager *placesManager = [FBSDKPlacesManager new]; // You should keep a strong reference to the manager, likely as a property.
//        
//        [placesManager
//            generateCurrentPlaceRequestWithMinimumConfidenceLevel:FBSDKPlaceLocationConfidenceLow
//            fields:@[
//            FBSDKPlacesFieldKeyName,
//            FBSDKPlacesFieldKeyAbout,
//            FBSDKPlacesFieldKeyPlaceID,
//            FBSDKPlacesFieldKeyLocation,
//            FBSDKPlacesFieldKeyConfidence
//            ]
//            completion:^(FBSDKGraphRequest * _Nullable graphRequest, NSError * _Nullable error) {
//            if (graphRequest) {
//            [graphRequest startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
//            // Handle the response.
//            // The result will contain the JSON data for the place candidates.
//            }];
//            }
//            }];
        
    }
    
}

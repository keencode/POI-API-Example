//
//  GoogleService.swift
//  POI-API-Example
//
//  Created by Yee Peng Chia on 9/24/17.
//  Copyright © 2017 Keen Code LLC. All rights reserved.
//

import Foundation
import GooglePlaces

class GoogleService {
    
    static func fetchPlaces(with location: CLLocation,
                            successHandler: @escaping ((_ points: [Venue]) -> Void),
                            failureHandler: @escaping ((_ error: Error) -> Void)) {
        
        let placesClient = GMSPlacesClient.shared()
        
        placesClient.currentPlace(callback: { (placeLikelihoodList, error) -> Void in
            if let error = error {
                print("Pick Place error: \(error.localizedDescription)")
                return
            }
            
            if let placeLikelihoodList = placeLikelihoodList {
                for likelihood in placeLikelihoodList.likelihoods {
                    let place = likelihood.place
                    print("Current Place name \(place.name) at likelihood \(likelihood.likelihood)")
                    print("Current Place address \(place.formattedAddress)")
                    print("Current Place attributions \(place.attributions)")
                    print("Current PlaceID \(place.placeID)")
                }
            }
        })
    }
    
}

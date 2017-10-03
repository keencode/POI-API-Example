//
//  APIService.swift
//  POI-API-Example
//
//  Created by Yee Peng Chia on 9/10/17.
//  Copyright © 2017 Keen Code LLC. All rights reserved.
//

import Foundation
import CoreLocation

enum APIType: Int {
    case facebook
    case google
    case yelp
}

class APIService: NSObject {
    
    static func fetchData(for type: APIType,
                          location: CLLocation,
                          successHandler: @escaping ((_ points: [Venue]) -> Void),
                          failureHandler: @escaping ((_ error: Error) -> Void)) {
        switch type {
        case .facebook:
            FacebookService.fetchPlaces(with: location,
                                        successHandler: successHandler,
                                        failureHandler: failureHandler)
        case .google:
            GoogleService.fetchPlaces(with: location,
                                      successHandler: successHandler,
                                      failureHandler: failureHandler)
        case .yelp:
            self.fetchYelp(with: location, successHandler: successHandler, failureHandler: failureHandler)
        default:
            break
        }
    }
    
    static func fetchYelp(with location: CLLocation,
                          successHandler: @escaping ((_ points: [Venue]) -> Void),
                          failureHandler: @escaping ((_ error: Error) -> Void)) {
        
    }
}

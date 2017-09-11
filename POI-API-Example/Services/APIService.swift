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
                          successHandler: ((_ points: [Venue]) -> Void),
                          failureHandler: ((_ error: Error) -> Void)) {
        switch type {
        case .facebook:
            self.fetchFacebook(with: location, successHandler: successHandler, failureHandler: failureHandler)
        case .google:
            self.fetchGoogle(with: location, successHandler: successHandler, failureHandler: failureHandler)
        case .yelp:
            self.fetchYelp(with: location, successHandler: successHandler, failureHandler: failureHandler)
        default:
            break
        }
    }
    
    static func fetchFacebook(with location: CLLocation,
                              successHandler: ((_ points: [Venue]) -> Void),
                              failureHandler: ((_ error: Error) -> Void)) {
        
    }
    
    static func fetchGoogle(with location: CLLocation,
                            successHandler: ((_ points: [Venue]) -> Void),
                            failureHandler: ((_ error: Error) -> Void)) {
        
    }
    
    static func fetchYelp(with location: CLLocation,
                          successHandler: ((_ points: [Venue]) -> Void),
                          failureHandler: ((_ error: Error) -> Void)) {
        
    }
}

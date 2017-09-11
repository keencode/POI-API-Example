//
//  Venue.swift
//  POI-API-Example
//
//  Created by Yee Peng Chia on 9/10/17.
//  Copyright © 2017 Keen Code LLC. All rights reserved.
//

import Foundation
import CoreLocation

struct Venue {

    let name: String
    let location: CLLocation
    
    init(withFacebook dictionary: [String : Any]) {
        self.name = "name"
        self.location = CLLocation(latitude: 45.0, longitude: 72.0)
    }
    
    init(withGoogle dictionary: [String : Any]) {
        self.name = "name"
        self.location = CLLocation(latitude: 45.0, longitude: 72.0)
    }
    
    init(withYelp dictionary: [String : Any]) {
        self.name = "name"
        self.location = CLLocation(latitude: 45.0, longitude: 72.0)
    }
}

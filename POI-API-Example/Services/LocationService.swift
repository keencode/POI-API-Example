//
//  LocationService.swift
//  POI-API-Example
//
//  Created by Yee Peng Chia on 9/10/17.
//  Copyright © 2017 Keen Code LLC. All rights reserved.
//

import Foundation
import CoreLocation

enum LocationServiceError: Error {
    case permissionNotGranted
    case fetchLocationFailed
}

class LocationService: NSObject {
    
    // MARK: - Singleton
    
    static let sharedInstance = LocationService()
    
    // MARK: - Properties
    
    var distanceFilter: CLLocationDistance = 50.0
    var stopTimerDuration: TimeInterval = 5.0
    var lastKnownExpiration: TimeInterval = 15 * 60
    var locationManager = CLLocationManager()
    var locationTimer: Timer?
    var lastKnownLocation: CLLocation?
    var lastKnownTimeStamp: Date?
    
    typealias RequestPermissionSuccessType = (Bool) -> Void
    typealias FetchLocationProgressType = (CLLocation) -> Void
    typealias FetchLocationCompletionType = (CLLocation) -> Void
    typealias FailureClosureType = (Error) -> Void
    
    var requestPermissionSuccessHandler: RequestPermissionSuccessType?
    var requestPermissionFailureHandler: FailureClosureType?
    var fetchLocationProgressHandler: FetchLocationProgressType?
    var fetchLocationCompleteHandler: FetchLocationCompletionType?
    var fetchLocationFailureHandler: FailureClosureType?
    
    // MARK: - Initialization
    
    override init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.distanceFilter = distanceFilter
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    }
    
    // MARK: - Permissions
    
    var canAccessLocation: Bool {
        let canAccessLocation = CLLocationManager.locationServicesEnabled() &&
            (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse)
        return canAccessLocation
    }
    
    var permissionDenied: Bool {
        return CLLocationManager.authorizationStatus() == CLAuthorizationStatus.denied
    }
    
    func requestPermission(successHandler: @escaping RequestPermissionSuccessType,
                           failureHandler: @escaping FailureClosureType) {
        requestPermissionSuccessHandler = successHandler
        requestPermissionFailureHandler = failureHandler
        locationManager.requestWhenInUseAuthorization()
    }
    
    // MARK: - Fetching location
    
    func fetchCurrentLocation(with progressHandler: @escaping FetchLocationProgressType,
                              completionHandler: @escaping FetchLocationCompletionType,
                              failureHandler: @escaping FailureClosureType) {
        locationTimer?.invalidate()
        locationTimer = nil
        
        fetchLocationProgressHandler = progressHandler
        fetchLocationCompleteHandler = completionHandler
        fetchLocationFailureHandler = failureHandler
        
        locationManager.startUpdatingLocation()
        
        locationTimer = Timer.scheduledTimer(timeInterval: stopTimerDuration,
                                             target: self,
                                             selector: #selector(LocationService.stopUpdatingLocation),
                                             userInfo: nil,
                                             repeats: true)
    }
    
    func stopUpdatingLocation() {
        print("location manager stopped")
        locationTimer?.invalidate()
        locationTimer = nil
        locationManager.stopUpdatingLocation()
        
        guard let location = lastKnownLocation else {
            if let failureHandler = fetchLocationFailureHandler {
                failureHandler(LocationServiceError.fetchLocationFailed)
            }
            return
        }
        
        if let completeHandler = fetchLocationCompleteHandler {
            completeHandler(location)
        }
        
        fetchLocationProgressHandler = nil
        fetchLocationCompleteHandler = nil
        fetchLocationFailureHandler = nil
    }
    
    func startMonitoringSignificantLocationChanges() {
        locationManager.startMonitoringSignificantLocationChanges()
    }

    func stopMonitoringSignificantLocationChanges() {
        locationManager.stopMonitoringSignificantLocationChanges()
    }
    
    // MARK: - Helpers
    
    var lastKnownLocationHasExpired: Bool {
        guard let timeStamp = lastKnownTimeStamp else {
            return true
        }
        
        let expired = (timeStamp.timeIntervalSinceNow < -lastKnownExpiration)
        return expired
    }
}

extension LocationService : CLLocationManagerDelegate {
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.denied {
            if let failureHander = requestPermissionFailureHandler {
                failureHander(LocationServiceError.permissionNotGranted)
                return
            }
        }
        
        if canAccessLocation {
            if let successHandler = requestPermissionSuccessHandler {
                successHandler(true)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let newLocation = locations.last {
            guard let lastKnownLoc = lastKnownLocation else {
                lastKnownLocation = newLocation
                lastKnownTimeStamp = Date()
//                print("lastKnownTimeStamp: \(lastKnownTimeStamp)")
                
                if let progressHandler = fetchLocationProgressHandler {
                    progressHandler(newLocation)
                }
                return
            }
            
            if let progressHandler = fetchLocationProgressHandler {
                progressHandler(newLocation)
            }
            
//            print("newLocation.horizontalAccuracy: \(newLocation.horizontalAccuracy)")
//            print("lastKnownLoc.horizontalAccuracy: \(lastKnownLoc.horizontalAccuracy)")
            
            if newLocation.horizontalAccuracy < lastKnownLoc.horizontalAccuracy {
                lastKnownLocation = newLocation
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let failureHandler = fetchLocationFailureHandler {
            failureHandler(error)
        }
    }

}

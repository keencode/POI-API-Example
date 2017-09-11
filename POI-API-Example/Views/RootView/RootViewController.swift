//
//  RootViewController.swift
//  POI-API-Example
//
//  Created by Yee Peng Chia on 9/10/17.
//  Copyright © 2017 Keen Code LLC. All rights reserved.
//

import UIKit
import CoreLocation

class RootViewController: UITableViewController {
    
    let locationService = LocationService.sharedInstance
    var currentLocation: CLLocation?

    override func viewDidLoad() {
        super.viewDidLoad()

        if locationService.canAccessLocation {
            fetchCurrentLocation()
        }
        else {
            locationService.requestPermission(successHandler: { (success) in
                self.fetchCurrentLocation()
            }, failureHandler: { (error) in
                //
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchCurrentLocation() {
        locationService.fetchCurrentLocation(with: { (location) in
            self.currentLocation = location
        }, completionHandler: { (location) in
            self.currentLocation = location
        }, failureHandler: { (error) in
            //
        })
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        switch indexPath.row {
        case APIType.facebook.rawValue:
            cell?.textLabel?.text = "Facebook Graph"
        case APIType.google.rawValue:
            cell?.textLabel?.text = "Google Places"
        case APIType.yelp.rawValue:
            cell?.textLabel?.text = "Yelp"
        default:
            break
        }
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mapVC = storyboard?.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        mapVC.apiType = APIType(rawValue: indexPath.row)
        mapVC.location = currentLocation
        
        navigationController?.pushViewController(mapVC, animated: true)
    }
}

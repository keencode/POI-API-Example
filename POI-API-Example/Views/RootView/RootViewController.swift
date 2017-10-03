
//
//  RootViewController.swift
//  POI-API-Example
//
//  Created by Yee Peng Chia on 9/10/17.
//  Copyright © 2017 Keen Code LLC. All rights reserved.
//

import UIKit
import CoreLocation
import FacebookCore

class RootViewController: UITableViewController {
    
    let locationService = LocationService.sharedInstance
    var currentLocation: CLLocation?

    override func viewDidLoad() {
        super.viewDidLoad()
    
        guard let _ = AccessToken.current else {
            presentLogin()
            return
        }
    
        // User is logged in, use 'accessToken' here.
        checkLocationPermission()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        var title = "Login"
        
        if let _ = AccessToken.current {
            title = "Logout"
        }
        
        let loginButton = UIBarButtonItem(title: title,
                                          style: .plain,
                                          target: self,
                                          action: #selector(RootViewController.presentLogin))
        navigationItem.rightBarButtonItem = loginButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc fileprivate func presentLogin() {
        guard let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else {
            return
        }
        
        loginVC.delegate = self
        let navController = UINavigationController(rootViewController: loginVC)        
        present(navController, animated: true, completion: nil)
    }
    
    fileprivate func checkLocationPermission() {
        if locationService.canAccessLocation {
            print("canAccessLocation: \(locationService.canAccessLocation)")
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
    
    fileprivate func fetchCurrentLocation() {
        locationService.fetchCurrentLocation(with: { (location) in
            self.currentLocation = location
        },
        completionHandler: { (location) in
            self.currentLocation = location
            
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
                //
            })
            let message = "latitude: \(location.coordinate.latitude) longitude: \(location.coordinate.longitude)"
            let alertController = UIAlertController(title: "Location Found", message: message, preferredStyle: .alert)
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
        },
        failureHandler: { (error) in
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

extension RootViewController: LoginViewControllerDelegate {
    
    func loginViewControllerShouldClose() {
        dismiss(animated: true, completion: nil)
    }
}

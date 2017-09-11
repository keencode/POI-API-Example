//
//  MapViewController.swift
//  POI-API-Example
//
//  Created by Yee Peng Chia on 9/10/17.
//  Copyright © 2017 Keen Code LLC. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    @IBOutlet var mapView: MKMapView!
    
    var apiType: APIType?
    var location: CLLocation?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let type = apiType, let loc = location else {
            return
        }
        
        APIService.fetchData(for: type,
                             location: loc,
                             successHandler: { venues in
            //
        }) { (error) in
            //
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

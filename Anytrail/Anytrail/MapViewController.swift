//
//  MapViewController.swift
//  Anytrail
//
//  Created by Ryan Cohen on 8/4/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Mapbox
import UIKit

class MapViewController: UIViewController, MGLMapViewDelegate {
    
    @IBOutlet var mapView: MGLMapView!
    
    // MARK: - Mapbox
    
    func mapView(mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }
    
    func addAnnotation() {
        let pin = MGLPointAnnotation()
        pin.coordinate = CLLocationCoordinate2D(latitude: 40.70528, longitude: -74.014025)
        pin.title = "Flatiron School"
        pin.subtitle = "Bowling Green Offices"
        
        mapView.addAnnotation(pin)
    }
    
    // MARK: - View

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        addAnnotation()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func userProfileTapped(sender: AnyObject) {
        presentUserDataView()
    }
    
    func presentUserDataView() {
        let userHealthDataView = HealthDataViewController()
        presentViewController(userHealthDataView, animated: true) {
            print("Health View Presented")
        }
    }
}

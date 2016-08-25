//
//  LocationDataStore.swift
//  Anytrail
//
//  Created by Elli Scharlin on 8/17/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import CoreLocation
import MapKit

class LocationDataStore {
    
    static let sharedInstance = LocationDataStore()
    
    var origin: CLLocation?
    var destination: CLLocation?
    var originString: String?
    var destinationString: String?
    var longLatArray: [Double]?
    
}

extension LocationDataStore {
    
    func findDistance(origin: CLLocation, destination: CLLocation) -> Double {
        return origin.distanceFromLocation(destination)
    }
    
    func pointOfInterestDistancePadding() -> Double? {
        guard let destination = destination, origin = origin else {
            return nil
        }
        return findDistance(origin, destination: destination) / 2
    }
    
    func midpointCoordinates(fromLocation: CLLocation, toLocation: CLLocation) -> CLLocationCoordinate2D {
        guard (fromLocation.coordinate.latitude, fromLocation.coordinate.longitude) != (toLocation.coordinate.latitude, toLocation.coordinate.latitude) else {
            return fromLocation.coordinate
        }
        return CLLocationCoordinate2D(latitude: (fromLocation.coordinate.latitude + toLocation.coordinate.latitude) / 2, longitude: (fromLocation.coordinate.longitude + toLocation.coordinate.longitude) / 2)
    }
    
    func returningLongLatArray() -> [CLLocationCoordinate2D]? {
        guard let destination = destination, origin = origin else {
            return nil
        }
        
        var destinationsPoints = [CLLocationCoordinate2D]()
        let midpoint = midpointCoordinates(origin, toLocation: destination)
        let startQuaterpoint = midpointCoordinates(origin, toLocation: CLLocation(latitude: midpoint.latitude, longitude: midpoint.longitude))
        let endQuaterpoint = midpointCoordinates(CLLocation(latitude: midpoint.latitude, longitude: midpoint.longitude), toLocation: destination)
        
        destinationsPoints.append(midpoint)
        destinationsPoints.append(startQuaterpoint)
        destinationsPoints.append(endQuaterpoint)
        
        return destinationsPoints
    }
}
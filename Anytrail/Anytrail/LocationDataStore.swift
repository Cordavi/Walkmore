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
    var destinationsPoints = [CLLocationCoordinate2D]()
    let halfMileRadius = 805.0
    var routeDistance = 0.0
}

extension LocationDataStore {
    
    func findDistance(origin: CLLocation, destination: CLLocation) -> Double {
        return origin.distanceFromLocation(destination)
    }
    
    func findEpicenterPoints(location: CLLocation, distanceBetweenSpheres: Double, destination: CLLocation) -> CLLocation {
        let latitudeLongitudeOffset = 111111.0
        
        
        /////coordinates////
        let sphereTopCoordinates = CLLocation(latitude: (location.coordinate.latitude + (distanceBetweenSpheres / latitudeLongitudeOffset)), longitude: location.coordinate.longitude)
        
        let sphereTopRightCoordinates = CLLocation(latitude: (location.coordinate.latitude + (distanceBetweenSpheres / latitudeLongitudeOffset)), longitude: location.coordinate.longitude + (distanceBetweenSpheres / latitudeLongitudeOffset))
        
        let sphereTopLeftCoordinates = CLLocation(latitude: (location.coordinate.latitude + (distanceBetweenSpheres / latitudeLongitudeOffset)), longitude: location.coordinate.longitude - (distanceBetweenSpheres / latitudeLongitudeOffset))
        
        
        let sphereBottomCoordinates = CLLocation(latitude: (location.coordinate.latitude - (distanceBetweenSpheres / latitudeLongitudeOffset)), longitude: location.coordinate.longitude)
        
        let sphereBottomRightCoordinates = CLLocation(latitude: (location.coordinate.latitude - (distanceBetweenSpheres / latitudeLongitudeOffset)), longitude: location.coordinate.longitude + (distanceBetweenSpheres / latitudeLongitudeOffset))
        
        let sphereBottomLeftCoordinates = CLLocation(latitude: (location.coordinate.latitude - (distanceBetweenSpheres / latitudeLongitudeOffset)), longitude: location.coordinate.longitude - (distanceBetweenSpheres / latitudeLongitudeOffset))
        
        let sphereRightCoordinates = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude + (distanceBetweenSpheres / latitudeLongitudeOffset))
        
        let sphereLeftCoordinates = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude - (distanceBetweenSpheres / latitudeLongitudeOffset))
        
        ////coordinate distant pairs
        let topCoordinatesDistancePair = (sphereTopCoordinates, findDistance(sphereTopCoordinates, destination: destination))
        
        let topRightCoordinatesDistancePair = (sphereTopRightCoordinates, findDistance(sphereTopRightCoordinates, destination: destination))
        
        let topLeftCoordinatesDistancePair = (sphereTopLeftCoordinates, findDistance(sphereTopLeftCoordinates, destination: destination))
        
        let bottomCoordinatesDistancePair = (sphereBottomCoordinates, findDistance(sphereBottomCoordinates, destination: destination))
        
        let bottomRightCoordinatesDistancePair = (sphereBottomRightCoordinates, findDistance(sphereBottomRightCoordinates, destination: destination))
        
        let bottomLeftCoordinatesDistancePair = (sphereBottomLeftCoordinates, findDistance(sphereBottomLeftCoordinates, destination: destination))
        
        let rightCoordinatesDistancePair = (sphereRightCoordinates, findDistance(sphereRightCoordinates, destination: destination))
        
        let leftCoordinatesDistancePair = (sphereLeftCoordinates, findDistance(sphereLeftCoordinates, destination: destination))
        
        let distances = [topRightCoordinatesDistancePair, topLeftCoordinatesDistancePair,bottomRightCoordinatesDistancePair, bottomLeftCoordinatesDistancePair, bottomCoordinatesDistancePair, rightCoordinatesDistancePair, leftCoordinatesDistancePair]
        
        var shortestDistanceCoordinatePair = topCoordinatesDistancePair
        
        for distanceCoordinatePair in distances {
            if shortestDistanceCoordinatePair.1 > distanceCoordinatePair.1 {
                shortestDistanceCoordinatePair = distanceCoordinatePair
            }
        }
        
        return shortestDistanceCoordinatePair.0
    }
    
    func returningLongLatArray() -> [CLLocation]? {
        guard let destination = destination, origin = origin else {
            return nil
        }
        
        routeDistance = findDistance(origin, destination: destination)
        let sphereNumberLimit = 25.0
        var numberOfSpheres = round(routeDistance / halfMileRadius) ?? 1
        var distanceBetweenSpheres = halfMileRadius
        
        if numberOfSpheres > sphereNumberLimit {
            numberOfSpheres = sphereNumberLimit
            distanceBetweenSpheres = routeDistance / sphereNumberLimit
        }
        
        var currentCoordinate = origin
        var destinationsLocations = [CLLocation]()
        
        for _ in 1...Int(numberOfSpheres) {
            
            let epicenterToAdd = findEpicenterPoints(currentCoordinate, distanceBetweenSpheres: distanceBetweenSpheres, destination: destination)
            destinationsLocations.append(epicenterToAdd)
            currentCoordinate = epicenterToAdd
            
        }
        
        return destinationsLocations
    }
}
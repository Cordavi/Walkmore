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
    var foursquareData: Set<FoursquareData> = []
    
    
    func fetchLocationsFromFoursquareWithCompletion(centerPoint: CLLocation, completion: Bool -> ()) {
        let parameter = ["client_id": Keys.fourSquareClientID,
                         "client_secret": Keys.fourSquareClientSecret,
                         "v": "20160826",
                         "intent": "browse",
                         "ll": "\(centerPoint.coordinate.latitude), \(centerPoint.coordinate.longitude)",
                         "radius": "\(searchRadius)",
                         "categoryId": "\(ATConstants.Endpoints.monumentLandmarkID),\(ATConstants.Endpoints.trialID),\(ATConstants.Endpoints.waterfrontID),\(ATConstants.Endpoints.sculptureGardenID),\(ATConstants.Endpoints.scenicLookoutID),\(ATConstants.Endpoints.pedestrianPlaza),\(ATConstants.Endpoints.parkID),\(ATConstants.Endpoints.nationalParkID),\(ATConstants.Endpoints.gardenID),\(ATConstants.Endpoints.bridgeID),\(ATConstants.Endpoints.botanticalGardenID),\(ATConstants.Endpoints.breweryID),\(ATConstants.Endpoints.streetFairID),\(ATConstants.Endpoints.publicArtID),\(ATConstants.Endpoints.museumID),\(ATConstants.Endpoints.historicSiteID)"]
        
        FoursquareAPIClient.getQueryForSearchLandmarks(parameter) { itemsJSON in
            guard let itemsArray = itemsJSON.0?.dictionary!["venues"]?.array else {
                print("error: no data recieved from API Client")
                completion(false)
                return
            }
            
            for venue in itemsArray {
                self.foursquareData.insert(FoursquareData(json: venue))
            }
            completion(true)
        }
    }
    
    var totalDistance: Double {
        guard let destination = destination, origin = origin else {
            return 0
        }
        return origin.distanceFromLocation(destination)
    }
    
    var searchRadius: Double {
        return totalDistance/2
    }
    
    
    func midpointCoordinates() -> CLLocation? {
        guard let destination = destination, origin = origin else {
            return nil
        }
        
        let centerLatitidue = (origin.coordinate.latitude + destination.coordinate.latitude) / 2
        let centerLongitude = (origin.coordinate.longitude + destination.coordinate.longitude) / 2
        return CLLocation(latitude: centerLatitidue, longitude: centerLongitude)
    }
    
}
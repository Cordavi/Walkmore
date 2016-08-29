//
//  FoursquareAPIClient.swift
//  Anytrail
//
//  Created by Elli Scharlin on 8/8/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class FoursquareAPIClient {
    
    class func getQueryForSearchLandmarks(parameter: [String: String], completion: (JSON?, ErrorType?) -> ()) {
        
        Alamofire.request(.GET, ATConstants.Endpoints.FOURSQUARE_GET_VENUES, parameters: parameter, headers: nil).responseJSON { response in
            guard let data = response.data, responseJSON = JSON(data: data).dictionary?["response"] else {
                completion(nil,response.result.error)
                return
            }
            completion(responseJSON, nil)
        }
    }
}

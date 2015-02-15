//
//  YelpAPI.swift
//  Yelp
//
//  Credits - Based off Timothy Lee's YelpClient (https://github.com/codepath/ios_yelp_swift/blob/master/Yelp/YelpClient.swift)
//
//  Created by Jamie Tsao on 2/10/15.
//  Copyright (c) 2015 Jamie Tsao. All rights reserved.
//

import Foundation
import UIKit

class YelpClient: BDBOAuth1RequestOperationManager {

    let MetersPerMile = 1609.34
    
    let YelpApiUrl = "http://api.yelp.com/v2/"
    
    var accessToken: String!
    var accessSecret: String!

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(consumerKey key: String!, consumerSecret secret: String!, accessToken: String!, accessSecret: String!) {
        self.accessToken = accessToken
        self.accessSecret = accessSecret
        var baseUrl = NSURL(string: YelpApiUrl)
        super.init(baseURL: baseUrl, consumerKey: key, consumerSecret: secret);
        
        var token = BDBOAuth1Credential(token: accessToken, secret: accessSecret, expiration: nil)
        self.requestSerializer.saveAccessToken(token)
    }
    
    func search(term: String, dealsFilter: String, radiusFilterInMiles: String, sortFilter: String, categoryFilter: String, success: (AFHTTPRequestOperation!, AnyObject!) -> Void, failure: (AFHTTPRequestOperation!, NSError!) -> Void) -> Void {

        var parameters = [ "location": "San Francisco" ]
                    
        if !term.isEmpty {
            parameters["term"] = term
        }
        if !dealsFilter.isEmpty {
            parameters["deals_filter"] = dealsFilter
        }
        if !radiusFilterInMiles.isEmpty {
            parameters["radius_filter"] = toMeters(miles: radiusFilterInMiles)
        }
        if !sortFilter.isEmpty {
            parameters["sort"] = sortFilter
        }
        if !categoryFilter.isEmpty {
            parameters["category_filter"] = categoryFilter
        }

        NSLog("Yelp params: \(parameters)")
        
        // invoke API call with handlers
        self.GET("search", parameters: parameters, success: success, failure: failure)
    }
    
    private func toMeters(miles m: String) -> String {
        let miles = (m as NSString).doubleValue
        return String(format:"%f", miles * MetersPerMile)
    }
    
}


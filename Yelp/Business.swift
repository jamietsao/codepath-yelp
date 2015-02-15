//
//  Business.swift
//  Yelp
//
//  Created by Jamie Tsao on 2/14/15.
//  Copyright (c) 2015 Jamie Tsao. All rights reserved.
//

import Foundation

/**
* Model object to represent a Yelp business entity
*/
class Business {
    
    let id: String                  // "subway-san-francisco-14"
    let businessImageUrl: String!   // "http://s3-media2.fl.yelpcdn.com/bphoto/fliioY0RmhL0TvRr9rC1Jg/ms.jpg"
    let name: String                // "Subway"
    let ratingImageUrl: String      // "http://s3-media3.fl.yelpcdn.com/assets/2/www/img/34bc8086841c/ico/stars/v1/stars_3.png"
    let reviewCount: Int            // 46
    let address: [String]           // [ "388 Market St", "Ste 102" ]
    let neighborhoods: [String]     // [ "Financial District", "SoMa" ]
    let city: String                // "San Francisco"
    let categories: [[String]]      // [ [ "Chinese", "chinese" ] ]
    let distance: Double             // 1451.4974956146543
    
    init(fromJSON business: NSDictionary) {
        id = business["id"] as String
        businessImageUrl = business["image_url"] as String
        name = business["name"] as String
        ratingImageUrl = business["rating_img_url"] as String
        reviewCount = business["review_count"] as Int
        var location = business["location"] as Dictionary<String, AnyObject>
        address = location["address"] as Array<String>
        neighborhoods = []
        if let arr = location["neighborhoods"] as? Array<String> {
            neighborhoods = arr
        }
        city = location["city"] as String
        categories = []
        if let arr = business["categories"] as? Array<Array<String>> {
            categories = arr
        }
        distance = business["distance"] as Double
    }
    
    func getLocationForDisplay() -> String {
        var display: [String] = []
        if self.address.count > 0 {
            display.append(self.address[0])
        }
        if self.neighborhoods.count > 0 {
            display.append(self.neighborhoods[0])
        }
        display.append(self.city)
        
        switch display.count {
        case 0:
            return ""
        case 1:
            return display[0]
        default:
            return display[0] + ", " + display[1]
        }
    }
    
    func getCategoriesForDisplay() -> String {
        var display = ""
        for category in self.categories {
            display += category[0] + ", "
        }
        return display.utf16Count > 1 ? display.substringToIndex(display.endIndex.predecessor().predecessor()) : ""
    }
    
    func getDistanceInMilesForDisplay() -> String {
        let miles: Double = self.distance / Constants.Math.MetersPerMile
        return String(format: "%.2f mi", miles)
    }
    
}
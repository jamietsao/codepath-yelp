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
    
    let id: String                  // "henrys-hunan-san-francisco-4"
    let businessImageUrl: String!    // "http://s3-media4.fl.yelpcdn.com/bphoto/5sLIBt7uBaM2i4NL5dhZug/ms.jpg"
    let name: String                // "Henry's Hunan"
    let ratingImageUrl: String      // "http://s3-media1.fl.yelpcdn.com/assets/2/www/img/5ef3eb3cb162/ico/stars/v1/stars_3_half.png"
    let reviewCount: Int            // 91
    let displayAddress: [String]    // [ "1398 Grant Ave", "North Beach/Telegraph Hill", "San Francisco, CA 94133" ]
    let categories: [[String]]      // [ [ "Chinese", "chinese" ] ]
    let distance: Double             // 1451.4974956146543
    
    init(fromJSON business: NSDictionary) {
        id = business["id"] as String
        businessImageUrl = business["image_url"] as String
        name = business["name"] as String
        ratingImageUrl = business["rating_img_url"] as String
        reviewCount = business["review_count"] as Int
        displayAddress = (business["location"] as Dictionary<String, AnyObject>)["display_address"] as Array<String>
        categories = business["categories"] as Array<Array<String>>
        distance = business["distance"] as Double
    }
    
    func getAddressForDisplay() -> String {
        switch self.displayAddress.count {
        case 0:
            return ""
        case 1:
            return self.displayAddress[0]
        default:
            return self.displayAddress[0] + ", " + self.displayAddress[1]
        }
    }
    
    func getCategoriesForDisplay() -> String {
        var display = ""
        for category in self.categories {
            display += category[0] + ", "
        }
        return display.substringToIndex(display.endIndex.predecessor().predecessor())
    }
    
    func getDistanceInMilesForDisplay() -> String {
        let miles: Double = self.distance / Constants.Math.MetersPerMile
        return String(format: "%.2f mi", miles)
    }
    
}
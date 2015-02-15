//
//  BusinessCell.swift
//  Yelp
//
//  Created by Jamie Tsao on 2/14/15.
//  Copyright (c) 2015 Jamie Tsao. All rights reserved.
//

import UIKit

class BusinessCell: UITableViewCell {

    private var business: Business!
    
    @IBOutlet weak var businessImage: UIImageView!
    @IBOutlet weak var businessName: UILabel!
    @IBOutlet weak var ratingImage: UIImageView!
    @IBOutlet weak var reviewCount: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var categories: UILabel!
    @IBOutlet weak var distance: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // rounded corners for business image
        self.businessImage.layer.cornerRadius = 3
        self.businessImage.clipsToBounds = true
        
//        self.businessName.preferredMaxLayoutWidth = self.businessName.frame.size.width
    }

//    override func layoutSubviews() {
//        super.layoutSubviews()
//        self.businessName.preferredMaxLayoutWidth = self.businessName.frame.size.width
//    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setBusiness(business: Business, indexRow: Int) {
        self.business = business
        
        // set IBOutlet values
        if let imageUrl = self.business.businessImageUrl {
            self.businessImage.setImageWithURL(NSURL(string: imageUrl))
        }
        var name = self.business.name
        self.businessName.text = "\(indexRow + 1). \(name)"
        self.ratingImage.setImageWithURL(NSURL(string: self.business.ratingImageUrl))
        var count = self.business.reviewCount
        self.reviewCount.text = "\(count) Reviews"
        self.address.text = self.business.getAddressForDisplay()
        self.categories.text = self.business.getCategoriesForDisplay()
        self.distance.text = self.business.getDistanceInMilesForDisplay()

    }
}

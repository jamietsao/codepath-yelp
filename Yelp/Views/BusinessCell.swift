//
//  BusinessCell.swift
//  Yelp
//
//  Created by Jamie Tsao on 2/14/15.
//  Copyright (c) 2015 Jamie Tsao. All rights reserved.
//

import UIKit

class BusinessCell: UITableViewCell {

    @IBOutlet weak var businessImage: UIImageView!
    @IBOutlet weak var businessName: UILabel!
    @IBOutlet weak var ratingImage: UIImageView!
    @IBOutlet weak var reviewCount: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var categories: UILabel!
    @IBOutlet weak var distance: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

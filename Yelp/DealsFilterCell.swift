//
//  DealsFilterCell.swift
//  Yelp
//
//  Created by Jamie Tsao on 2/12/15.
//  Copyright (c) 2015 Jamie Tsao. All rights reserved.
//

import UIKit

protocol DealsFilterDelegate: class {
    func handleFilterChange(switchValue: Bool)
}

class DealsFilterCell: UITableViewCell {

    weak var delegate: DealsFilterDelegate?
    
    @IBOutlet weak var dealsSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

    @IBAction func onSwitchChange(sender: AnyObject) {
        self.delegate?.handleFilterChange(dealsSwitch.on)
    }

}

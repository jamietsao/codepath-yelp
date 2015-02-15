//
//  SwitchFilterCell.swift
//  Yelp
//
//  Created by Jamie Tsao on 2/13/15.
//  Copyright (c) 2015 Jamie Tsao. All rights reserved.
//

import UIKit

protocol SwitchFilterDelegate: class {
    func switchFilter(switchFilterCell: SwitchFilterCell, onSwitchChange switchValue:Bool)
}

class SwitchFilterCell: UITableViewCell {

    weak var switchFilterDelegate: SwitchFilterDelegate?
    
    @IBOutlet weak var filterLabel: UILabel!
    @IBOutlet weak var filterSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onSwitchChange(sender: AnyObject) {
        if let delegate = switchFilterDelegate {
            delegate.switchFilter(self, onSwitchChange: filterSwitch.on)
        }
    }
    
}

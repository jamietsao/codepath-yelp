//
//  LabelFilterCell.swift
//  Yelp
//
//  Created by Jamie Tsao on 2/12/15.
//  Copyright (c) 2015 Jamie Tsao. All rights reserved.
//

import UIKit

protocol LabelFilterDelegate: class {
    func labelFilter(labelFilterCell: LabelFilterCell, onSelectionChange changeValue:Bool)
}

class LabelFilterCell: UITableViewCell {

    weak var labelFilterDelegate: LabelFilterDelegate?
    
    @IBOutlet weak var filterLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
//        NSLog("\(filterLabel.text): \(selected) - \(self.selected)")
        
        if let delegate = labelFilterDelegate {
            delegate.labelFilter(self, onSelectionChange: selected)
        }
        
    }
    
}

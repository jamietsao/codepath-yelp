//
//  FiltersViewController.swift
//  Yelp
//
//  Created by Jamie Tsao on 2/11/15.
//  Copyright (c) 2015 Jamie Tsao. All rights reserved.
//

import UIKit

protocol FiltersViewDelegate: class {
    // perform search
    func filtersView(filtersVC: FiltersViewController, performSearch currentFilters: [Int : String])
    // cancel and do nothing
    func filtersView(filtersVC: FiltersViewController, cancel currentFilters: [Int : String])
}

class FiltersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SwitchFilterDelegate {

    // filter section names
    let sections = [ Constants.FilterSections.Specials, Constants.FilterSections.Distance, Constants.FilterSections.Sort, Constants.FilterSections.Categories ]

    // filter names/codes
    let labelFilters = [ Constants.Filters.specialsFilters, Constants.Filters.distanceFilters, Constants.Filters.sortFilters, Constants.Filters.categoryFilters]

    // stores the currently selected filters
    // - used to search if 'Search' is clicked
    // - thrown away if 'Cancel' is clicked
    var currentFilters: Dictionary<Int, String>!
    
    // delegate to perform search off selected filters
    weak var delegate: FiltersViewDelegate?

    //
    // IBOutlets
    //
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // initialize nav bar
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Bordered, target: self, action: "onCancelButtonPress")
        cancelButton.tintColor = UIColor.whiteColor()
        let searchButton = UIBarButtonItem(title: "Search", style: UIBarButtonItemStyle.Bordered, target: self, action: "onSearchButtonPress")
        searchButton.tintColor = UIColor.whiteColor()
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = searchButton

        // initialize table view
        tableView.allowsMultipleSelection = false
        tableView.dataSource = self
        tableView.delegate = self
        
        // register custom cells
        var cellNib = UINib(nibName: "SwitchFilterCell", bundle: NSBundle.mainBundle())
        tableView.registerNib(cellNib, forCellReuseIdentifier: "SwitchFilterCell")
        cellNib = UINib(nibName: "LabelFilterCell", bundle: NSBundle.mainBundle())
        tableView.registerNib(cellNib, forCellReuseIdentifier: "LabelFilterCell")
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UITableViewHeaderFooterView()
        header.textLabel.text = sections[section]
        return header
    }

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return labelFilters[section].count
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let section = indexPath.section
        if section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("SwitchFilterCell", forIndexPath: indexPath) as SwitchFilterCell
            cell.switchFilterDelegate = self
            cell.filterLabel.text = self.labelFilters[section][0]["name"]
            if let currentValue = currentFilters[0] {
                cell.filterSwitch.on = currentValue == "true" ? true : false
            }
            return cell
        } else {
            // get selected filter
            let selectedFilter = self.labelFilters[section][indexPath.row]
            
            // dequeue cell
            let cell = tableView.dequeueReusableCellWithIdentifier("LabelFilterCell", forIndexPath: indexPath) as LabelFilterCell
            
            // set label
            cell.filterLabel.text = selectedFilter["name"]

            // set accessory type
            if selectedFilter["code"] == currentFilters[section] {
                cell.accessoryType = .Checkmark
            } else {
                cell.accessoryType = .None
            }
            
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section != 0 {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            let cell = tableView.cellForRowAtIndexPath(indexPath)
            
            // get selected filter value code
            let selectedValue = labelFilters[indexPath.section][indexPath.row]["code"]
            
            // get current value for this filter (if any)
            let currentValue = currentFilters[indexPath.section]
            
            // if selected is same as current, then remove (de-select), else set new value
            currentFilters[indexPath.section] = selectedValue == currentValue ? "" : selectedValue
            
            // reload table view
            tableView.reloadData()
        }
    }

    func switchFilter(switchFilterCell: SwitchFilterCell, onSwitchChange switchValue: Bool) {
        self.currentFilters[0] = switchValue ? "true" : "false"
    }
    
    func onCancelButtonPress() {
        // navigate back to business view without performing search or saving filter changes
        delegate?.filtersView(self, cancel: currentFilters)
    }
    
    func onSearchButtonPress() {
        // navigate back to business view with current filter selections
        delegate?.filtersView(self, performSearch: currentFilters)
    }
    
}

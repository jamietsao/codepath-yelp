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
    func filtersView(filtersVC: FiltersViewController, performSearch currentFilters: [Int : AnyObject])
    // cancel and do nothing
    func filtersView(filtersVC: FiltersViewController, cancel currentFilters: [Int : AnyObject])
}

class FiltersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SwitchFilterDelegate {

    // filter section names
    let sections = [ Constants.FilterSections.Specials, Constants.FilterSections.Distance, Constants.FilterSections.Sort, Constants.FilterSections.Categories ]

    // filter names/codes
    let labelFilters = [ Constants.Filters.specialsFilters, Constants.Filters.distanceFilters, Constants.Filters.sortFilters, Constants.Filters.categoryFilters]

    // stores the currently selected filters
    // - used to search if 'Search' is clicked
    // - thrown away if 'Cancel' is clicked
    var currentFilters: Dictionary<Int, AnyObject>!
    
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
        
        var label = UILabel(frame: CGRect(x: 12, y: 0, width: 150, height: 35))
        label.font = UIFont.boldSystemFontOfSize(15)
        label.text = sections[section]
        header.addSubview(label)
        
        return header
    }

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
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
            // SPECIALS section
            let cell = tableView.dequeueReusableCellWithIdentifier("SwitchFilterCell", forIndexPath: indexPath) as SwitchFilterCell
            cell.switchFilterDelegate = self
            cell.filterLabel.text = self.labelFilters[section][0]["name"]
            if let currentValue = currentFilters[0] as? String {
                cell.filterSwitch.on = currentValue == "true" ? true : false
            }
            return cell
        } else if section == 3 {
            //
            // CATEGORIES section - multiple selection allowed
            //
            
            // get selected filter
            let selectedFilter = self.labelFilters[section][indexPath.row]
            
            // dequeue cell
            let cell = tableView.dequeueReusableCellWithIdentifier("LabelFilterCell", forIndexPath: indexPath) as LabelFilterCell
            
            // set label
            cell.filterLabel.text = selectedFilter["name"]
            
            // set accessory type
            var currentCategories: NSMutableArray = (currentFilters[section] as? NSMutableArray)!
            if currentCategories.containsObject(selectedFilter["code"]!) {
                cell.accessoryType = .Checkmark
            } else {
                cell.accessoryType = .None
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
            if selectedFilter["code"] == currentFilters[section] as? String {
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

            if (indexPath.section == 3) {
                // CATEGORIES - allow multiple selection
                
                // get current values for this filter (if any)
                var currentCategories: NSMutableArray = (currentFilters[indexPath.section] as? NSMutableArray)!
                // if selected was previously selected, then remove (de-select), else add
                if currentCategories.containsObject(selectedValue!) {
                    currentCategories.removeObject(selectedValue!)
                } else {
                    currentCategories.addObject(selectedValue!)
                }
                currentFilters[indexPath.section] = currentCategories
                
            } else {
                // get current value for this filter (if any)
                let currentValue = currentFilters[indexPath.section] as? String
                
                // if selected is same as current, then remove (de-select), else set new value
                currentFilters[indexPath.section] = selectedValue == currentValue ? "" : selectedValue
            }
            
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

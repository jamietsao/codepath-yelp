//
//  FiltersViewController.swift
//  Yelp
//
//  Created by Jamie Tsao on 2/11/15.
//  Copyright (c) 2015 Jamie Tsao. All rights reserved.
//

import UIKit

class FiltersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let sections = [ "Deals", "Categories", "Distance", "Sort" ]
    let sortFilters = [ "Best Matched", "Distance", "Highest Rated" ]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // initialize table view
        tableView.dataSource = self
        tableView.delegate = self
        
        // register custom cells
        var cellNib = UINib(nibName: "DealsFilterCell", bundle: NSBundle.mainBundle())
        tableView.registerNib(cellNib, forCellReuseIdentifier: "DealsFilterCell")
        cellNib = UINib(nibName: "SortFilterCell", bundle: NSBundle.mainBundle())
        tableView.registerNib(cellNib, forCellReuseIdentifier: "SortFilterCell")
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
        } else if section == 3 {
            return sortFilters.count
        }
        // Return the number of rows in the section.
        return 2
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("DealsFilterCell", forIndexPath: indexPath) as DealsFilterCell
            return cell
        } else if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCellWithIdentifier("SortFilterCell", forIndexPath: indexPath) as SortFilterCell
            cell.sortFilterLabel.text = self.sortFilters[indexPath.row]
            return cell
        }
        
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: nil)
//        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...

        return cell
    }

}

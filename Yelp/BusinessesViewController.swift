//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Jamie Tsao on 2/10/15.
//  Copyright (c) 2015 Jamie Tsao. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, FiltersViewDelegate {

    let consumerKey = "3c6T6Bh2L8fzjGF7OycIXA"
    let consumerSecret = "l97nu5YapgJGdXGk-5My2gNqVVA"
    let token = "lT8ULNVmeNbsr5zK1vlyX0EnQCLJwGsg"
    let tokenSecret = "e6fO87qcUwpAcNMXMdJB1mt-Phk"

    var yelpClient: YelpClient!
    
    var searchTerm = ""
    var currentFilters = Dictionary<Int, String>()

    var businesses: [Business]!
    
    lazy var searchBar = UISearchBar(frame: CGRectMake(0, 0, 200, 20))
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var networkErrorLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // initialize nav bar
        let filterButton = UIBarButtonItem(title: "Filter", style: UIBarButtonItemStyle.Done, target: self, action: "onFilterButtonPress")
        navigationItem.leftBarButtonItem = filterButton

        // initialize table view
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension

        // register custom cells
        var cellNib = UINib(nibName: "BusinessCell", bundle: NSBundle.mainBundle())
        tableView.registerNib(cellNib, forCellReuseIdentifier: "BusinessCell")

        // initialize search bar
        searchBar.delegate = self
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar

        // initialize yelp client
        yelpClient = YelpClient(consumerKey: consumerKey, consumerSecret: consumerSecret, accessToken: token, accessSecret: tokenSecret)

        // set defaults for filters
        currentFilters[0] = "false"
        
        NSLog("BusinessesViewController - View Did Load")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // perform default search
        yelpSearch()

        NSLog("BusinessesViewController - View Did Appear")
    }
    
    func yelpSearch() {
        // show progress HUD before invoking API call
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)

        var df = "", rf = "", sf = "0", cf = ""
        if let a = currentFilters[0] {
            df = a
        }
        if let a = currentFilters[1] {
            rf = a
        }
        if let a = currentFilters[2] {
            sf = a
        }
        if let a = currentFilters[3] {
            cf = a
        }
        
        // perform search
        yelpClient.search(self.searchTerm, dealsFilter: df, radiusFilterInMiles : rf, sortFilter : sf , categoryFilter: cf,
            success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                var results: [NSDictionary] = (response["businesses"] as [NSDictionary]?) ?? []
                self.businesses = []
                for result in results {
                    self.businesses.append(Business(fromJSON: result as NSDictionary))
                }
                self.tableView.reloadData()
                self.networkErrorLabel.hidden = true
                MBProgressHUD.hideHUDForView(self.view, animated: true)
            },
            failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                NSLog("\(error)")
                self.networkErrorLabel.hidden = false
                MBProgressHUD.hideHUDForView(self.view, animated: true)
            }
        )
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        // dismiss keyboard
        self.searchBar.endEditing(true)
        // save search term
        self.searchTerm = searchBar.text
        // perform search
        yelpSearch()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let array = businesses {
            return array.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell", forIndexPath: indexPath) as BusinessCell
        
        let business = self.businesses![indexPath.row]

        if let imageUrl = business.businessImageUrl {
            cell.businessImage.setImageWithURL(NSURL(string: imageUrl))
        }
        var name = business.name
        cell.businessName.text = "\(indexPath.row + 1). \(name)"
        cell.ratingImage.setImageWithURL(NSURL(string: business.ratingImageUrl))
        var count  = business.reviewCount
        cell.reviewCount.text = "\(count) Reviews"
        cell.address.text = business.getAddressForDisplay()
        cell.categories.text = business.getCategoriesForDisplay()
        cell.distance.text = business.getDistanceInMilesForDisplay()
        
        return cell
    }
    
    func onFilterButtonPress() {
        // segue to filters view
        let filtersViewController = self.storyboard?.instantiateViewControllerWithIdentifier("FiltersViewController") as FiltersViewController
        filtersViewController.delegate = self
        filtersViewController.currentFilters = currentFilters
        self.navigationController?.pushViewController(filtersViewController, animated: true)
    }
    
    func filtersView(filtersVC: FiltersViewController, performSearch currentFilters: [Int : String]) {
        NSLog("\(currentFilters)")
        self.currentFilters = currentFilters
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

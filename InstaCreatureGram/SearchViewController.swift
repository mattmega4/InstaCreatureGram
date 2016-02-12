//
//  SearchViewController.swift
//  InstaCreatureGram
//
//  Created by Rafael Auriemo on 2/7/16.
//  Copyright © 2016 Matthew Howes Singleton. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var collectionView: UICollectionView!
    
    var searchActive: Bool = false
    var filtered: [String] = []
    var dataBase: [String] = ["matt", "hoffa", "andrew", "nader", "evan", "michael", "jess"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true
    }
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false
    }
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false
    }
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        filtered = dataBase.filter({ (text) -> Bool in
            let tmp: NSString = text
            let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return range.location != NSNotFound
        })
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.tableView.reloadData()
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtered.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        if(searchActive){
            cell.textLabel?.text = filtered[indexPath.row]
        } else {
            cell.textLabel?.text = dataBase[indexPath.row];
        }
        return cell
    }

}

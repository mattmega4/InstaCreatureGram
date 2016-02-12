//
//  SearchViewController.swift
//  InstaCreatureGram
//
//  Created by Rafael Auriemo on 2/7/16.
//  Copyright © 2016 Matthew Howes Singleton. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var collectionView: UICollectionView!
    
    var searchActive: Bool = false
    var filtered: [String] = []
    var emails = NSMutableArray()
    
    let myRootRef = Firebase(url: FirebaseUrl)
    let postArray = NSMutableArray()
    var arrayToFilter = Array<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        pullAllPosts()
        getUserEmails()
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
        arrayToFilter = NSArray(array: emails) as! [String]
        
        filtered = arrayToFilter.filter({ (text) -> Bool in
            let tmp = text as NSString
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
            cell.textLabel?.text = emails[indexPath.row] as? String
        }
        return cell
    }
    
    override func viewWillLayoutSubviews() {
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postArray.count
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        var itemsCount : CGFloat = 2.0
        if UIApplication.sharedApplication().statusBarOrientation == UIInterfaceOrientation.Portrait {
            itemsCount = 3.0
        }
        return CGSize(width: self.view.frame.width/itemsCount - 20, height: 100/100 * (self.view.frame.width/itemsCount - 20));
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("collection",
            forIndexPath: indexPath)
        let currentPost = postArray[indexPath.row] as! Creature
        cell.backgroundView = UIImageView.init(image: currentPost.image)
        
        return cell
    }
    
    func pullAllPosts() {
        self.postArray.removeAllObjects()
        let allPosts = myRootRef.childByAppendingPath("posts")
        allPosts.keepSynced(true)
        
        allPosts.queryOrderedByChild("timestamp").observeEventType(.ChildAdded, withBlock: { snapshot in
            if snapshot.value["user"] as! String != "" {
                let newCreature = Creature()
                let encodedData = snapshot.value["image"] as! String
                let decodedData = NSData(base64EncodedString: encodedData, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
                let decodedImage = UIImage(data: decodedData!)
                newCreature.image = decodedImage!
                newCreature.timestamp = snapshot.value["time"] as! NSNumber
                newCreature.creator = snapshot.value["user"] as! String
                newCreature.likes = snapshot.value["likes"] as! NSNumber
                print(snapshot.key)
                newCreature.email = snapshot.value["email"] as! String
                newCreature.id = snapshot.key
                self.postArray.addObject(newCreature)
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.collectionView.reloadData()
                })
                print("got post")
            }
        })
    }
    
    func getUserEmails() {
        var allPosts = NSDictionary()
        let posts = myRootRef.childByAppendingPath("users")
        let urlString = String(format: "%@.json", posts.description)
        let url = NSURL(string: urlString)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) { (data, response, error) -> Void in
            do {
                allPosts = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSDictionary
                let keysArray = allPosts.allKeys
                for i in 0...keysArray.count-1 {
                    let currentKey = keysArray[i] as! String
                    let currentPost = allPosts[currentKey] as! NSDictionary
                    let currentEmail = currentPost["email"]
                    self.emails.addObject(currentEmail!)
                }
                print("got emails")
                }catch let error as NSError {
                print("error"+error.localizedDescription)
            }
        }
        task.resume()
    }
    
}

//
//  UserProfileViewController.swift
//  InstaCreatureGram
//
//  Created by Rafael Auriemo on 2/7/16.
//  Copyright © 2016 Matthew Howes Singleton. All rights reserved.
//

import UIKit
import QuartzCore

class UserProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var gridArr: [UIImage]!
    
    @IBOutlet weak var profilePic: UIImageView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var postsCount: UILabel!
    
    @IBOutlet weak var followersCount: UILabel!
    
    @IBOutlet weak var followingCount: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UITextView!
    


    
    @IBOutlet weak var midNavBar: UIStackView!
    
    let myRootRef = Firebase(url: FirebaseUrl)
    
    let userPosts = NSMutableArray()
    
    let userDefaults = NSUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //change to
        self.navigationItem.title = self.userDefaults.valueForKey("useremail") as? String

        self.midNavBar.layer.borderWidth = 1
        self.midNavBar.layer.borderColor = UIColor(red:222/255.0, green:225/255.0, blue:227/255.0, alpha: 1.0).CGColor
        
        
        
        profilePic.layer.cornerRadius = 55;
        profilePic.clipsToBounds = true;
        view.addSubview(profilePic)
        
        self.automaticallyAdjustsScrollViewInsets = false
        
    }
    
    override func viewWillAppear(animated: Bool) {
        getAllPosts()
        getUserData()
    }
    
    func getUserData() {
        let users = myRootRef.childByAppendingPath("users").childByAppendingPath(UID)
        let urlString = String(format: "%@.json", users.description)
        let url = NSURL(string: urlString)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) { (data, response, error) -> Void in
            do {
                let user = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSDictionary
                let encodedData = user["profile_pic"] as! String
                let decodedData = NSData(base64EncodedString: encodedData, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
                let decodedImage = UIImage(data: decodedData!)
                self.profilePic.image = decodedImage
            }catch let error as NSError {
                print("error"+error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func getAllPosts() {
        userPosts.removeAllObjects()
        var allPosts = NSDictionary()
        let posts = myRootRef.childByAppendingPath("posts")
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
                    let newCreature = Creature()
                    let encodedData = currentPost["image"] as! String
                    let decodedData = NSData(base64EncodedString: encodedData, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
                    let decodedImage = UIImage(data: decodedData!)
                    newCreature.image = decodedImage!
                    newCreature.id = currentPost["user"] as! String
                    newCreature.email = currentPost["email"] as! String
                    newCreature.likes = currentPost["likes"] as! NSNumber
                    newCreature.timestamp = currentPost["time"] as! NSNumber
                    if UID == "" {
                        let userID = self.userDefaults.valueForKey("uid") as! String
                        if newCreature.id == userID {
                            self.userPosts.addObject(newCreature)
                        }
                    }else{
                        if newCreature.id == UID {
                            self.userPosts.addObject(newCreature)
                        }
                    }
                }
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.postsCount.text = String(self.userPosts.count)
                    self.collectionView.reloadData()
                })
            }catch let error as NSError {
                print("error"+error.localizedDescription)
            }
        }
        task.resume()
    }

    override func viewWillLayoutSubviews() {
        collectionView.collectionViewLayout.invalidateLayout()
    }
    

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        var itemsCount : CGFloat = 2.0
        if UIApplication.sharedApplication().statusBarOrientation == UIInterfaceOrientation.Portrait {
            itemsCount = 3.0
        }
        return CGSize(width: self.view.frame.width/itemsCount - 20, height: 100/100 * (self.view.frame.width/itemsCount - 20));
    }
    
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CellCV",
            forIndexPath: indexPath)
            let currentPost = userPosts[indexPath.row] as! Creature
            cell.backgroundView = UIImageView.init(image: currentPost.image)
//            cell.backgroundView = UIImageView.init(image: gridArr[indexPath.item])
        
        return cell
    }
    
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(userPosts.count)
        return userPosts.count
    }

    @IBAction func editProfileTapped(sender: AnyObject) {
    }
    
    
    
    
}

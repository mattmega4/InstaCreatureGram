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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //change to
        self.navigationItem.title = "RubberDucky4444"

        self.midNavBar.layer.borderWidth = 1
        self.midNavBar.layer.borderColor = UIColor(red:222/255.0, green:225/255.0, blue:227/255.0, alpha: 1.0).CGColor
        
        
        
        profilePic.layer.cornerRadius = 55;
        profilePic.clipsToBounds = true;
        view.addSubview(profilePic)
        
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        gridArr = [
            UIImage(named: "mid1.jpg")!,
            UIImage(named: "mid2.jpg")!,
            UIImage(named: "mid3.jpg")!,
            UIImage(named: "mid4.jpg")!,
            UIImage(named: "mid5.jpg")!,
            UIImage(named: "mid6.jpg")!,
            UIImage(named: "mid7.jpg")!,
            UIImage(named: "mid8.jpg")!,
            UIImage(named: "mid9.jpg")!,
            UIImage(named: "mid10.jpg")!,
            UIImage(named: "mid11.jpg")!,
            UIImage(named: "mid12.jpg")!,
            UIImage(named: "mid13.jpg")!,
            UIImage(named: "mid14.jpg")!,
            UIImage(named: "mid15.jpg")!
        ]
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        getAllPosts()
    }
    
    func getAllPosts() {
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
                    if newCreature.id == UID {
                        self.userPosts.addObject(newCreature)
                    }
                }
                self.collectionView.reloadData()
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
        
       
            cell.backgroundView = UIImageView.init(image: gridArr[indexPath.item])
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gridArr.count
    }

    @IBAction func editProfileTapped(sender: AnyObject) {
    }
    
    
    
    
}

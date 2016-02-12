//
//  ElementalFeedViewController.swift
//  InstaCreatureGram
//
//  Created by Matthew Howes Singleton on 2/4/16.
//  Copyright © 2016 Matthew Howes Singleton. All rights reserved.
//

import UIKit

class ElementalFeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let myRootRef = Firebase(url: FirebaseUrl)

    
    let postArray = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        pullAllPosts()
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 53.0/255, green: 70.0/255, blue: 94.0/255, alpha: 1.0)
    
    }
    
    override func viewDidAppear(animated: Bool) {
        tableView.reloadData()
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
                self.postArray.insertObject(newCreature, atIndex: 0)
                self.tableView.reloadData()
                print("got post")
                
            }
            
        })
        
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      
        let cell = self.tableView.dequeueReusableCellWithIdentifier("PostCell")! as! PostTableViewCell
        let currentPost = self.postArray[indexPath.section] as! Creature
        cell.postCreature = currentPost
        cell.postImageView!.image = currentPost.image
        cell.postID = currentPost.id
        cell.likeLabel.text = String(currentPost.likes)
        
        return cell
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return postArray.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
         return 1
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let currentCreature = self.postArray[section] as! Creature
        let header = UIView()
        let headerLabel = UILabel()
        headerLabel.text = currentCreature.email
        header.addSubview(headerLabel)
        headerLabel.frame = CGRectMake(0, 0, self.view.frame.size.width, 50)
        headerLabel.textAlignment = NSTextAlignment.Center
        headerLabel.backgroundColor = UIColor.whiteColor()

        header.alpha = 0.8
        
        return header
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        

    
        let view = UIView()
        
        
        view.backgroundColor = UIColor(red: 245.0/255, green: 245.0/255, blue: 245.0/255, alpha: 1.0)
        view.alpha = 0.8
        
        
        let version = UILabel(frame: CGRectMake(28, 5, tableView.frame.width, 30))
        version.font = version.font.fontWithSize(14)
        version.text = "insert comment here"
        version.textColor = UIColor.darkGrayColor()
        version.textAlignment = .Left;
        
 

        
        view.addSubview(version)
       
        
        return view
        
       
        
//        return title
    }
    
   
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        tableView.estimatedRowHeight = 11.0
        tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        return tableView.frame.width
    }
    
    
    
    
    func tableView(tableView: UITableView,
        heightForHeaderInSection section: Int) -> CGFloat{
            
     return 50.0
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40.0
    }

}

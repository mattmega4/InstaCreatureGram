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
            UIImage(named: "bot1.jpg")!,
            UIImage(named: "bot2.jpg")!,
            UIImage(named: "bot3.jpg")!,
            UIImage(named: "bot4.jpg")!,
            UIImage(named: "bot5.jpg")!,
            UIImage(named: "bot6.jpg")!,
            UIImage(named: "bot7.jpg")!,
            UIImage(named: "bot8.jpg")!,
            UIImage(named: "bot9.jpg")!,
            UIImage(named: "bot10.jpg")!,
            UIImage(named: "bot11.jpg")!,
            UIImage(named: "bot12.jpg")!,
            UIImage(named: "bot13.jpg")!,
            UIImage(named: "bot14.jpg")!,
            UIImage(named: "bot15.jpg")!
        ]
        
        
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

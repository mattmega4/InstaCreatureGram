//
//  UserProfileViewController.swift
//  InstaCreatureGram
//
//  Created by Rafael Auriemo on 2/7/16.
//  Copyright © 2016 Matthew Howes Singleton. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var gridArr: [UIImage]!
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

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
            UIImage(named: "mid15.jpg")!,
        ]
        
        
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

}

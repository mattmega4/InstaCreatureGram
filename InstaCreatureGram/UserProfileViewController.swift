//
//  UserProfileViewController.swift
//  InstaCreatureGram
//
//  Created by Rafael Auriemo on 2/7/16.
//  Copyright © 2016 Matthew Howes Singleton. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var gridArr: [UIImage]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        gridArr = [
            UIImage(named: "top1.png")!,
            UIImage(named: "top2.png")!,
            UIImage(named: "top3.png")!,
            UIImage(named: "top4.png")!,
            UIImage(named: "top5.png")!,
            UIImage(named: "top6.png")!,
            UIImage(named: "top7.png")!,
            UIImage(named: "top8.png")!,
            UIImage(named: "top9.png")!,
            UIImage(named: "top10.png")!
        ]
    }

    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gridArr.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CellCV",
            forIndexPath: indexPath)
        
        cell.backgroundView = UIImageView.init(image: gridArr[indexPath.item])
        
        return cell
    }



}

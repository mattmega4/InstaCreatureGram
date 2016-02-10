//
//  ElementalCreatureViewController+Extension.swift
//  InstaCreatureGram
//
//  Created by Matthew Howes Singleton on 2/8/16.
//  Copyright © 2016 Matthew Howes Singleton. All rights reserved.
//

import Foundation
import UIKit

extension ElementalCreatorViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
 
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    
    func collectionView(collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
            
            return topArr.count
    }
    
    func collectionView(collectionView: UICollectionView,
        cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
            
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CellC",
                forIndexPath: indexPath)
            
//            print(collectionView.tag)
            if collectionView.tag == 0 {
                cell.backgroundView = UIImageView.init(image: topArr[indexPath.item])
            } else if (collectionView.tag == 1) {
                cell.backgroundView = UIImageView.init(image: midArr[indexPath.item])
            } else if (collectionView.tag == 2) {
                cell.backgroundView = UIImageView.init(image: botArr[indexPath.item])
            }
            
            
            
            return cell
}

    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let cell = collectionView.cellForItemAtIndexPath(indexPath)!
//        let color = cell.contentView
//        imageViewOne.addSubview(color)
//        print("\(color)")

        
        
        if collectionView.tag == 0 {
            
            let view = cell.backgroundView as! UIImageView
            let image = view.image!
            self.imageViewOne.image = image
            
        } else if (collectionView.tag == 1) {
            
            let view = cell.backgroundView as! UIImageView
            let image = view.image!
            self.imageViewTwo.image = image
            
        } else if (collectionView.tag == 2) {
            
            let view = cell.backgroundView as! UIImageView
            let image = view.image!
            self.imageViewThree.image = image
        }
        
        
    }
    
}

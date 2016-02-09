//
//  ElementalCreatureViewController+Extension.swift
//  InstaCreatureGram
//
//  Created by Matthew Howes Singleton on 2/8/16.
//  Copyright © 2016 Matthew Howes Singleton. All rights reserved.
//

import Foundation
import UIKit

extension ElementalCreatorViewController: UICollectionViewDelegate, UICollectionViewDataSource, UIGestureRecognizerDelegate {
    
    
    
 
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
            
            cell.backgroundView = UIImageView.init(image: topArr[indexPath.item])
            
            
            return cell
}

    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let cell = collectionView.cellForItemAtIndexPath(indexPath)!
//        let color = cell.contentView
//        imageViewOne.addSubview(color)
//        print("\(color)")
        let view = cell.backgroundView as! UIImageView
        let image = view.image!
        self.imageViewOne.image = image
        
    }
    
}

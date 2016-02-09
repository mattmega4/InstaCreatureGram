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
    
    func collectionView(collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
            
            return topArr.count
    }
    
    func collectionView(collectionView: UICollectionView,
        cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
            
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CellC",
                forIndexPath: indexPath)
            
            cell.backgroundView = topArr[indexPath.item]
            //im stuck here
            
            
            return cell
}
    
}

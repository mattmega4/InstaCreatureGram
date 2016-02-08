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
            
            return model[collectionView.tag].count
    }
    
    func collectionView(collectionView: UICollectionView,
        cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
            
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CellC",
                forIndexPath: indexPath)
            
            cell.backgroundColor = model[collectionView.tag][indexPath.item]
            
            return cell
    }
}

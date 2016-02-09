//
//  Creature.swift
//  InstaCreatureGram
//
//  Created by Rafael Auriemo on 2/8/16.
//  Copyright © 2016 Matthew Howes Singleton. All rights reserved.
//

import UIKit

class Creature: NSObject {
    
    let myRootRef = Firebase(url: FirebaseUrl)
    
    var image = UIImage()
    var commentsArray = NSMutableArray()
    
    
    func createNewCreature(image: UIImage) {
        self.image = image
        self.commentsArray = []
        let usersRef = myRootRef.childByAppendingPath("posts")
        let post = usersRef.childByAppendingPath(String(UID))
        let postImage = post.childByAppendingPath("image")
        postImage.setValue("")
    }
    
    
    
}

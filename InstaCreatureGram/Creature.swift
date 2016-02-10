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
    
    
    func createNewCreature(image: UIImage) {
//        self.image = image
        self.image = UIImage(named: "logo1.png")!
        let imageData:NSData = UIImagePNGRepresentation(self.image)!
        let imageString = imageData.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
        let allPosts = myRootRef.childByAppendingPath("posts")
        let posts = allPosts.childByAutoId()
        let postImage = posts.childByAppendingPath("image")
        let postTimeStamp = posts.childByAppendingPath("time")
        let postLikes = posts.childByAppendingPath("likes")
        let postUser = posts.childByAppendingPath("user")
        postUser.setValue(String(UID))
        postLikes.setValue(0)
        postImage.setValue(imageString)
        postTimeStamp.setValue(FirebaseServerValue.timestamp())
        print("created creature")
        createNewComments("-KA94y1MmrUhoQQfOsu9", comment: "test test test")
    }
    
    func createNewComments(postID: String, comment:String) {
        let allComments = myRootRef.childByAppendingPath("comments")
        let commentsForPost = allComments.childByAppendingPath(postID)
        let newComment = commentsForPost.childByAppendingPath("content")
        newComment.setValue(comment)
        likeCreature("-KA94y1MmrUhoQQfOsu9")
        print("created comment")
    }
    
    func likeCreature(postID: String) {
        let postLikes = myRootRef.childByAppendingPath("posts").childByAppendingPath(postID).childByAppendingPath("likes")
        
        var currentLikes = NSNumber()
//        postLikes.observeEventType(.Value, withBlock: { snapshot in
//            currentLikes = snapshot.value as! NSNumber
//            }, withCancelBlock: { error in
//                print(error.description)
//        })
        let urlString = String(format: "%@.json", postLikes.description)
        let url = NSURL(string: urlString)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) { (data, response, error) -> Void in
            do {
               currentLikes = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSNumber
                let newLikes = Int(currentLikes) + 1
                postLikes.setValue(newLikes)
                print("liked comment")
            }catch let error as NSError {
                print("error"+error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func getAllPostsForUser(userID: String) {
        let posts = myRootRef.childByAppendingPath("posts")
        posts.queryEqualToValue(userID).observeEventType(.ChildAdded, withBlock: { snapshot in
            print(snapshot)
        })
    }
    
}

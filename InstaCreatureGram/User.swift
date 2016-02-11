//
//  User.swift
//  InstaCreatureGram
//
//  Created by Rafael Auriemo on 2/8/16.
//  Copyright © 2016 Matthew Howes Singleton. All rights reserved.
//

import UIKit

class User: NSObject {
    
    let myRootRef = Firebase(url: FirebaseUrl)
    
    func createNewUser(email:String, password:String) {
        myRootRef.createUser(email, password: password,
            withValueCompletionBlock: { error, result in
                if error != nil {
                    // There was an error creating the account
                } else {
                    let uid = result["uid"] as? String
                    print("Successfully created user account with uid: \(uid)")
                    UID = uid! as String
                    self.createUserInDB(email)
                }
        })
    }
    
    func createUserInDB(email:String) {
        let user = myRootRef.childByAppendingPath("users").childByAppendingPath(UID)
        let emailPath = user.childByAppendingPath("email")
        emailPath.setValue(email)
        print("created user in DB")
    }
    
    func loginUser(username:String, password:String) {
        myRootRef.authUser(username, password: password) { (error, data) -> Void in
            if error != nil {
                // There was an error creating the account
            } else {
                //perform segue
                UID = String(data)
//                Creature().getAllPostsForUser(UID)
//                Creature().createNewCreature(UIImage())
            }
        }
    }

}

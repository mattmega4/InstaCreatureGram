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
    let userDefaults = NSUserDefaults()
    
    func createNewUser(email:String, password:String) {
        myRootRef.createUser(email, password: password,
            withValueCompletionBlock: { error, result in
                if error != nil {
                    // There was an error creating the account
                } else {
                    let uid = result["uid"] as? String
                    print("Successfully created user account with uid: \(uid)")
                    UID = uid! as String
                    self.userDefaults.setObject(UID, forKey: "uid")
                    self.userDefaults.setObject(email, forKey: "useremail")
                    print("set defaults")
                    EMAIL = email
                    self.createUserInDB(email)
                }
        })
    }
    
    func createUserInDB(email:String) {
        let user = myRootRef.childByAppendingPath("users").childByAppendingPath(UID)
        let imageData:NSData = UIImagePNGRepresentation(UIImage(named: "user_pic")!)!
        let imageString = imageData.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
        let newUser = ["email":email, "profile_pic":imageString]
        user.setValue(newUser)
        print("created user in Database")
    }
    
    func createFollowerRelationship(toFollow:String) {
        let userFollows = myRootRef.childByAppendingPath("followers").childByAppendingPath(UID).childByAppendingPath(toFollow)
        userFollows.setValue(true)
    }
    
    func loginUser(username:String, password:String) {
        myRootRef.authUser(username, password: password) { (error, data) -> Void in
            if error != nil {
                // There was an error creating the account
            } else {
                //perform segue
                UID = String(data)
                EMAIL = username
                self.userDefaults.setObject(String(data), forKey: "uid")
                self.userDefaults.setObject(username, forKey: "useremail")
                print("set defaults")
            }
        }
    }

}

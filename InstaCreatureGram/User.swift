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
    
    func createNewUser(username:String, password:String) {
        myRootRef.createUser(username, password: password,
            withValueCompletionBlock: { error, result in
                if error != nil {
                    // There was an error creating the account
                } else {
                    let uid = result["uid"] as? String
                    print("Successfully created user account with uid: \(uid)")
                    UID = uid! as String
                }
        })
    }
    
    func loginUser(username:String, password:String) {
        myRootRef.authUser(username, password: password) { (error, data) -> Void in
            if error != nil {
                // There was an error creating the account
            } else {
                //perform segue
                UID = String(data)
//                Creature().createNewCreature(UIImage())
            }
        }
    }

}

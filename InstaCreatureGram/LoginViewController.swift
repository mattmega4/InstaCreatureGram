//
//  LoginViewController.swift
//  InstaCreatureGram
//
//  Created by Rafael Auriemo on 2/7/16.
//  Copyright © 2016 Matthew Howes Singleton. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onNewUserButtonTapped(sender: UIButton) {
        if emailTextField.text != "" && passwordTextField.text != "" {
            User().createNewUser(emailTextField.text!, password: passwordTextField.text!)
            self.performSegueWithIdentifier("login", sender: sender)
        }
    }
    
    @IBAction func onLoginButtonTapped(sender: AnyObject) {
        User().loginUser(emailTextField.text!, password: passwordTextField.text!)
    }

}

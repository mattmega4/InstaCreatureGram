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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //todo ib action linking to create new user
    
    
    @IBAction func onNewUserButtonTapped(sender: UIButton) {
        if emailTextField.text != "" && passwordTextField.text != "" {
            User().createNewUser(emailTextField.text!, password: passwordTextField.text!)
            self.performSegueWithIdentifier("login", sender: sender)
        }
    }
    
    @IBAction func onLoginButtonTapped(sender: AnyObject) {
        User().loginUser(emailTextField.text!, password: passwordTextField.text!)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

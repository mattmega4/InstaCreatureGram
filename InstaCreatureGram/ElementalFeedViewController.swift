//
//  ElementalFeedViewController.swift
//  InstaCreatureGram
//
//  Created by Matthew Howes Singleton on 2/4/16.
//  Copyright © 2016 Matthew Howes Singleton. All rights reserved.
//

import UIKit

class ElementalFeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
//    let sampleArray = ["hello", "you", "dirty", "pirate", "trampoleen", "cat", "wolrd"]
    
    
    let sampleArray: [UIImage] = [
        UIImage(named: "logo1.png")!,
        UIImage(named: "logo2.png")!,
        UIImage(named: "logo3.png")!,
        UIImage(named: "logo4.png")!,
        UIImage(named: "logo5.png")!,
        UIImage(named: "logo6.png")!,
        UIImage(named: "logo7.png")!,
        UIImage(named: "logo8.png")!,
        UIImage(named: "logo9.png")!,
        UIImage(named: "logo10.png")!
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        
       
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.navigationItem.hidesBackButton = true
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      
        let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell")!
        
        
        
        cell.imageView!.image = self.sampleArray[indexPath.section]
        
        
        return cell
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sampleArray.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
         return 1
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let title = UIView()

        // not sure why this was done, masks the image
        // thats how instagram does it....its semi transparent
//        let string = self.sampleArray[section]
//        title. = UIImage
        
//        title.backgroundColor = UIColor.blackColor()
        title.alpha = 0.0
        
        return title
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let title = UIView()
//        not sure why this was done, masks the image
        //insagram has a footer i believe, but i think there is a code snippet that turns off the persistance, will search for it
//        title.backgroundColor = UIColor.grayColor()
        title.alpha = 0.0
        
        return title
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        tableView.estimatedRowHeight = 11.0
        tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.contentInset = UIEdgeInsetsMake(0, -15, 0, 0);
        
        return tableView.frame.width
    }
    
    
    
    
    func tableView(tableView: UITableView,
        heightForHeaderInSection section: Int) -> CGFloat{
            
     return 50.0
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50.0
    }
    


    @IBOutlet weak var tabOne: UITabBarItem!


}

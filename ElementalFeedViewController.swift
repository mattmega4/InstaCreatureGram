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
    
    let sampleArray = ["hello", "you", "wolrd", "wolrd", "wolrd", "wolrd", "wolrd"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      
        let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell")!
        
        
        
        cell.textLabel!.text = self.sampleArray[indexPath.row]
        print(sampleArray)
        
        return cell
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sampleArray.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
         return 1
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let title: UILabel = UILabel()
        title.text = "Oh herro"
        title.backgroundColor = UIColor.blueColor()
        
        return title
    }
    
   
    
    
    func tableView(tableView: UITableView,
        heightForHeaderInSection section: Int) -> CGFloat{
            
     return 70.0
    }

    @IBOutlet weak var tabOne: UITabBarItem!


}

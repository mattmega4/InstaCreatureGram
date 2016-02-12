//
//  PostTableViewCell.swift
//  InstaCreatureGram
//
//  Created by Rafael Auriemo on 2/10/16.
//  Copyright © 2016 Matthew Howes Singleton. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    var postID = String()
    var postCreature = Creature()
    
    @IBOutlet weak var postImageView: UIImageView!
    
    @IBOutlet weak var likeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tap = UITapGestureRecognizer(target: self, action: "onLikeButtonPressed")
        tap.numberOfTapsRequired = 2
        postImageView.addGestureRecognizer(tap)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    @IBAction func onLikeButtonPressed(sender: AnyObject) {
        Creature().likeCreature(self.postID)
        let updatedLikes = Int(likeLabel.text!)! + 1
        likeLabel.text = String(updatedLikes)
        postCreature.likes = updatedLikes
    }
}

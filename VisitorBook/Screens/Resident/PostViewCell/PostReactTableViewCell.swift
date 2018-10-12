//
//  PostReactTableViewCell.swift
//  VisitorBook
//
//  Created by Praveen Sharma on 09/10/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit

class PostReactTableViewCell: UITableViewCell {
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var flatLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data : BlogLikesUser){
        
        userImageView.set_sdWebImage(With: data.photo, placeHolderImage: "userIcon")
        userNameLabel.text = data.name
        flatLabel.text = data.flats
        messageLabel.text = ""
    }
    
    func setData(data : BlogCommentDetail){
        
        userImageView.set_sdWebImage(With: data.photo, placeHolderImage: "userIcon")
        userNameLabel.text = data.name
        flatLabel.text = data.flats
        messageLabel.text = data.comment
    }
    
}

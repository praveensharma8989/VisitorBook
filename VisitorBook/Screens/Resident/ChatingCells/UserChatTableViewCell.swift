//
//  UserChatTableViewCell.swift
//  VisitorBook
//
//  Created by Praveen Sharma on 06/10/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit

class UserChatTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var msgLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(data : ComplainReply){
        
        nameLabel.text = data.replyBy
        msgLabel.text = data.replyMsg
        dateLabel.text = data.replyDate
        
    }
    
    func setData(data : RWAReply){
        
        nameLabel.text = data.replyFrom
        msgLabel.text = data.message
        dateLabel.text = data.replyDate
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

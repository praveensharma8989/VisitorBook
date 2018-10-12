//
//  AdminChatTableViewCell.swift
//  VisitorBook
//
//  Created by Praveen Sharma on 06/10/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit

class AdminChatTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var msgLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(data : ComplainReply){
        
        nameLabel.text = data.replyBy
        msgLabel.text = data.replyMsg
        dataLabel.text = data.replyDate
        
    }

    func setData(data : RWAReply){
        
        nameLabel.text = data.replyFrom
        msgLabel.text = data.message
        dataLabel.text = data.replyDate
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

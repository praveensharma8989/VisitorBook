//
//  NotificationTableViewCell.swift
//  VisitorBook
//
//  Created by Praveen on 25/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {
    @IBOutlet weak var notificationImage: UIImageView!
    @IBOutlet weak var subjectLbl: UILabel!
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var sendDateLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(data : NotificationData){
        
        subjectLbl.text = data.subject
        messageLbl.text = data.message
        sendDateLbl.text = data.sendDate
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

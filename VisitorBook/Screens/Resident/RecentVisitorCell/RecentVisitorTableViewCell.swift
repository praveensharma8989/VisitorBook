//
//  RecentVisitorTableViewCell.swift
//  VisitorBook
//
//  Created by Praveen Sharma on 20/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit

class RecentVisitorTableViewCell: UITableViewCell {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userPhone: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var inTime: UILabel!
    @IBOutlet weak var outTime: UILabel!
    @IBOutlet weak var staff: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data : VisitorData){
        
        userImage.set_sdWebImage(With: data.photo, placeHolderImage: "userIcon")
        userName.text = data.name
        userPhone.text = data.mobile
        userEmail.text = data.email
        inTime.text = data.visitDate
        outTime.text = data.outDate
        staff.text = data.visitorType
        staff.isHidden = data.visitorType == "" ? true : false
        outTime.isHidden  = data.outDate == "" ? true : false
    }
    
}

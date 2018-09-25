//
//  ComplaintInfoTableViewCell.swift
//  VisitorBook
//
//  Created by Praveen on 25/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit

class ComplaintInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var userIdLbl: UILabel!
    @IBOutlet weak var complaintTypeLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var mesageLbl: UILabel!
    @IBOutlet weak var feedbackLbl: UILabel!
    @IBOutlet weak var priorityLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(data : ComplainData){
        
        userIdLbl.text = data.cmplid
        complaintTypeLbl.text = data.subject
        statusLbl.text = data.status
        mesageLbl.text = data.message
        feedbackLbl.text = data.feedback
        priorityLbl.text = "Priority: " + data.priority!
        dateLbl.text = data.sendDate
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

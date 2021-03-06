//
//  EventsTableViewCell.swift
//  VisitorBook
//
//  Created by Praveen on 26/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit

class EventsTableViewCell: UITableViewCell {

    @IBOutlet weak var eventHeadingLbl: UILabel!
    @IBOutlet weak var eventMessgeLbl: UILabel!
    @IBOutlet weak var eventTimeLbl: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var attechImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data : EventDatum){
        
        eventHeadingLbl.text = data.title
        eventMessgeLbl.text = data.discription
        eventTimeLbl.text = data.eventDate
        if data.imageNums == "0"{
            countLabel.isHidden = true
            attechImage.isHidden = true
        }else{
            countLabel.isHidden = false
            attechImage.isHidden = false
            countLabel.text = data.imageNums
        }
        
    }
    
}

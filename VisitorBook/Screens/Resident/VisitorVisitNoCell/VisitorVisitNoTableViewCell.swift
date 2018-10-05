//
//  VisitorVisitNoTableViewCell.swift
//  VisitorBook
//
//  Created by Praveen Sharma on 04/10/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit

class VisitorVisitNoTableViewCell: UITableViewCell {
    @IBOutlet weak var inDateTimeLabel: UILabel!
    @IBOutlet weak var outDateTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data : ExpectedVisitorVisit){
        
        inDateTimeLabel.text = data.visitDate
        outDateTimeLabel.text = data.outDate
        
    }
    
    
}

//
//  FAQTableViewCell.swift
//  VisitorBook
//
//  Created by Praveen Sharma on 04/10/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit

class FAQTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descreptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data: FAQ){
        titleLabel.text = data.question
        descreptionLabel.text = data.answer
    }
    
}

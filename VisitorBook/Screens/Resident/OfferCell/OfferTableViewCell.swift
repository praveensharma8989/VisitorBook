//
//  OfferTableViewCell.swift
//  VisitorBook
//
//  Created by Praveen Sharma on 05/10/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit

class OfferTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(data: OfferDetail){
        
        titleLabel.text = data.offerName
        descLabel.text = data.discription
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

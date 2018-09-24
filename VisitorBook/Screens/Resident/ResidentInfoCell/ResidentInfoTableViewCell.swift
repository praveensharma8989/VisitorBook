//
//  ResidentInfoTableViewCell.swift
//  VisitorBook
//
//  Created by Praveen on 24/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit

class ResidentInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var UserImage: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var userTypeLbl: UILabel!
    @IBOutlet weak var userFlateLbl: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func imageAction_press(_ sender: Any) {
    }
    
}

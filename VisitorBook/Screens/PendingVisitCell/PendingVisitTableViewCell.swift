//
//  PendingVisitTableViewCell.swift
//  VisitorBook
//
//  Created by Praveen on 10/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit

class PendingVisitTableViewCell: UITableViewCell {
    @IBOutlet weak var UserImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userPhone: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var bottomButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func TopButtonClick(_ sender: Any) {
    }
    @IBAction func bottomButtonClick(_ sender: Any) {
    }
    
}

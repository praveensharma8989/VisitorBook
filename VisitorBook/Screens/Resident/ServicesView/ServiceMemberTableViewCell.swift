//
//  ServiceMemberTableViewCell.swift
//  VisitorBook
//
//  Created by Praveen Sharma on 08/10/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit

class ServiceMemberTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mobileLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data : StaffDatum){
        
        nameLabel.text = data.name
        mobileLabel.text = data.mobile
        emailLabel.text = data.email
        
    }
    
    @IBAction func mobileCallButton_press(_ sender: Any) {
        
        if let phoneCallURL = URL(string: "tel://\((mobileLabel.text)!)") {
            
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
        
    }
    
}

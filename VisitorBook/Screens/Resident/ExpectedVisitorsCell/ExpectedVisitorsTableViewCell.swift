//
//  ExpectedVisitorsTableViewCell.swift
//  VisitorBook
//
//  Created by Praveen Sharma on 03/10/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit

typealias ViewVisitorvisitPress = () -> (Void)

class ExpectedVisitorsTableViewCell: UITableViewCell {
    @IBOutlet weak var qrImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mobileLabel: UILabel!
    @IBOutlet weak var validDateLabel: UILabel!
    @IBOutlet weak var noOfVisitLabel: UILabel!
    
    var viewVisitorvisitPress : ViewVisitorvisitPress? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(data : ExpectedVisitor){
        
        qrImage.set_sdWebImage(With: data.qrCode, placeHolderImage: "userIcon")
        nameLabel.text = data.name
        mobileLabel.text = data.mobile
        validDateLabel.text = "Valid upto : " + data.validTo
        noOfVisitLabel.text = "No. of visit " + data.noOfVisit
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func viewNow_Press(_ sender: Any) {
        if viewVisitorvisitPress != nil {
            viewVisitorvisitPress!()
        }
    }
    
}

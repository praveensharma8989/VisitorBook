//
//  DailySOSTableViewCell.swift
//  VisitorBook
//
//  Created by Praveen on 13/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit

typealias DailySOSCall = () -> (Void)
typealias DailySOSImage = () -> (Void)

class DailySOSTableViewCell: UITableViewCell {

    @IBOutlet weak var sosImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mobileLabel: UILabel!
    @IBOutlet weak var towerFloorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var dailySOSCall : DailySOSCall? = nil
    var dailySOSImage : DailySOSImage? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data : SosData){
        
        sosImageView.set_sdWebImage(With: data.photo!, placeHolderImage: "CameraImage")
        nameLabel.text = data.name
        mobileLabel.text = data.mobile
        towerFloorLabel.text = data.flat
        dateLabel.text = data.sendTime
        
    }
    
    @IBAction func imageViewButton_press(_ sender: Any) {
        
        if dailySOSImage != nil{
            dailySOSImage!()
        }
        
    }
    
    @IBAction func callButton_press(_ sender: Any) {
        if dailySOSCall != nil{
            dailySOSCall!()
        }
    }
}

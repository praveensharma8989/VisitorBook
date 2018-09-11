//
//  VehicleDetailView.swift
//  VisitorBook
//
//  Created by Praveen on 11/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit

typealias VehicleCancel =  () -> (Void)
typealias CallButton =  () -> (Void)

class VehicleDetailView: UIView {

    @IBOutlet var contentView: UIView!
    var vehicleCancel : VehicleCancel? = nil
    var callButton : CallButton? = nil
    var vehicleData : Complain?
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var towerLabel: UILabel!
    @IBOutlet weak var floorLabel: UILabel!
    @IBOutlet weak var flatLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var purposeLabel: UILabel!
    @IBOutlet weak var mobileLabel: UILabel!
    
    
    @IBAction func mobileButton_press(_ sender: Any) {
        
        if callButton != nil{
            callButton!()
        }
    }
    @IBAction func cencelButton_press(_ sender: Any) {
        if vehicleCancel != nil{
            vehicleCancel!()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commanInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commanInit()
    }
    
    func reloadData() {
    
        if vehicleData != nil{
            userImage.set_sdWebImage(With: (vehicleData?.photo)!, placeHolderImage: "userIcon")
            userName.text = vehicleData?.name
            towerLabel.text = vehicleData?.tower
            floorLabel.text = vehicleData?.floor
            flatLabel.text = vehicleData?.flats
            dateLabel.text = vehicleData?.visitDate
            purposeLabel.text = vehicleData?.meetPurpose
            mobileLabel.text = vehicleData?.mobile
        }
    
    }
    
    private func commanInit(){
        Bundle.main.loadNibNamed("VehicleDetailView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        if vehicleData != nil{
            userImage.set_sdWebImage(With: (vehicleData?.photo)!, placeHolderImage: "userIcon")
            userName.text = vehicleData?.name
            towerLabel.text = vehicleData?.tower
            floorLabel.text = vehicleData?.floor
            flatLabel.text = vehicleData?.flats
            dateLabel.text = vehicleData?.visitDate
            purposeLabel.text = vehicleData?.meetPurpose
            mobileLabel.text = vehicleData?.mobile
        }
        
        
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

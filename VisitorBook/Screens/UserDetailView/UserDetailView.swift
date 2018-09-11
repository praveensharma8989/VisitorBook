//
//  UserDetailView.swift
//  VisitorBook
//
//  Created by Praveen on 11/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit

typealias UserDetailCancel =  () -> (Void)

class UserDetailView: UIView {

    var userData : PendingVisit?
    var userDetailCancel : UserDetailCancel? = nil
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var mobileLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var meetPurposeLabel: UILabel!
    @IBOutlet weak var vehicleLabel: UILabel!
    @IBOutlet weak var flatLabel: UILabel!
    @IBOutlet weak var inTimeLabel: UILabel!
    @IBOutlet weak var outTimeLabel: UILabel!
    @IBAction func cencelButton_press(_ sender: Any) {
        
        if userDetailCancel != nil{
            userDetailCancel!()
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
        if userData != nil{
            userImage.set_sdWebImage(With: (userData?.photo)!, placeHolderImage: "userIcon")
            userNameLabel.text = userData?.name
            emailLabel.text = userData?.email
            mobileLabel.text = userData?.mobile
            companyLabel.text = userData?.company
            addressLabel.text = userData?.address
            meetPurposeLabel.text = userData?.meetPurpose
            vehicleLabel.text = userData?.vehicle
            flatLabel.text = userData?.flats
            inTimeLabel.text = userData?.visitDate
            outTimeLabel.text = userData?.outDate
        }
        self.setNeedsDisplay()
    }
    
    private func commanInit(){
        Bundle.main.loadNibNamed("UserDetailView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        if userData != nil{
            userImage.set_sdWebImage(With: (userData?.photo)!, placeHolderImage: "userIcon")
            userNameLabel.text = userData?.name
            emailLabel.text = userData?.email
            mobileLabel.text = userData?.mobile
            companyLabel.text = userData?.company
            addressLabel.text = userData?.address
            meetPurposeLabel.text = userData?.meetPurpose
            vehicleLabel.text = userData?.vehicle
            flatLabel.text = userData?.flats
            inTimeLabel.text = userData?.visitDate
            outTimeLabel.text = userData?.outDate
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

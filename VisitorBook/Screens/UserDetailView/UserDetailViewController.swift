//
//  UserDetailViewController.swift
//  VisitorBook
//
//  Created by Praveen on 26/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit
import MIBlurPopup

class UserDetailViewController: UIViewController,  MIBlurPopupDelegate {

    var userData : PendingVisit?
    var visitorData : VisitorData?
    var userDetailCancel : UserDetailCancel? = nil
    @IBOutlet var contentView: UIView!
    
    
    var popupView: UIView {
        return contentView ?? UIView()
    }
    
    var blurEffectStyle: UIBlurEffectStyle{
        return .dark
    }
    
    var initialScaleAmmount: CGFloat = 0.0
    
    var animationDuration: TimeInterval = 0.5
    
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Bundle.main.loadNibNamed("UserDetailView", owner: self, options: nil)
        self.view.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        modalPresentationCapturesStatusBarAppearance = true
        reloadData()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func cencelButton_press(_ sender: Any) {
        
        dismiss(animated: true)
        
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
        }else if visitorData != nil{
            userImage.set_sdWebImage(With: (visitorData?.photo)!, placeHolderImage: "userIcon")
            userNameLabel.text = visitorData?.name
            emailLabel.text = visitorData?.email
            mobileLabel.text = visitorData?.mobile
            companyLabel.text = visitorData?.company
            addressLabel.text = visitorData?.address
            meetPurposeLabel.text = visitorData?.meetPurpose
            vehicleLabel.text = visitorData?.vehicle
            flatLabel.isHidden = true
            //            flatLabel.text = visitorData?.flats
            inTimeLabel.text = visitorData?.visitDate
            outTimeLabel.text = visitorData?.outDate
        }
        
//        self.setNeedsDisplay()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  NotificationPopUpViewController.swift
//  VisitorBook
//
//  Created by Praveen Sharma on 26/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit
import MIBlurPopup

class NotificationPopUpViewController: UIViewController, MIBlurPopupDelegate {
    
    @IBOutlet var containerView: UIView!
    
    var popupView: UIView {
        return containerView ?? UIView()
    }
    
    var blurEffectStyle: UIBlurEffectStyle{
        return .dark
    }
    
    var initialScaleAmmount: CGFloat = 0.0
    
    var animationDuration: TimeInterval = 0.5
    
    var flatUser : FlatUser?
    
    @IBOutlet weak var userNameLabelHeader: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var mobileLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var vehicleLabel: UILabel!
    @IBOutlet weak var stickerNo: UILabel!
    @IBOutlet weak var tower: UILabel!
    @IBOutlet weak var floor: UILabel!
    @IBOutlet weak var flatLabel: UILabel!
    @IBAction func cencelButton_press(_ sender: Any) {
        
        dismiss(animated: true) {
            
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Bundle.main.loadNibNamed("NotificationPopUpViewController", owner: self, options: nil)
        self.view.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        modalPresentationCapturesStatusBarAppearance = true
        
        setData()
        // Do any additional setup after loading the view.
    }

    func setData(){
        
        userNameLabelHeader.text = flatUser?.name
        userImage.set_sdWebImage(With: (flatUser?.photo)!, placeHolderImage: "userIcon")
        userNameLabel.text = flatUser?.name
        emailLabel.text = flatUser?.email
        mobileLabel.text = flatUser?.mobile
        addressLabel.text = flatUser?.address
        vehicleLabel.text = flatUser?.vehicleNo
        stickerNo.text = flatUser?.stickerNo
        tower.text = flatUser?.tower
        floor.text = flatUser?.floor
        flatLabel.text = flatUser?.flat
        
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

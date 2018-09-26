//
//  VehicleDetailViewController.swift
//  VisitorBook
//
//  Created by Praveen on 26/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit

class VehicleDetailViewController: UIViewController {

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
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Bundle.main.loadNibNamed("VehicleDetailView", owner: self, options: nil)
        self.view.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        modalPresentationCapturesStatusBarAppearance = true
        reloadData()
        // Do any additional setup after loading the view.
    }
    
    
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

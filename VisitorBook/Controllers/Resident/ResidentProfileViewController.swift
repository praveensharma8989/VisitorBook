//
//  ResidentProfileViewController.swift
//  VisitorBook
//
//  Created by Praveen on 24/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit
import CircleProgressView

class ResidentProfileViewController: ResidentAllPageViewController {

    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var flatLbl: UILabel!
    
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var genderDOBLbl: UILabel!
    @IBOutlet weak var vehicleLbl: UILabel!
    @IBOutlet weak var stickerLbl: UILabel!
    @IBOutlet weak var progressView: CircleProgressView!
    
    @IBOutlet weak var percentageLbl: UILabel!
    
    var residentFlatProfileData : FlateProfileData?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Initilize()
        
        // Do any additional setup after loading the view.
    }
    
    func Initilize(){
        
        residentFlatProfileData = CommanFunction.instance.getResidentFlatProfile()
        
        if residentFlatProfileData == nil{
            CallFlateProfile()
        }else{
            setData()
        }
        
    }
    
    func setData(){
        let tower = residentFlatProfileData?.tower ?? ""
        let floor = residentFlatProfileData?.floor ?? ""
        let flate = residentFlatProfileData?.flat ?? ""
        
        userImage.set_sdWebImage(With: (residentFlatProfileData?.photo)!, placeHolderImage: "userIcon")
        userNameLbl.text = (residentFlatProfileData?.name)!
        flatLbl.text = tower + ":" + floor + "," + flate
        addressLbl.text = residentFlatProfileData?.address ?? ""
        genderDOBLbl.text = (residentFlatProfileData?.gender ?? "") + "   " + (residentFlatProfileData?.age ?? "")
        vehicleLbl.text = "Vehicle No. " + (residentFlatProfileData?.vehicleNo ?? "")
        stickerLbl.text = "Sticker No. " + (residentFlatProfileData?.stickerNo ?? "")
        
    }
    
    func CallFlateProfile(){
        showLoader()
        
        let param : [String : Any] = [
            "id" : (residentData?.id)!
        ]
        
        PSServiceManager.CallFlatProfile(param: param) { (response, status, error) -> (Void) in
            self.dismissLoader()
            if status{
                let jsonData = try? JSONSerialization.data(withJSONObject: response!)
                let jsonDecoder = JSONDecoder()
                self.residentFlatProfileData = try? jsonDecoder.decode(FlateProfileData.self, from: jsonData!)
                
            }else{
                self.showAlertMessage(titleStr: "Error", messageStr: error!)
            }
        }
        
    }
    
    @IBAction func SOSSettingButton_press(_ sender: Any) {
    }
    
    @IBAction func editButton_press(_ sender: Any) {
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

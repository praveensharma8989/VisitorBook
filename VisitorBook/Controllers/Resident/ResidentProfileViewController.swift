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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
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
        
        progressView.progress = Double((residentFlatProfileData?.percentage)!) / 100
        percentageLbl.text = String((residentFlatProfileData?.percentage)!) + "%"
        
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
                CommanFunction.instance.saveResidentFlatProfile(data: response!)
                
                self.setData()
            }else{
                self.showAlertMessage(titleStr: "Error", messageStr: error!)
            }
        }
        
    }
    
    @IBAction func SOSSettingButton_press(_ sender: Any) {
    
        let SOSVC = self.storyboard?.instantiateViewController(withIdentifier: "SOSEditViewViewController") as! SOSEditViewViewController
        Push(controller: SOSVC)
    
    }
    
    @IBAction func editButton_press(_ sender: Any) {
        
        let EditProfile = self.storyboard?.instantiateViewController(withIdentifier: "EditProfileResidentViewController") as! EditProfileResidentViewController
        EditProfile.residentFlatProfileData = residentFlatProfileData
        Push(controller: EditProfile)
        
    }
    @IBAction func BackButton_press(_ sender: Any) {
        PopBack()
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

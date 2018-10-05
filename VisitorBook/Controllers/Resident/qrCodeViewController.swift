//
//  qrCodeViewController.swift
//  VisitorBook
//
//  Created by Praveen on 27/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit

class qrCodeViewController: ResidentAllPageViewController {

    @IBOutlet weak var userQRImage: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var flatLbl: UILabel!
    
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var genderDOBLbl: UILabel!
    
    
    
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
        
        userQRImage.set_sdWebImage(With: (residentFlatProfileData?.qrCode)!, placeHolderImage: "userIcon")
        userNameLbl.text = (residentFlatProfileData?.name)!
        
        let tower = residentFlatProfileData?.tower ?? ""
        let floor = residentFlatProfileData?.floor ?? ""
        let flate = residentFlatProfileData?.flat ?? ""
        
        userImage.set_sdWebImage(With: (residentFlatProfileData?.photo)!, placeHolderImage: "userIcon")
        flatLbl.text = tower + ":" + floor + "," + flate
        addressLbl.text = residentFlatProfileData?.address ?? ""
        genderDOBLbl.text = (residentFlatProfileData?.gender ?? "") + "   " + (residentFlatProfileData?.age ?? "")
        
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

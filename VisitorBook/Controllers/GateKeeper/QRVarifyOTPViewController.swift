//
//  QRVarifyOTPViewController.swift
//  VisitorBook
//
//  Created by Praveen Sharma on 05/10/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit
import MIBlurPopup

typealias VarifyOTPBACK = (Bool) -> (Void)
class QRVarifyOTPViewController: GatekeeperAllPageViewController {

    @IBOutlet weak var OTPText: UITextField!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    var qREntryData : QREntryData? = nil
    var isEntered : Bool = false
    var varifyOTPBACK : VarifyOTPBACK? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initilize()
        // Do any additional setup after loading the view.
    }
    
    func initilize(){
        
        setBackBarButton(buttonType: .Defauld)
        phoneNumberLabel.text = "+91 " + (qREntryData?.mobile)!
        
    }
    
    
    @IBAction func submitButton_press(_ sender: Any) {
        self.view.endEditing(true)
        if qREntryData?.otp == OTPText.text{
            
            CallStaffVarify()
            
        }else{
            self.showAlertMessage(titleStr: "Error", messageStr: "OTP Dose not match please try again!")
        }
        
    }
    
    func CallStaffVarify(){
        
        showLoader()
        
        let param : [String : Any]  = [
            "id": (qREntryData?.id)!,
            "empid" : (gateKeeperData?.id)!,
            "OTP" : (qREntryData?.otp)!,
            "logintype" : (qREntryData?.logintype)!
        ]
        
        PSServiceManager.CallStaffLogin(param: param) { (response, status, error) -> (Void) in
            
            self.dismissLoader()
            
            if(status){
                
                let jsonData = try? JSONSerialization.data(withJSONObject: response!)
                let jsonDecoder = JSONDecoder()
                let qRLoginData = try? jsonDecoder.decode(QRLoginData.self, from: jsonData!)
                
                let popUp = QRVerifyPopupViewController.init(nibName: "QRVerifyPopupViewController", bundle: nil)
                popUp.qRLoginData = qRLoginData
                popUp.isEntered = self.isEntered
                popUp.visitorPopupClick = {() in
                    
                    AppDelegate.sharedInstance.isScannerApear = true
                    
                    if self.varifyOTPBACK != nil{
                        self.varifyOTPBACK!(true)
                    }
                    
                }
                MIBlurPopup.show(popUp, on: self)
                
            }else{
                if self.varifyOTPBACK != nil{
                    self.varifyOTPBACK!(false)
                }
                self.showAlertMessage(titleStr: "Error", messageStr: error!)
            }
            
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

//
//  ResidentOTPViewController.swift
//  VisitorBook
//
//  Created by Praveen Sharma on 18/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit
import SRCountdownTimer

class ResidentOTPViewController: AllPageViewController {

    var residentData : ResidentData?
    var mobileNumber : String?
    var responseData : [String : Any]!
    
    @IBOutlet weak var countDownView: SRCountdownTimer!
    @IBOutlet weak var resendButton: UIButton!
    @IBOutlet weak var timerView: UIView!
    
    @IBOutlet weak var OTPText: UITextField!
    
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initilize()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initilize(){
        
        setBackBarButton(buttonType: .Defauld)
        phoneNumberLabel.text = "+91 " + mobileNumber!
        startTimer()
        
        
    }
    
    func startTimer(){
        resendButton.isHidden = true
        timerView.isHidden = false
        countDownView.start(beginingValue: 30, interval: 1)
        DispatchQueue.main.asyncAfter(deadline: .now() + 29) {
            self.resendButton.isHidden = false
            self.timerView.isHidden = true
        }
        
    }
    
    @IBAction func submitButton_press(_ sender: Any) {
        self.view.endEditing(true)
        if residentData?.otp == OTPText.text{
            
            CommanFunction.instance.saveUserDataResident(data: responseData!)
            CommanFunction.instance.setUserType(user: .Resident)
            
            AppIntializer.shared.moveToResidentScreen()
            
        }else{
            self.showAlertMessage(titleStr: "Error", messageStr: "OTP Dose not match please try again!")
        }
        
    }
    @IBAction func reSendOTPButton_press(_ sender: Any) {
        self.view.endEditing(true)
        callVisitorOtp()
    }
    @IBAction func editNumber_press(_ sender: Any) {
        self.view.endEditing(true)
        PopBack()
        
    }
    
    func callVisitorOtp(){
        
        view.endEditing(true)
        showLoader()
        
        let param : [String : Any] = [
            "mobile": mobileNumber!,
            "usertype": "Flat",
            "token": ""
        ]
        
        PSServiceManager.userloginApi(param: param) { (response, status, error) -> (Void) in
            
            self.dismissLoader()
            
            if(status){
                
                self.responseData = response!
                let jsonData = try? JSONSerialization.data(withJSONObject: response!)
                let jsonDecoder = JSONDecoder()
                self.residentData = try? jsonDecoder.decode(ResidentData.self, from: jsonData!)
                self.startTimer()
                
            }else{
                self.showAlertMessage(titleStr: "Error", messageStr: error!)
            }
            
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

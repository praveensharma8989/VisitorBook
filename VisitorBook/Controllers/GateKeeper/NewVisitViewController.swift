//
//  NewVisitViewController.swift
//  VisitorBook
//
//  Created by Praveen on 06/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit

class NewVisitViewController: AllPageViewController {

    @IBOutlet weak var visitorPhoneNumer: DesignableUITextField!
    
    var gateKeeperData : VisitorUsers?
    var newVisitorData : NewVisitorData?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initilize()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        visitorPhoneNumer.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func initilize(){
        
        setNavigationBar(Navigationtype: .defaultColor)
        gateKeeperData = CommanFunction.instance.getUserDataGateKeeper()
    }
    
    
    func validateFields()->Int {
        
        if (PSValidator.validateMobile(Mobile: visitorPhoneNumer.text) != 0){
            return PSValidator.validateMobile(Mobile: visitorPhoneNumer.text)
        }
        
        return 0
    }
    
    
    func callVisitorOtp(){
        
        view.endEditing(true)
        showLoader()
        
        var param : [String : Any] = [
                "mobile": visitorPhoneNumer.text!,
                "empid": gateKeeperData?.id
            ]
        
        
        
        PSServiceManager.visitorOTP(param: param) { (response, status, error) -> (Void) in
            
            self.dismissLoader()
            
            if(status){
                
                let jsonData = try? JSONSerialization.data(withJSONObject: response!)
                let jsonDecoder = JSONDecoder()
                self.newVisitorData = try? jsonDecoder.decode(NewVisitorData.self, from: jsonData!)
                
                self.moveToOtpScreen()
                
            }else{
                self.showAlertMessage(titleStr: "Error", messageStr: error!)
            }
            
        }
        
    }
    
    func moveToOtpScreen(){
        
        let VerifyOtpVC = self.storyboard?.instantiateViewController(withIdentifier: "VerifyOTPViewController") as! VerifyOTPViewController
        VerifyOtpVC.newVisitorData = newVisitorData
        VerifyOtpVC.gateKeeperData = gateKeeperData
        Push(controller: VerifyOtpVC)
        
    }
    
    
    @IBAction func submit_press(_ sender: Any) {
        
        self.view.endEditing(true)
        
        let code = validateFields()
        
        if(code != 0){
            
            print(code)
            let str:String = PSValidator.message(forCode: code)
            self.showAlertMessage(titleStr: "Error", messageStr: str)
        }
        else{
            callVisitorOtp()
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

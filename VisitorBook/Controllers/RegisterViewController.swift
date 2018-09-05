//
//  RegisterViewController.swift
//  VisitorBook
//
//  Created by Praveen on 05/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit

class RegisterViewController: AllPageViewController {
    
    @IBOutlet weak var userNameText: DesignableUITextField!
    
    @IBOutlet weak var phoneText: DesignableUITextField!
    
    @IBOutlet weak var emailText: DesignableUITextField!
    
    @IBOutlet weak var addressText: DesignableUITextField!
    
    var isGateKeeper : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        initialize()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initialize(){
        
        setBackBarButton()
    }
    
    func validateFields()->Int {
        

        if (PSValidator.validateName(userNameText.text) != 0)
        {
            return PSValidator.validateName(userNameText.text)
        }
        if (PSValidator.validateMobile(Mobile: phoneText.text) != 0){
            return PSValidator.validateMobile(Mobile: phoneText.text)
        }
        if (PSValidator.validateEmail(Email: emailText.text) != 0)
        {
            return PSValidator.validateEmail(Email: emailText.text)
        }
        if (PSValidator.validateAddress(addressText.text) != 0)
        {
            return PSValidator.validateAddress(addressText.text)
        }
        
        return 0
    }
    
    @IBAction func submitButton_press(_ sender: Any) {
        
        self.view.endEditing(true)
        
        let code = validateFields()
        
        if(code != 0){

            print(code)
            let str:String = PSValidator.message(forCode: code)
            self.showAlertMessage(titleStr: "Error", messageStr: str)
        }
        else{
            
            callRegisterApi()
            
        }
        
    }
    
    @IBAction func signInButton_press(_ sender: Any) {
        
        PopBack()
        
    }
    
    func callRegisterApi(){
        
        view.endEditing(true)
        showLoader()
        
        var param : [String : Any]
        
        if isGateKeeper{
            param = [
                "name" : userNameText.text!,
                "mobile" : phoneText.text!,
                "email" : emailText.text!,
                "address" : addressText.text!
            
            ]
        }else{
            param = [
                "name" : userNameText.text!,
                "mobile" : phoneText.text!,
                "email" : emailText.text!,
                "address" : addressText.text!
                
            ]
        }
        
        PSServiceManager.signUp(param: param) { (response, status, error) -> (Void) in
            
            self.dismissLoader()
            
            if(status){
                
                if (response!["code"] as! Int) == 0 {
                    self.showAlertMessage(titleStr: "Error", messageStr: response!["msg"] as! String)
                }else{
                    let jsonData = try? JSONSerialization.data(withJSONObject: response!)
                    let jsonDecoder = JSONDecoder()
//                    self.userData = try? jsonDecoder.decode(VisitorUsers.self, from: jsonData!)
                }
                
            }else{
                
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

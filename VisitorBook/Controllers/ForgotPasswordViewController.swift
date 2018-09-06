//
//  ForgotPasswordViewController.swift
//  VisitorBook
//
//  Created by Praveen on 05/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: AllPageViewController {

    @IBOutlet weak var emailText: DesignableUITextField!
    
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
        
        if (PSValidator.validateEmail(Email: emailText.text) != 0)
        {
            return PSValidator.validateEmail(Email: emailText.text)
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
            callForgotPasswordApi()
        }
        
    }
    
    @IBAction func signInButton_press(_ sender: Any) {
        
        PopBack()
        
    }
    
    func callForgotPasswordApi(){
        
        view.endEditing(true)
        showLoader()
        
        var param : [String : Any]
        
        if isGateKeeper{
            param = [
                "email" : emailText.text!
            ]
        }else{
            param = [
                "email" : emailText.text!
            ]
        }
        
        PSServiceManager.forgotPassword(param: param) { (response, status, error) -> (Void) in
            
            self.dismissLoader()
            
            if(status){
                
                let jsonData = try? JSONSerialization.data(withJSONObject: response!)
                let jsonDecoder = JSONDecoder()
                //                self.userData = try? jsonDecoder.decode(VisitorUsers.self, from: jsonData!)
                
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

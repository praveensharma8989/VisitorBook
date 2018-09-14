//
//  PasswordChangeViewController.swift
//  VisitorBook
//
//  Created by Praveen on 13/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit

class PasswordChangeViewController: AllPageViewController {

    @IBOutlet weak var newPasswordText: DesignableUITextField!
    @IBOutlet weak var oldPasswordText: DesignableUITextField!
    
    
    var oldPassword : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initilize()
        // Do any additional setup after loading the view.
    }

    func initilize(){
        
        setBackBarButton(buttonType: .Defauld)
        oldPassword = CommanFunction.instance.getUserDataGateKeeperPassword()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitButton_press(_ sender: Any) {
        let code = validate()
        
        if code != 0{
            let str:String = PSValidator.message(forCode: code)
            self.showAlertMessage(titleStr: "Error", messageStr: str)
        }else{
            callChangePassword()
        }
    }
    
    func validate()-> Int{
        
        if (PSValidator.validateOldPassword(oldPasswordText.text) != 0)
        {
            return PSValidator.validateOldPassword(oldPasswordText.text)
        }
        if (PSValidator.validateNewPassword(newPasswordText.text) != 0){
            return PSValidator.validateNewPassword(newPasswordText.text)
        }
        
        if oldPassword != oldPasswordText.text{
            return 203
        }
        
        return 0
    }
    
    func callChangePassword(){
        
        showLoader()
        
        let param : [String : Any] = ["id" : (gateKeeperData?.id)!,
                                      "pwd" : (newPasswordText.text)!
        ]
        
        PSServiceManager.CallChangePassword(param: param) { (response, status, error) -> (Void) in
            self.dismissLoader()
            if(status){
                CommanFunction.instance.saveUserDataGateKeeperPassword(data: (self.newPasswordText.text)!)
                self.showAlertMessage(titleStr: "Success", messageStr: response!["msg"] as! String)
                self.BackButtonClicked()
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

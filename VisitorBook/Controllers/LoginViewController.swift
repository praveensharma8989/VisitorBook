//
//  LoginViewController.swift
//  VisitorBook
//
//  Created by Praveen Sharma on 04/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit

class LoginViewController: AllPageViewController, UITextFieldDelegate {

    
    @IBOutlet weak var gateKeeperButton: UIButton!
    @IBOutlet weak var residentButton: UIButton!
    
    
    @IBOutlet weak var gateKeeperView: UIView!
    @IBOutlet weak var residentView: UIView!
    
    @IBOutlet weak var passwordText: DesignableUITextField!
    @IBOutlet weak var emailText: DesignableUITextField!
    @IBOutlet weak var gateKeeperSignInButton: UIButton!
    
    @IBOutlet weak var phoneText: DesignableUITextField!
    @IBOutlet weak var residentSignInButton: UIButton!
    
    var userData : VisitorUsers?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        againCall()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initialize(){
        
        emailText.delegate = self
        passwordText.delegate = self
        phoneText.delegate = self
        changeButtonSelection(button: gateKeeperButton)
        
        setNavigationBar(Navigationtype: .defaultColor)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func handleTap(recognizer: UITapGestureRecognizer){
        self.view.endEditing(true)
    }
    
    func againCall(){
        
        viewHidden()
        
    }
    
    func viewHidden(){
        
        if gateKeeperButton.isSelected {
            gateKeeperView.isHidden = false
            residentView.isHidden = true
        }else{
            gateKeeperView.isHidden = true
            residentView.isHidden = false
        }
        
    }
    
    func changeButtonSelection(button : UIButton){
        
        self.view.endEditing(true)
        gateKeeperButton.isSelected = false
        gateKeeperButton.imageView?.image = #imageLiteral(resourceName: "radio_unselected")
        residentButton.isSelected = false
        residentButton.imageView?.image = #imageLiteral(resourceName: "radio_unselected")
        
        button.isSelected = true
        button.imageView?.image = #imageLiteral(resourceName: "radio_selected")
        
        viewHidden()
        
    }

    @IBAction func gateKeeperButton_press(_ sender: Any) {
        changeButtonSelection(button: gateKeeperButton)
    }
    
    @IBAction func residentButton_press(_ sender: Any) {
        changeButtonSelection(button: residentButton)
    }
    
    @IBAction func gateKeeperSignInButton_press(_ sender: Any) {
        self.view.endEditing(true)
        
        let code = validateFields()
        
        if(code != 0){
            
            print(code)
            let str:String = PSValidator.message(forCode: code)
            self.showAlertMessage(titleStr: "Error", messageStr: str)
        }
        else{
            gateKeeperLoginApi()
            
        }
        
    }
    
    @IBAction func registerHereButton_press(_ sender: Any) {
        self.view.endEditing(true)
        
        let registerVC = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        registerVC.isGateKeeper = gateKeeperButton.isSelected ? true : false
        Push(controller: registerVC)
        
    }
    @IBAction func forgetPasswordButton_press(_ sender: Any) {
        self.view.endEditing(true)
        
        let forgotPasswordVC = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as! ForgotPasswordViewController
        forgotPasswordVC.isGateKeeper = gateKeeperButton.isSelected ? true : false
        Push(controller: forgotPasswordVC)
        
    }
    
    @IBAction func residentSignInButton_press(_ sender: Any) {
        self.view.endEditing(true)
        
    }
    
    func validateFields()->Int {
        
        if(gateKeeperButton.isSelected){
        
            if (PSValidator.validateEmail(Email: emailText.text) != 0)
            {
                return PSValidator.validateEmail(Email: emailText.text)
            }
            if (PSValidator.validatePassword(passwordText.text) != 0)
            {
                return PSValidator.validatePassword(passwordText.text)
            }
        }else{
            if (PSValidator.validateMobile(Mobile: phoneText.text) != 0){
                return PSValidator.validateMobile(Mobile: phoneText.text)
            }
        }
        return 0
    }
    
    
    func gateKeeperLoginApi(){
        
        view.endEditing(true)
        showLoader()
        
        var param : [String : Any]
        
        if gateKeeperButton.isSelected{
            param = [
                "email": emailText.text!,
                "password": passwordText.text!,
                "usertype": "Visitor",
                "token": ""
            ]
        }else{
            param = [
                "phone": phoneText.text!,
                "usertype": "Flat",
                "token": ""
            ]
        }
        
        
        PSServiceManager.userloginApi(param: param) { (response, status, error) -> (Void) in
            
            self.dismissLoader()
            
            if(status){
                
                let jsonData = try? JSONSerialization.data(withJSONObject: response!)
                let jsonDecoder = JSONDecoder()
                self.userData = try? jsonDecoder.decode(VisitorUsers.self, from: jsonData!)
                
                CommanFunction.instance.saveUserDataGateKeeper(data : response!)
                CommanFunction.instance.setUserType(user: .GateKeeper)
                CommanFunction.instance.saveUserDataGateKeeperPassword(data: (self.passwordText.text)!)
                
                AppIntializer.shared.moveToGateKeeperScreen()
                
            }else{
                self.showAlertMessage(titleStr: "Error", messageStr: error!)
            }
            
        }
        
    }
    
    /**
     * Called when 'return' key pressed. return NO to ignore.
     */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    /**
     * Called when the user click on the view (outside the UITextField).
     */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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

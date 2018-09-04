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
        
    }
    
    @IBAction func registerHereButton_press(_ sender: Any) {
        self.view.endEditing(true)
        
    }
    @IBAction func forgetPasswordButton_press(_ sender: Any) {
        self.view.endEditing(true)
        
    }
    
    @IBAction func residentSignInButton_press(_ sender: Any) {
        self.view.endEditing(true)
        
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

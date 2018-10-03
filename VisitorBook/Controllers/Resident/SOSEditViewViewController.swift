//
//  SOSEditViewViewController.swift
//  VisitorBook
//
//  Created by Praveen on 25/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit

class SOSEditViewViewController: ResidentAllPageViewController {
    @IBOutlet weak var relativeName1Text: DesignableUITextField!
    @IBOutlet weak var relativePhone1Text: DesignableUITextField!
    @IBOutlet weak var relativeName2Text: DesignableUITextField!
    @IBOutlet weak var relativePhone2Text: DesignableUITextField!
    @IBOutlet weak var messageText: DesignableUITextField!
    
    var sosData : SOSData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initilize()
        // Do any additional setup after loading the view.
    }
    
    func initilize(){
        
        setBackBarButton(buttonType: .Defauld)
        CallSOSDetail()
        
    }
    
    @IBAction func submitButton_Press(_ sender: Any) {
        
        self.view.endEditing(true)
        
        let code = validate()
        
        if(code != 0){
            
            print(code)
            let str:String = PSValidator.message(forCode: code)
            self.showAlertMessage(titleStr: "Error", messageStr: str)
        }
        else{
            
            CallUpdateSOS()
            
        }
        
    }
    
    func validate() -> Int{
        
        if (PSValidator.validateSOSName1(relativeName1Text.text) != 0)
        {
            return PSValidator.validateSOSName1(relativeName1Text.text)
        }
        if (PSValidator.validateMobile(Mobile: relativePhone1Text.text) != 0){
            return PSValidator.validateMobile(Mobile: relativePhone1Text.text)
        }
        if (PSValidator.validateSOSName2(relativeName2Text.text) != 0)
        {
            return PSValidator.validateSOSName2(relativeName2Text.text)
        }
        if (PSValidator.validateMobile(Mobile: relativePhone2Text.text) != 0){
            return PSValidator.validateMobile(Mobile: relativePhone2Text.text)
        }
        
        return 0
        
    }
    
    func setData(){
        
        relativeName1Text.text = sosData?.name1
        relativeName2Text.text = sosData?.name2
        relativePhone1Text.text = sosData?.mobile1
        relativePhone2Text.text = sosData?.mobile2
        messageText.text = sosData?.message
        
    }
    
    func CallUpdateSOS(){
        
        showLoader()
        
        let param : [String : Any] = [
            "id" : (residentData?.id)!,
            "name1" : relativeName1Text.text!,
            "name2" : relativeName2Text.text!,
            "mobile1" : relativePhone1Text.text!,
            "mobile2" : relativePhone2Text.text!,
            "message" : messageText.text!
        ]
        
        PSServiceManager.CallUpdateSOSDetail(param: param) { (response, status, error) -> (Void) in
            self.dismissLoader()
            if status{
                
                self.showAlertMessage(titleStr: "Success", messageStr: response!["msg"] as! String)
                self.PopBack()
                
            }else{
                self.showAlertMessage(titleStr: "Error", messageStr: error!)
            }
        }
        
    }
    
    func CallSOSDetail(){
        showLoader()
        
        let param : [String : Any] = ["id" : (residentData?.id)!
        ]
        
        PSServiceManager.CallSOSDetailResident(param: param) { (response, status, error) -> (Void) in
            self.dismissLoader()
            if status{
                let jsonData = try? JSONSerialization.data(withJSONObject: response!)
                let jsonDecoder = JSONDecoder()
                
                self.sosData = try? jsonDecoder.decode(SOSData.self, from: jsonData!)
                self.setData()
            }else{
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

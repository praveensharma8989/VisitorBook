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
        
        CallSOSDetail()
        
    }
    
    @IBAction func submitButton_Press(_ sender: Any) {
        
        
    }
    
    func setData(){
        
        relativeName1Text.text = sosData?.name1
        relativeName2Text.text = sosData?.name2
        relativePhone1Text.text = sosData?.mobile1
        relativePhone2Text.text = sosData?.mobile2
        messageText.text = sosData?.message
        
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

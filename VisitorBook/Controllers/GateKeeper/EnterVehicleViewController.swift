//
//  EnterVehicleViewController.swift
//  VisitorBook
//
//  Created by Praveen on 11/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit

class EnterVehicleViewController: AllPageViewController {

    @IBOutlet weak var blackView: UIView!
    @IBOutlet weak var vehicleDetailView: VehicleDetailView!
    @IBOutlet weak var enterVehicleText: DesignableUITextField!
    
    var vehicleData : VehicleData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initilize()
        // Do any additional setup after loading the view.
    }

    func initilize(){
        
        blackView.isHidden = true
        vehicleDetailView.isHidden = true
        vehicleDetailView.vehicleCancel = {() in
            
            self.blackView.isHidden = true
            self.vehicleDetailView.isHidden = true
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setBarButtonItem(withButtonImage: #imageLiteral(resourceName: "backButton"), withPosition: .TabbarBack, needAdjustMent: true)
        self.tabBarController?.tabBar.isHidden = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.topItem?.leftBarButtonItem = nil
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func validation()->Int{
        
        if PSValidator.validateVehicleNumber(enterVehicleText.text) != 0{
            return PSValidator.validateVehicleNumber(enterVehicleText.text)
        }
        
        return 0
        
    }

    @IBAction func submitButton_press(_ sender: Any) {
        
        let code = validation()
        if code != 0{
            let str:String = PSValidator.message(forCode: code)
            self.showAlertMessage(titleStr: "Error", messageStr: str)
        }else{
            callVehicleUser()
        }
        
    }
    
    func callVehicleUser(){
        view.endEditing(true)
        showLoader()
        
        let param : [String : Any]  = [
                "data": enterVehicleText.text!
            ]
        
        
        
        PSServiceManager.CallSearchVisitor(param: param) { (response, status, error) -> (Void) in
            
            self.dismissLoader()
            
            if(status){
                
                let jsonData = try? JSONSerialization.data(withJSONObject: response!)
                let jsonDecoder = JSONDecoder()
                self.vehicleData = try? jsonDecoder.decode(VehicleData.self, from: jsonData!)
                self.vehicleDetailView.vehicleData = self.vehicleData?.complain[0]
                self.blackView.isHidden = false
                self.vehicleDetailView.isHidden = false
                self.vehicleDetailView.reloadData()
                
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

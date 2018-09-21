//
//  ResidentAllPageViewController.swift
//  VisitorBook
//
//  Created by Praveen on 20/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit

typealias GetDeshBoardBlock = (ResidentDashboardData?, Bool) -> (Void)

class ResidentAllPageViewController: AllPageViewController {

    var residentData : ResidentData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        residentData = CommanFunction.instance.getUserDataResident()
        // Do any additional setup after loading the view.
    }
    
    
    
    func callDashBoardData(GetDeshBoardBlock:@escaping GetDeshBoardBlock)->Void{
        
        showLoader()
        
        let param : [String : Any] = ["id" : (residentData?.id)!]
        
        PSServiceManager.CallDashboard(param: param) { (response, status, error) -> (Void) in
            self.dismissLoader()
            
            var residentDashboardData : ResidentDashboardData?
            
            if status {
                let jsonData = try? JSONSerialization.data(withJSONObject: response!)
                let jsonDecoder = JSONDecoder()
                residentDashboardData = try? jsonDecoder.decode(ResidentDashboardData.self, from: jsonData!)
                
            }else{
                self.showAlertMessage(titleStr: "Error", messageStr: error!)
            }
            GetDeshBoardBlock(residentDashboardData,status)
            
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

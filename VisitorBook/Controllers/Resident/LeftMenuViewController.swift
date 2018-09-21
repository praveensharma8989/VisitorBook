//
//  LeftMenuViewController.swift
//  VisitorBook
//
//  Created by Praveen on 19/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit


class LeftMenuViewController: ResidentAllPageViewController {
    
    @IBOutlet weak var moneyLbl: UILabel!
    @IBOutlet weak var payStatus: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var flateLbl: UILabel!
    
    var residentDashboardDataNew : ResidentDashboardData?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if residentDashboardDataNew == nil{
            
            self.residentDashboardDataNew = DashBoardViewController.sharedInstance.getDataResident()
                self.setData()
        }else{
            setData()
        }
        
        // Do any additional setup after loading the view.
    }

    func setData(){
        
        userImage.set_sdWebImage(With: (residentDashboardDataNew?.photo)!, placeHolderImage: "userIcon")
        userNameLbl.text = residentDashboardDataNew?.name
        flateLbl.text = residentDashboardDataNew?.userType
        moneyLbl.text = "Rs. " + (residentDashboardDataNew?.maintanance)!
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

//
//  LeftMenuViewController.swift
//  VisitorBook
//
//  Created by Praveen on 19/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit


class LeftMenuViewController: ResidentAllPageViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableHeaderView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var moneyLbl: UILabel!
    @IBOutlet weak var payStatus: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var flateLbl: UILabel!
    
    var residentDashboardDataNew : ResidentDashboardData?
    let titleArray : [String] = ["My Profile", "My QR Code", "Transaction History", "Rate Us", "FAQs", "Share", "About Us", "Logout"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerCell()
        tableView.tableHeaderView = tableHeaderView
        
        tableView.tableFooterView = UIView.init(frame: CGRect.zero)
        
        if residentDashboardDataNew == nil{
            
            self.residentDashboardDataNew = CommanFunction.instance.getUserDataResidentDashBoard()
                self.setData()
        }else{
            setData()
        }
        
        // Do any additional setup after loading the view.
    }
    
    func registerCell(){
        tableView.register(UINib(nibName: "SideMenuTableViewCell", bundle: nil), forCellReuseIdentifier: "SideMenuTableViewCell")
        
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: "SideMenuTableViewCell") as! SideMenuTableViewCell
        
        cell.titleLbl.text = titleArray[indexPath.row]
        cell.userImge.image = UIImage(named: titleArray[indexPath.row])
        
        return cell
        
        
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

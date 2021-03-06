//
//  LeftMenuViewController.swift
//  VisitorBook
//
//  Created by Praveen on 19/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit
import PopMenu
import FAPanels

class LeftMenuViewController: ResidentAllPageViewController, UITableViewDelegate, UITableViewDataSource, PopMenuViewControllerDelegate {
    
    @IBOutlet var tableHeaderView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var moneyLbl: UILabel!
    @IBOutlet weak var payStatus: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var flateLbl: UILabel!
    
    
//    var manager = PopMenuManager.default
    
    
    var residentDashboardDataNew : ResidentDashboardData?
    let titleArray : [String] = ["My Profile", "My QR Code", "Transaction History", "Rate Us", "FAQs", "Share", "About Us", "Logout"]
    
    fileprivate let examples = PopMenuExamples()
    
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
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    
    func registerCell(){
        tableView.register(UINib(nibName: "SideMenuTableViewCell", bundle: nil), forCellReuseIdentifier: "SideMenuTableViewCell")
        let headerNib = UINib.init(nibName: "SideMenuSectionHeaderView", bundle: Bundle.main)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "SideMenuSectionHeaderView")
        
    }

    func setData(){
        
        userImage.set_sdWebImage(With: (residentDashboardDataNew?.photo)!, placeHolderImage: "userIcon")
        userNameLbl.text = residentDashboardDataNew?.name
        flateLbl.text = (residentDashboardDataNew?.userType)! + " " + (residentDashboardDataNew?.flat)!
        moneyLbl.text = "Rs. " + (residentDashboardDataNew?.maintanance)!
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func showMenuManually(for barButtonItem: UIView) {
        // Create menu controller with actions
        let controller = PopMenuViewController(sourceView: barButtonItem, actions: [
            PopMenuDefaultAction(title: "Text"),
            PopMenuDefaultAction(title: "new"),
            PopMenuDefaultAction(title: "yey")
            ])
        
//        controller.addAction(PopMenuDefaultAction(title: "Text"))
        
        // Customize appearance
        controller.appearance.popMenuFont = UIFont(name: "AvenirNext-DemiBold", size: 16)!
//        controller.appearance.popMenuBackgroundStyle = .blurred(.extraLight)
        controller.appearance.popMenuColor.backgroundColor = .solid(fill: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
        // Configure options
        controller.shouldDismissOnSelection = true
        controller.delegate = self
        
        controller.didDismiss = { selected in
            print("Menu dismissed: \(selected ? "selected item" : "no selection")")
        }
        
        // Present menu controller
        present(controller, animated: true, completion: nil)
    }
    
    func popMenuDidSelectItem(_ popMenuViewController: PopMenuViewController, at index: Int) {
        print(index)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SideMenuSectionHeaderView") as! SideMenuSectionHeaderView
        
        headerView.headerSelected  = {() in
            
            self.showMenuManually(for: headerView)

        }
        
        return headerView
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: "SideMenuTableViewCell") as! SideMenuTableViewCell
        
        cell.titleLbl.text = titleArray[indexPath.row]
        cell.userImge.image = UIImage(named: titleArray[indexPath.row])
//        cell.backgroundColor = 
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            
            let navigation = self.panel?.center as! UINavigationController
            
            let myProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "ResidentProfileViewController") as! ResidentProfileViewController
            self.panel?.closeLeft()
            navigation.pushViewController(myProfileVC, animated: false)
//            Push(controller: myProfileVC)
            
        case 1:
            
            let navigation = self.panel?.center as! UINavigationController
            
            let myProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "qrCodeViewController") as! qrCodeViewController
            self.panel?.closeLeft()
            navigation.pushViewController(myProfileVC, animated: false)
            
        case 4:
            
            let navigation = self.panel?.center as! UINavigationController
            
            let FAQVC = self.storyboard?.instantiateViewController(withIdentifier: "FAQViewController") as! FAQViewController
            self.panel?.closeLeft()
            navigation.pushViewController(FAQVC, animated: false)
            
        case 6:
            let navigation = self.panel?.center as! UINavigationController
            
            let AboutUsVC = self.storyboard?.instantiateViewController(withIdentifier: "AboutUsViewController") as! AboutUsViewController
            self.panel?.closeLeft()
            navigation.pushViewController(AboutUsVC, animated: false)
            
        case 7:
            
            logoutflatUser()
            
        default:
            break
        }
    }
    
    
    func logoutflatUser(){
        
        showLoader()
        
        let param : [String : Any] = [
            "id" : (residentData?.id)!
        ]
        
        PSServiceManager.CallLogoutFlatUser(param: param) { (response, status, error) -> (Void) in
            self.dismissLoader()
            if(status){
                
                CommanFunction.instance.clearFlatUserData()
                self.showAlertMessage(titleStr: "Success", messageStr: response!["msg"] as! String)
                AppIntializer.shared.moveToLoginScreen()
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



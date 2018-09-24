//
//  LeftMenuViewController.swift
//  VisitorBook
//
//  Created by Praveen on 19/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit
import PopMenu

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
    
    func registerCell(){
        tableView.register(UINib(nibName: "SideMenuTableViewCell", bundle: nil), forCellReuseIdentifier: "SideMenuTableViewCell")
        let headerNib = UINib.init(nibName: "SideMenuSectionHeaderView", bundle: Bundle.main)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "SideMenuSectionHeaderView")
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}



//
//  PendingVisitViewController.swift
//  VisitorBook
//
//  Created by Praveen on 10/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit

enum PendingType : Int {
    case Pending = 0,
    All
}

class PendingVisitViewController: AllPageViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var noRecordFoundView: UIView!
    @IBOutlet weak var blackView: UIView!
    @IBOutlet weak var userView: UserDetailView!
    @IBOutlet weak var allButton: UIButton!
    @IBOutlet weak var pendingButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var backView : UIView!
    var pendingVisitData : PendingVisitData?
    var allPendingVisitData : PendingVisitData?
    
    var isAllData : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initilize()
        // Do any additional setup after loading the view.
    }

    
    func initilize(){
        
        registerCell()
        tableView.dataSource = self
        tableView.delegate = self
        pendingButton.isSelected = true
        allButton.isSelected = false
        isAllData = false
        blackView.isHidden = true
        userView.isHidden = true
        CallPendingVisit(type: .Pending)
        userView.userDetailCancel = {() in
            
            self.blackView.isHidden = true
            self.userView.isHidden = true
        }
    }
    
    func registerCell(){
        tableView.register(UINib(nibName: "PendingVisitTableViewCell", bundle: nil), forCellReuseIdentifier: "PendingVisitTableViewCell")
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
    
    @IBAction func pendingButton_press(_ sender: Any) {
        
        if !pendingButton.isSelected{
            isAllData = false
            pendingButton.isSelected = true
            allButton.isSelected = false
            pendingButton.backgroundColor = UIColor.red
            allButton.backgroundColor = UIColor.darkGray
            CallPendingVisit(type: .Pending)
        }
        
    }
    
    @IBAction func allButton_press(_ sender: Any) {
        
        if !allButton.isSelected{
            isAllData = true
            allButton.isSelected = true
            pendingButton.isSelected = false
            pendingButton.backgroundColor = UIColor.darkGray
            allButton.backgroundColor = UIColor.red
            CallPendingVisit(type: .All)
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if pendingButton.isSelected{
            return pendingVisitData != nil ? ((pendingVisitData?.pendingVisit.count))! : 0
        }else{
            return allPendingVisitData != nil ? (allPendingVisitData?.pendingVisit.count)! : 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PendingVisitTableViewCell") as! PendingVisitTableViewCell
        
        if isAllData{
            cell.setData(data: (allPendingVisitData?.pendingVisit[indexPath.row])!)
        }else{
            cell.setData(data: (pendingVisitData?.pendingVisit[indexPath.row])!)
        }
        
        cell.viewUserDetail = { () in
            self.blackView.isHidden = false
            self.userView.isHidden = false
            if self.isAllData{
                self.userView.userData = (self.allPendingVisitData?.pendingVisit[indexPath.row])!
            }else{
                self.userView.userData = (self.pendingVisitData?.pendingVisit[indexPath.row])!
            }
            self.userView.reloadData()
            
        }
        cell.topButtonClick = {() in
            
            var userId : String = ""
            
            if self.isAllData{
                userId = (self.allPendingVisitData?.pendingVisit[indexPath.row].id)!
            }else{
                userId = (self.pendingVisitData?.pendingVisit[indexPath.row].id)!
            }
            
            self.resendRequest(id: userId)
        }
        cell.bottomButtonClick = { () in
            
        }
        
        return cell
    }
    
    
    func CallPendingVisit(type : PendingType){
        
        showLoader()
        
        var param : [String : Any]
        
        if type == .Pending{
            param = [
                "id" : (gateKeeperData?.id)!,
                "type" : ""
            ]
        }else{
            param = [
                "id" : (gateKeeperData?.id)!,
                "type" : "All"
            ]
        }
        
        PSServiceManager.CallPendingVisit(param: param) { (response, status, error) -> (Void) in
            self.dismissLoader()
            
            if(status){
                self.noRecordFoundView.isHidden = true
                do{
                    let jsonData = try? JSONSerialization.data(withJSONObject: response!)
                    let jsonDecoder = JSONDecoder()
                    if self.isAllData{
                        self.allPendingVisitData = try jsonDecoder.decode(PendingVisitData.self, from: jsonData!)
                    }else{
                        self.pendingVisitData = try? jsonDecoder.decode(PendingVisitData.self, from: jsonData!)
                    }
                    self.tableView.reloadData()
                }catch{
                    print(error)
                }
                
                
                
            }else{
                self.noRecordFoundView.isHidden = false
                self.showAlertMessage(titleStr: "Error", messageStr: error!)
            }
        }
        
    }
    
    func resendRequest(id : String){
        
        showLoader()
        
        let param : [String : Any] = ["id" : id]
        
        PSServiceManager.CallResentVisitReq(param: param) { (response, status, error) -> (Void) in
            self.dismissLoader()
            if(status){
                self.showAlertMessage(titleStr: "Success", messageStr: response!["msg"] as! String)
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

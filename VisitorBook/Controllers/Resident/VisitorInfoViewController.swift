//
//  VisitorInfoViewController.swift
//  VisitorBook
//
//  Created by Praveen Sharma on 23/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit

class VisitorInfoViewController: ResidentAllPageViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var noRecordFoundView: UIView!
    @IBOutlet weak var ImageView: DailySOSImageView!
    @IBOutlet weak var blackView: UIView!
    @IBOutlet weak var tableVIew: UITableView!
    @IBOutlet weak var userDetailView: UserDetailView!
    
    var visitorType : VisitorActiontype?
    var limit : Int = 0
    var visitorResponseData : VisitorResponseData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initilize()
        // Do any additional setup after loading the view.
    }
    
    func initilize(){
        
        hideSubViews()
        registerCell()
        CallVisitorFlatVisitor()
        ImageView.dailySOSCancel = {() in
            self.hideSubViews()
        }
        userDetailView.userDetailCancel = {() in
            self.hideSubViews()
        }
    }
    
    func hideSubViews(){
        
        blackView.isHidden = true
        ImageView.isHidden = true
        userDetailView.isHidden = true
        
    }
    
    func registerCell(){

        tableVIew.register(UINib(nibName: "RecentVisitorTableViewCell", bundle: nil), forCellReuseIdentifier: "RecentVisitorTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return visitorResponseData != nil ? (visitorResponseData?.visitor.count)! : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecentVisitorTableViewCell") as! RecentVisitorTableViewCell
        cell.setData(data: (visitorResponseData?.visitor[indexPath.row])!)
        cell.visitorImageClick = {() in
            
            self.ImageView.visitorInfo = (self.visitorResponseData?.visitor[indexPath.row])!
            self.ImageView.reloadData()
            self.blackView.isHidden = false
            self.ImageView.isHidden = false
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        userDetailView.visitorData = (self.visitorResponseData?.visitor[indexPath.row])!
        userDetailView.reloadData()
        blackView.isHidden = false
        userDetailView.isHidden = false
        
    }
    
    
    func CallVisitorFlatVisitor(){
        
        showLoader()
        
        var types : String
        
        switch visitorType! {
        case .TodayVisitor:
            types = "Today"
            
        case .WeeklyVisitor:
            types = "Week"
        case .TotalVisitor:
            types = "Total"
        }
        
        let param : [String : Any] = [
            "id" : (residentData?.id)!,
            "types" : types,
            "limit" : limit
        ]
        
        PSServiceManager.CallFlat_Visitor(param: param) { (response, status, error) -> (Void) in
            self.dismissLoader()
            if(status){
                
                let jsonData = try? JSONSerialization.data(withJSONObject: response!)
                let jsonDecoder = JSONDecoder()
                self.visitorResponseData = try? jsonDecoder.decode(VisitorResponseData.self, from: jsonData!)
                self.noRecordFoundView.isHidden = true
                self.tableVIew.reloadData()
            }else{
                self.noRecordFoundView.isHidden = false
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
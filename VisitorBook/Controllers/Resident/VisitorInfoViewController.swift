//
//  VisitorInfoViewController.swift
//  VisitorBook
//
//  Created by Praveen Sharma on 23/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit
import MIBlurPopup

class VisitorInfoViewController: ResidentAllPageViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var noRecordFoundView: UIView!
    @IBOutlet weak var tableVIew: UITableView!
    
    
    var visitorType : VisitorActiontype?
    var limit : Int = 0
    var visitorResponseData : VisitorResponseData?
    var visitorDataArray : [VisitorData]? = nil
    var isApiCall : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initilize()
        // Do any additional setup after loading the view.
    }
    
    func initilize(){
        
        setBackBarButton(buttonType: .Defauld)
        registerCell()
        CallVisitorFlatVisitor()
    
    }
    
    func registerCell(){

        tableVIew.register(UINib(nibName: "RecentVisitorTableViewCell", bundle: nil), forCellReuseIdentifier: "RecentVisitorTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return visitorDataArray != nil ? (visitorDataArray!.count) : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecentVisitorTableViewCell") as! RecentVisitorTableViewCell
        cell.setData(data: (visitorDataArray![indexPath.row]))
        cell.visitorImageClick = {() in
            
            let popUp = ImgeViewController.init(nibName: "DailySOSImageView", bundle: nil)
            popUp.visitorInfo = (self.visitorDataArray![indexPath.row])
            MIBlurPopup.show(popUp, on: self)
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let popUp = UserDetailViewController.init(nibName: "UserDetailView", bundle: nil)
        popUp.visitorData = (self.visitorDataArray![indexPath.row])
        MIBlurPopup.show(popUp, on: self)
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if isApiCall{
            if indexPath.row == (visitorDataArray!.count) - 2{
                CallVisitorFlatVisitor()
            }
        }
    }
    
    
    func CallVisitorFlatVisitor(){
        
        if limit == 0{
            showLoader()
        }
        
        
        var types : String
        
        switch visitorType! {
        case .TodayVisitor:
            types = "Total"
            
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
                
                if self.visitorDataArray == nil{
                    self.visitorDataArray = self.visitorResponseData!.visitor
                }else{
                    self.visitorDataArray = self.visitorDataArray! + self.visitorResponseData!.visitor
                }
                
                if (self.visitorResponseData?.nums)! < 20 {
                    self.isApiCall = false
                    self.limit = self.limit + (self.visitorResponseData?.nums)!
                }else{
                    self.limit = self.limit + (self.visitorResponseData?.nums)!
                }
                
                self.noRecordFoundView.isHidden = true
                self.tableVIew.reloadData()
            }else{
                if self.visitorDataArray != nil{
                    self.isApiCall = false
                }else{
                    self.noRecordFoundView.isHidden = false
                    self.showAlertMessage(titleStr: "Error", messageStr: error!)
                }
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

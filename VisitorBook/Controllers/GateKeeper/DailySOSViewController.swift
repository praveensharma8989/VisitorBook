//
//  DailySOSViewController.swift
//  VisitorBook
//
//  Created by Praveen on 13/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit

class DailySOSViewController: AllPageViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var noRecordFoundView: UIView!
    @IBOutlet weak var DailySOSView: DailySOSImageView!
    @IBOutlet weak var blackView: UIView!
    @IBOutlet weak var tableVIew: UITableView!
    
    
    var dailySOSData : DailySOSData?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initilize()
        // Do any additional setup after loading the view.
    }

    func initilize(){
        
        setBackBarButton(buttonType: .Defauld)
        
        registerCells()
        blackView.isHidden = true
        DailySOSView.isHidden = true
        CallGetDailySOS()
        DailySOSView.dailySOSCancel = {() in
        
            self.blackView.isHidden = true
            self.DailySOSView.isHidden = true
            
        }
        
    }
    
    func registerCells(){
        tableVIew.register(UINib(nibName: "DailySOSTableViewCell", bundle: nil), forCellReuseIdentifier: "DailySOSTableViewCell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailySOSData != nil ? (dailySOSData?.sosData.count)! : 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableVIew.dequeueReusableCell(withIdentifier: "DailySOSTableViewCell") as! DailySOSTableViewCell
        
        cell.setData(data: (dailySOSData?.sosData[indexPath.row])!)
        
        cell.dailySOSImage = {() in
            
            self.DailySOSView.sosData = (self.dailySOSData?.sosData[indexPath.row])!
            self.DailySOSView.reloadData()
            self.blackView.isHidden = false
            self.DailySOSView.isHidden = false
        }
        
        cell.dailySOSCall = {() in
            if let phoneCallURL = URL(string: "tel://\((self.dailySOSData?.sosData[indexPath.row].mobile)!)") {
                
                let application:UIApplication = UIApplication.shared
                if (application.canOpenURL(phoneCallURL)) {
                    application.open(phoneCallURL, options: [:], completionHandler: nil)
                }
            }
            
        }
        
        return cell
    }
    
    func CallGetDailySOS(){
        
        showLoader()
        let param : [String : Any] = ["id" : (gateKeeperData?.id)!
        ]
        
        PSServiceManager.CallSOSDetail(param: param) { (response, status, error) -> (Void) in
            self.dismissLoader()
            if(status){
                
                let jsonData = try? JSONSerialization.data(withJSONObject: response!)
                let jsonDecoder = JSONDecoder()
                self.dailySOSData = try? jsonDecoder.decode(DailySOSData.self, from: jsonData!)
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

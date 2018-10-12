//
//  NotificationViewController.swift
//  VisitorBook
//
//  Created by Praveen on 25/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit

class NotificationViewController: ResidentAllPageViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noRecordFoundView: UIView!
    
    var notificationInfoData : NotificationInfoData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initilize()
        // Do any additional setup after loading the view.
    }
    
    func initilize(){
        
        setBackBarButton(buttonType: .Defauld)
        setNavigationTitle(With: "Notifications", type: .white)
        registerCell()
        CallNotification()
        
    }
    
    func registerCell(){
        tableView.register(UINib(nibName: "NotificationTableViewCell", bundle: nil), forCellReuseIdentifier: "NotificationTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationInfoData != nil ? (notificationInfoData?.notification.count)! : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTableViewCell") as! NotificationTableViewCell
        
        cell.setData(data : (notificationInfoData?.notification[indexPath.row])!)
        
        return cell
        
    }
    
    func CallNotification(){
        
        showLoader()
        
        let param : [String : Any] = ["id" : (residentData?.id)!
            ]
        
        PSServiceManager.CallNotificationList(param: param) { (response, status, error) -> (Void) in
            self.dismissLoader()
            if status{
                let jsonData = try? JSONSerialization.data(withJSONObject: response!)
                let jsonDecoder = JSONDecoder()
                
                self.notificationInfoData = try? jsonDecoder.decode(NotificationInfoData.self, from: jsonData!)
                
                self.noRecordFoundView.isHidden = true
                self.tableView.reloadData()
                
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

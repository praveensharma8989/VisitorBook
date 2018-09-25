//
//  NotificationViewController.swift
//  VisitorBook
//
//  Created by Praveen on 25/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit

class NotificationViewController: ResidentAllPageViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noRecordFoundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initilize()
        // Do any additional setup after loading the view.
    }
    
    func initilize(){
        
        CallNotification()
        
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
                
                self.complainListDataClose = try? jsonDecoder.decode(ComplainListData.self, from: jsonData!)
                
                self.noRecordFoundView.isHidden = false
                self.tableView.reloadData()
                
            }else{
                self.noRecordFoundView.isHidden = true
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

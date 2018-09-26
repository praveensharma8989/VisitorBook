//
//  ResidentInfoViewController.swift
//  VisitorBook
//
//  Created by Praveen Sharma on 25/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit
import MIBlurPopup

class ResidentInfoViewController: ResidentAllPageViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var residentInfoData : ResidentInfoData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initilize()
        // Do any additional setup after loading the view.
    }
    
    func initilize(){
        
        registerCell()
        CallRWAList()
        
    }
    
    func registerCell(){
        
        tableView.register(UINib(nibName: "ResidentInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "ResidentInfoTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return residentInfoData != nil ? (residentInfoData?.flatUser.count)! : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResidentInfoTableViewCell") as! ResidentInfoTableViewCell
        cell.setData(data: (residentInfoData?.flatUser[indexPath.row])!)
        cell.residentInfoClick = {() in
            
            let popUp = ImgeViewController.init(nibName: "DailySOSImageView", bundle: nil)
            popUp.flatUser = (self.residentInfoData?.flatUser[indexPath.row])!
            MIBlurPopup.show(popUp, on: self)
            
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let popUp = NotificationPopUpViewController.init(nibName: "NotificationPopUpViewController", bundle: nil)
        popUp.flatUser = (residentInfoData?.flatUser[indexPath.row])!
        MIBlurPopup.show(popUp, on: self)
        
    }
    
    func CallRWAList(){
        showLoader()
        
        let param : [String : Any] = [
            "id" : (residentData?.id)!,
            "cid" : (residentData?.cid)!
        ]
        
        PSServiceManager.CallRWAList(param: param) { (response, status, error) -> (Void) in
            self.dismissLoader()
            
            if(status){
                let jsonData = try? JSONSerialization.data(withJSONObject: response!)
                let jsonDecoder = JSONDecoder()
                self.residentInfoData = try? jsonDecoder.decode(ResidentInfoData.self, from: jsonData!)
                
                self.tableView.reloadData()
            }else{
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

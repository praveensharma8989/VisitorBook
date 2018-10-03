//
//  EventViewController.swift
//  VisitorBook
//
//  Created by Praveen Sharma on 18/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit

class EventViewController: ResidentAllPageViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noRecordFoundView: UIView!
    @IBOutlet weak var upComingButton: UIButton!
    @IBOutlet weak var completeButton: UIButton!
    
    var eventDataUpComing : EventData?
    var eventDataComplete : EventData?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initilize()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initilize(){
        
        registerCell()
        tableView.dataSource = self
        tableView.delegate = self
        upComingButton.isSelected = true
        completeButton.isSelected = false
        CallEventApi()
    }
    
    func registerCell(){
        tableView.register(UINib(nibName: "EventsTableViewCell", bundle: nil), forCellReuseIdentifier: "EventsTableViewCell")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if upComingButton.isSelected{
            return eventDataUpComing != nil ? (eventDataUpComing?.eventData.count)! : 0
        }else{
            return eventDataComplete != nil ? (eventDataComplete?.eventData.count)! : 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventsTableViewCell") as! EventsTableViewCell
        cell.setData(data: upComingButton.isSelected == true ? (eventDataUpComing?.eventData[indexPath.row])! : (eventDataComplete?.eventData[indexPath.row])!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if upComingButton.isSelected{
            
            if (eventDataUpComing?.eventData[indexPath.row])?.imageNums != "0"{
                let eventPhotoVC = self.storyboard?.instantiateViewController(withIdentifier: "EventPhotosViewController") as! EventPhotosViewController
                eventPhotoVC.eventData = (eventDataUpComing?.eventData[indexPath.row])!
                
                Push(controller: eventPhotoVC)
            }
            
        }else{
            
            if (eventDataComplete?.eventData[indexPath.row])?.imageNums != "0"{
                let eventPhotoVC = self.storyboard?.instantiateViewController(withIdentifier: "EventPhotosViewController") as! EventPhotosViewController
                eventPhotoVC.eventData = (eventDataComplete?.eventData[indexPath.row])!
                
                Push(controller: eventPhotoVC)
            }
            
        }
    
    }
    
    @IBAction func upComingButton_press(_ sender: Any) {
        
        if !(upComingButton.isSelected){
            upComingButton.isSelected = true
            completeButton.isSelected = false
            upComingButton.backgroundColor = UIColor.red
            completeButton.backgroundColor = UIColor.darkGray
            CallEventApi()
        }
        
    }
    
    @IBAction func completeButton_press(_ sender: Any) {
        
        if !(completeButton.isSelected){
            completeButton.isSelected = true
            upComingButton.isSelected = false
            upComingButton.backgroundColor = UIColor.darkGray
            completeButton.backgroundColor = UIColor.red
            CallEventApi()
        }
        
    }
    
    func CallEventApi(){
        showLoader()
        
        var param : [String : Any]
        
        if upComingButton.isSelected{
            param = ["cid" : (residentData?.cid)!,
                     "types" : "Upcomming"
            ]
        }else{
            param = ["cid" : (residentData?.cid)!,
                     "types" : "Complete"
            ]
        }
        
        PSServiceManager.CallEvents(param: param) { (response, status, error) -> (Void) in
            self.dismissLoader()
            if status{
                let jsonData = try? JSONSerialization.data(withJSONObject: response!)
                let jsonDecoder = JSONDecoder()
                if self.upComingButton.isSelected{
                    self.eventDataUpComing = try? jsonDecoder.decode(EventData.self, from: jsonData!)
                }else{
                    self.eventDataComplete = try? jsonDecoder.decode(EventData.self, from: jsonData!)
                }
                self.noRecordFoundView.isHidden = true
                self.tableView.reloadData()
                
            }else{
                self.noRecordFoundView.isHidden = false
                self.showAlertMessage(titleStr: "Error", messageStr: error!)
            }
        }
        
    }
        // Do any additional setup after loading the view.


    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  ResidentChatViewController.swift
//  VisitorBook
//
//  Created by Praveen Sharma on 06/10/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit

class ResidentChatViewController: ResidentAllPageViewController, UITableViewDataSource, UITableViewDelegate, UITextViewDelegate  {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var flatLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var writeMsgTextView: UITextView!
    @IBOutlet weak var sendButton: UIButton!
    
    let isPush : Bool = false
    var fromId : String? = nil
    var flatUser : FlatUser? = nil
    var rWAInfoData : RWAInfoData? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        initilize()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    func initilize(){
        
//        setBackBarButton(buttonType: .Defauld)
//        setNavigationTitle(With: (FlatUser?.cmplid)!, type: .white)
        if flatUser != nil{
            fromId = (flatUser?.id)!
        }
        writeMsgTextView.delegate = self
        writeMsgTextView.text = "Type a message"
        writeMsgTextView.textColor = UIColor.lightGray
        sendButton.isEnabled = false
        registerCell()
        CallRWAInfo()
//        setData()
        
    }
    
    func setData(){
        
        nameLabel.text = (rWAInfoData?.rwaInfo?.name)!
        flatLabel.text = (rWAInfoData?.rwaInfo?.tower)! + ", " + (rWAInfoData?.rwaInfo?.flat)!
        imageView.set_sdWebImage(With: (rWAInfoData?.rwaInfo?.photo)!, placeHolderImage: "userIcon")
    }
    
    func registerCell(){
        tableView.register(UINib(nibName: "UserChatTableViewCell", bundle: nil), forCellReuseIdentifier: "UserChatTableViewCell")
        tableView.register(UINib(nibName: "AdminChatTableViewCell", bundle: nil), forCellReuseIdentifier: "AdminChatTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rWAInfoData != nil ? (rWAInfoData?.rwaReply != nil ? rWAInfoData?.rwaReply?.count : 0)! : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let str : String = (rWAInfoData?.rwaReply![indexPath.row].status)!
        if str == "To"{
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserChatTableViewCell") as! UserChatTableViewCell
            cell.setData(data: (rWAInfoData?.rwaReply![indexPath.row])!)
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AdminChatTableViewCell") as! AdminChatTableViewCell
            cell.setData(data: (rWAInfoData?.rwaReply![indexPath.row])!)
            return cell
        }
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if writeMsgTextView.text.count == 1 && text == "" {
            sendButton.isEnabled = false
        }else{
            sendButton.isEnabled = true
        }
        
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if writeMsgTextView.textColor == UIColor.lightGray {
            writeMsgTextView.text = ""
            writeMsgTextView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if writeMsgTextView.text == "" {
            writeMsgTextView.text = "Type a message"
            writeMsgTextView.textColor = UIColor.lightGray
        }
    }
    
    @IBAction func backButton_press(_ sender: Any) {
        
        PopBack()
        
    }
    @IBAction func sendButton_press(_ sender: Any) {
        
        CallRWAReply()
        
        
    }
    
    func CallRWAReply(){
        
        showLoader()
        
        let param : [String : Any] = [
            
            "from" : (rWAInfoData?.rwaInfo?.id)!,
            "to" : (residentData?.id)!,
            "message" : (writeMsgTextView.text)!
            
        ]
        
        writeMsgTextView.text = ""
        view.endEditing(true)
        PSServiceManager.CallRWAReply(param: param) { (response, status, error) -> (Void) in
            self.dismissLoader()
            if status{
                
                self.CallRWAInfo()
                
            }else{
                self.showAlertMessage(titleStr: "Error", messageStr: error!)
            }
        }
        
    }
    
    func CallRWAInfo(){
        showLoader()
        
        let param : [String : Any] = [
            "from" : fromId!,
            "to" : (residentData?.id)!
        ]
        
        PSServiceManager.CallRWAInfo(param: param) { (response, status, error) -> (Void) in
            self.dismissLoader()
            if status{
                let jsonData = try? JSONSerialization.data(withJSONObject: response!)
                let jsonDecoder = JSONDecoder()
                self.rWAInfoData = try? jsonDecoder.decode(RWAInfoData.self, from: jsonData!)
                
                self.tableView.reloadData()
                self.setData()
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

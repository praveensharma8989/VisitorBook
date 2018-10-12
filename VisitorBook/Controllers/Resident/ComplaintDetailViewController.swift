//
//  ComplaintDetailViewController.swift
//  VisitorBook
//
//  Created by Praveen Sharma on 06/10/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit

class ComplaintDetailViewController: ResidentAllPageViewController, UITableViewDataSource, UITableViewDelegate, UITextViewDelegate {
    
    
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var msgLabel: UILabel!
    @IBOutlet weak var complainPhotoView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var writeMsgTextView: UITextView!
    @IBOutlet weak var sendButton: UIButton!
    
    var complainData : ComplainData? = nil
    var compaintInfoData : CompaintInfoData? = nil
    var complainID : String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initilize()
        // Do any additional setup after loading the view.
    }
    
    func initilize(){
        
        setBackBarButton(buttonType: .Defauld)
        setNavigationTitle(With: (complainData?.cmplid)!, type: .white)
        writeMsgTextView.delegate = self
        writeMsgTextView.text = "Type a message"
        writeMsgTextView.textColor = UIColor.lightGray
        sendButton.isEnabled = false
        if complainID == nil{
            complainID = complainData?.id
        }
        registerCell()
        CallComplaintInfo()
        
    }
    
    func setData(){
        
        subjectLabel.text = (compaintInfoData?.complainInfo.subject)!
        msgLabel.text = (compaintInfoData?.complainInfo.message)!
        
        if compaintInfoData?.complainInfo.photo == nil || compaintInfoData?.complainInfo.photo == ""{
            complainPhotoView.isHidden = true
        }else{
            complainPhotoView.isHidden = false
            complainPhotoView.set_sdWebImage(With: (compaintInfoData?.complainInfo.photo)!, placeHolderImage: "userIcon")
        }
        
    }
    
    func registerCell(){
        tableView.register(UINib(nibName: "UserChatTableViewCell", bundle: nil), forCellReuseIdentifier: "UserChatTableViewCell")
        tableView.register(UINib(nibName: "AdminChatTableViewCell", bundle: nil), forCellReuseIdentifier: "AdminChatTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return compaintInfoData != nil ? (compaintInfoData?.complainReply != nil ? compaintInfoData?.complainReply?.count : 0)! : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let str : String = (compaintInfoData?.complainReply![indexPath.row].userType)!
        if str == "User"{
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserChatTableViewCell") as! UserChatTableViewCell
            cell.setData(data: (compaintInfoData?.complainReply![indexPath.row])!)
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AdminChatTableViewCell") as! AdminChatTableViewCell
            cell.setData(data: (compaintInfoData?.complainReply![indexPath.row])!)
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
    
    @IBAction func sendButton_press(_ sender: Any) {
        
        CallSendMessageApi()
        
        
    }
    
    func CallSendMessageApi(){
        
        showLoader()
        
        let param : [String : Any] = [
            
            "compl_id" : (complainData?.id)!,
            "message" : (writeMsgTextView.text)!
        
        ]
        
        writeMsgTextView.text = ""
        view.endEditing(true)
        PSServiceManager.CallComplainReply(param: param) { (response, status, error) -> (Void) in
            self.dismissLoader()
            if status{

                self.CallComplaintInfo()
                
            }else{
                self.showAlertMessage(titleStr: "Error", messageStr: error!)
            }
        }
        
    }
    
    func CallComplaintInfo(){
        showLoader()
        
        let param : [String : Any] = ["id" : complainID!]
        
        PSServiceManager.CallComplainInfo(param: param) { (response, status, error) -> (Void) in
            self.dismissLoader()
            if status{
                let jsonData = try? JSONSerialization.data(withJSONObject: response!)
                let jsonDecoder = JSONDecoder()
                self.compaintInfoData = try? jsonDecoder.decode(CompaintInfoData.self, from: jsonData!)
                
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

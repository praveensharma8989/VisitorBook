//
//  ComplaintInfoViewController.swift
//  VisitorBook
//
//  Created by Praveen on 25/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit

class ComplaintInfoViewController: ResidentAllPageViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var norecordFoundView: UIView!
    @IBOutlet weak var openButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    var complainListDataOpen : ComplainListData?
    var complainListDataClose : ComplainListData?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initilize()
        // Do any additional setup after loading the view.
    }
    
    func initilize(){
        
        setBackBarButton(buttonType: .Defauld)
        registerCell()
        tableView.dataSource = self
        tableView.delegate = self
        openButton.isSelected = true
        closeButton.isSelected = false
        CallComplaintApi()
    }
    
    func registerCell(){
        tableView.register(UINib(nibName: "ComplaintInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "ComplaintInfoTableViewCell")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if openButton.isSelected{
            return complainListDataOpen != nil ? (complainListDataOpen?.complain?.count)! : 0
        }else{
            return complainListDataClose != nil ? (complainListDataClose?.complain?.count)! : 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ComplaintInfoTableViewCell") as! ComplaintInfoTableViewCell
        cell.setData(data: openButton.isSelected == true ? (complainListDataOpen?.complain![indexPath.row])! : (complainListDataClose?.complain![indexPath.row])!)
        
        return cell
    }

    @IBAction func openButton_press(_ sender: Any) {
        
        if !(openButton.isSelected){
            openButton.isSelected = true
            closeButton.isSelected = false
            openButton.backgroundColor = UIColor.red
            closeButton.backgroundColor = UIColor.darkGray
            CallComplaintApi()
        }
        
    }
    @IBAction func closeButton_press(_ sender: Any) {
        
        if !(closeButton.isSelected){
            closeButton.isSelected = true
            openButton.isSelected = false
            openButton.backgroundColor = UIColor.darkGray
            closeButton.backgroundColor = UIColor.red
            CallComplaintApi()
        }
        
    }
    
    
    func CallComplaintApi(){
        showLoader()
        
        var param : [String : Any]
        
        if openButton.isSelected{
            param = ["id" : (residentData?.id)!,
                     "status" : "open"
            ]
        }else{
            param = ["id" : (residentData?.id)!,
                     "status" : "close"
            ]
        }
        
        
        PSServiceManager.CallComplainList(param: param) { (response, status, error) -> (Void) in
            self.dismissLoader()
            if status{
                let jsonData = try? JSONSerialization.data(withJSONObject: response!)
                let jsonDecoder = JSONDecoder()
                if self.openButton.isSelected{
                    self.complainListDataOpen = try? jsonDecoder.decode(ComplainListData.self, from: jsonData!)
                }else{
                    self.complainListDataClose = try? jsonDecoder.decode(ComplainListData.self, from: jsonData!)
                }
                self.norecordFoundView.isHidden = true
                self.tableView.reloadData()
                
            }else{
                self.norecordFoundView.isHidden = false
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

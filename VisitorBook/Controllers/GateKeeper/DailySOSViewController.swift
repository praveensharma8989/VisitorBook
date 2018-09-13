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
        DailySOSView.CancelButton_press{() in
        
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
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableVIew.dequeueReusableCell(withIdentifier: "DailySOSTableViewCell") as! DailySOSTableViewCell
        
        
        cell.dailySOSImage = {() in
            
            
        }
        
        cell.dailySOSImage = {() in
            
            
        }
        
        return cell
    }
    
    func CallGetDailySOS(){
        
//        showLoader()
//        let param : [String : Any] = ["old_password" : (oldPasswordText.text)!,
//                                      "new_passwoed" : (newPasswordText.text)!
//        ]
//        
//        PSServiceManager.CallChangePassword(param: param) { (response, status, error) -> (Void) in
//            self.dismissLoader()
//            if(status){
//                
//                
//            }else{
//                self.showAlertMessage(titleStr: "Error", messageStr: error!)
//            }
//            
//        }
        
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

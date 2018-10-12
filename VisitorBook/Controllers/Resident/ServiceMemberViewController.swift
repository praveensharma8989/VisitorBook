//
//  ServiceMemberViewController.swift
//  VisitorBook
//
//  Created by Praveen Sharma on 08/10/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit

class ServiceMemberViewController: ResidentAllPageViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var categoryData : CategoryData? = nil
    var staffCategoryInfoData : StaffCategoryInfoData? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initilize()
        // Do any additional setup after loading the view.
    }
    
    func initilize(){
        
        tableView.contentInset = .zero
        tableView.contentInsetAdjustmentBehavior = .never
        setBackBarButton(buttonType: .Defauld)
        setNavigationTitle(With: (categoryData?.category)!, type: .white)
        registerCell()
        CallStaffDetail()
        
    }
    
    func registerCell(){
        
        tableView.register(UINib(nibName: "ServiceMemberTableViewCell", bundle: nil), forCellReuseIdentifier: "ServiceMemberTableViewCell")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return staffCategoryInfoData != nil ? (staffCategoryInfoData?.staffData.count)! : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ServiceMemberTableViewCell") as! ServiceMemberTableViewCell
        cell.setData(data: (staffCategoryInfoData?.staffData[indexPath.row])!)
        
        return cell
    }
    
    
    
    func CallStaffDetail(){
        showLoader()
        
        let param : [String : Any] = [
            "id" : (residentData?.id)!,
            "cat_id" : (categoryData?.id)!
        ]
        
        PSServiceManager.CallStaffDetail(param: param) { (response, status, error) -> (Void) in
            self.dismissLoader()
            
            if(status){
                let jsonData = try? JSONSerialization.data(withJSONObject: response!)
                let jsonDecoder = JSONDecoder()
                self.staffCategoryInfoData = try? jsonDecoder.decode(StaffCategoryInfoData.self, from: jsonData!)
                
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

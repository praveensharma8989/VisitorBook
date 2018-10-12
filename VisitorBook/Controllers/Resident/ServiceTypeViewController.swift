//
//  ServiceTypeViewController.swift
//  VisitorBook
//
//  Created by Praveen Sharma on 08/10/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit

class ServiceTypeViewController: ResidentAllPageViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var staffCategoryData : StaffCategoryData? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        initilize()
        // Do any additional setup after loading the view.
    }
    
    func initilize(){
        
        tableView.contentInset = .zero
        tableView.contentInsetAdjustmentBehavior = .never
        setBackBarButton(buttonType: .Defauld)
        setNavigationTitle(With: "Services", type: .white)
        registerCell()
        CallStaffCategory()
        
    }
    
    func registerCell(){
        
        tableView.register(UINib(nibName: "ServicesTypeTableViewCell", bundle: nil), forCellReuseIdentifier: "ServicesTypeTableViewCell")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return staffCategoryData != nil ? (staffCategoryData?.category.count)! : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ServicesTypeTableViewCell") as! ServicesTypeTableViewCell
        cell.setData(data: (staffCategoryData?.category[indexPath.row])!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let ServiceMemberVC = self.storyboard?.instantiateViewController(withIdentifier: "ServiceMemberViewController") as! ServiceMemberViewController
        ServiceMemberVC.categoryData = (staffCategoryData?.category[indexPath.row])!
        Push(controller: ServiceMemberVC)
        
    }

    
    func CallStaffCategory(){
        showLoader()
        
        let param : [String : Any] = [
                "id" : (residentData?.id)!
            ]
        
        PSServiceManager.CallStaffCategory(param: param) { (response, status, error) -> (Void) in
            self.dismissLoader()
            
            if(status){
                let jsonData = try? JSONSerialization.data(withJSONObject: response!)
                let jsonDecoder = JSONDecoder()
                self.staffCategoryData = try? jsonDecoder.decode(StaffCategoryData.self, from: jsonData!)
                
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

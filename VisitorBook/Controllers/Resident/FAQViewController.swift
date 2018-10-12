//
//  FAQViewController.swift
//  VisitorBook
//
//  Created by Praveen Sharma on 04/10/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit

class FAQViewController: ResidentAllPageViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var fAQData : FAQData? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initilize()
        // Do any additional setup after loading the view.
    }
    
    func initilize(){
        
        navigationController?.navigationBar.items![1].setHidesBackButton(true, animated: false)
        setBackBarButton(buttonType: .Defauld)
        setNavigationTitle(With: "FAQ", type: .white)
        registerCell()
        CallFAQ()
    }
    
    
    func registerCell(){
        tableView.register(UINib(nibName: "FAQTableViewCell", bundle: nil), forCellReuseIdentifier: "FAQTableViewCell")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fAQData != nil ? (fAQData?.faq.count)! : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FAQTableViewCell") as! FAQTableViewCell
        
        cell.setData(data: (fAQData?.faq[indexPath.row])!)
        return cell
        
    }
    
    func CallFAQ(){
        
        showLoader()
        
        let param : [String : Any] = [
            "id" : (residentData?.id)!
        ]
        
        PSServiceManager.CallFAQ(param: param) { (response, status, error) -> (Void) in
            self.dismissLoader()
            if status{
                let jsonData = try? JSONSerialization.data(withJSONObject: response!)
                let jsonDecoder = JSONDecoder()
                self.fAQData = try? jsonDecoder.decode(FAQData.self, from: jsonData!)
                
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

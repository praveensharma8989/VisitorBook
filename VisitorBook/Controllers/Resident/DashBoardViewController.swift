//
//  DashBoardViewController.swift
//  VisitorBook
//
//  Created by Praveen Sharma on 18/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit

class DashBoardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initilize()
        // Do any additional setup after loading the view.
    }

    func initilize(){
        
        registerCell()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func registerCell(){
        tableView.register(UINib(nibName: "QuickActionTableViewCell", bundle: nil), forCellReuseIdentifier: "QuickActionTableViewCell")
        
        tableView.register(UINib(nibName: "ExpectedVisitorTableViewCell", bundle: nil), forCellReuseIdentifier: "ExpectedVisitorTableViewCell")
        
        tableView.register(UINib(nibName: "RecentVisitorTableViewCell", bundle: nil), forCellReuseIdentifier: "RecentVisitorTableViewCell")
        
        
        let headerNib = UINib.init(nibName: "HeaderView", bundle: Bundle.main)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "HeaderView")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section != 1{
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView") as! HeaderView
            
            headerView.titelLabel.text = "Grocery"
            
            return headerView
        }else{
            return nil
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return section != 1 ? 60 : 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : UITableViewCell? = nil
        
        switch indexPath.section {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: "QuickActionTableViewCell") as! QuickActionTableViewCell
            
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: "ExpectedVisitorTableViewCell") as! ExpectedVisitorTableViewCell
            
        case 2:
            cell = tableView.dequeueReusableCell(withIdentifier: "RecentVisitorTableViewCell") as! RecentVisitorTableViewCell
        default:
            break
        }
        
        return cell!
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

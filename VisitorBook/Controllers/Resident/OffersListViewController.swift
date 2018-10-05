//
//  OffersListViewController.swift
//  VisitorBook
//
//  Created by Praveen Sharma on 05/10/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit
import NotificationCenter

class OffersListViewController: ResidentAllPageViewController, UITableViewDelegate, UITableViewDataSource {
    
    static let instance = OffersListViewController()
    
    @IBOutlet weak var tableView: UITableView!
    var residentDashboardData: ResidentDashboardData?

    let NC = NotificationCenter.default
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initilize()
        // Do any additional setup after loading the view.
    }
    
    func initilize(){
        
        NC.addObserver(self, selector: #selector(setData(_:)), name: Notification.Name("DidChangeSegmentIndex"), object: nil)
        
        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.contentInset = .zero
        tableView.contentInsetAdjustmentBehavior = .never
        
        
        registerCell()

    }
    
    @objc func setData(_ notification: Notification){
        
        let index = notification.object as! Int
        if index == 2{
            residentDashboardData = CommanFunction.instance.getUserDataResidentDashBoard()
        
            tableView.frame.origin = CGPoint(x: 0, y: 0)
            tableView.reloadData()
        }
        
    }
    

    func registerCell(){
        tableView.register(UINib(nibName: "OfferTableViewCell", bundle: nil), forCellReuseIdentifier: "OfferTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return residentDashboardData != nil ? (residentDashboardData?.offerDetails.count)! : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OfferTableViewCell") as! OfferTableViewCell
        cell.setData(data: (residentDashboardData?.offerDetails[indexPath.row])!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let OfferDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "OfferDetailViewController") as! OfferDetailViewController
        
        OfferDetailVC.offerDetail = (residentDashboardData?.offerDetails[indexPath.row])!
        
        Push(controller: OfferDetailVC)
        
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

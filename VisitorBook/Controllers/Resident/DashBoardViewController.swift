//
//  DashBoardViewController.swift
//  VisitorBook
//
//  Created by Praveen Sharma on 18/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit
import FSPagerView

typealias DashBoardApiCompete = (ResidentDashboardData) -> (Void)

enum VisitorActiontype : Int {
    
    case TodayVisitor  = 0
    case WeeklyVisitor
    case TotalVisitor
}

class DashBoardViewController: ResidentAllPageViewController, UITableViewDelegate, UITableViewDataSource, FSPagerViewDataSource, FSPagerViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pagerView: FSPagerView!
    @IBOutlet weak var ImageView: DailySOSImageView!
    @IBOutlet weak var blackView: UIView!
    @IBOutlet weak var userDetailView: UserDetailView!
    
    static let sharedInstance = DashBoardViewController()
    
    var dashBoardApiCompete : DashBoardApiCompete? = nil
    
    var residentDashboardData: ResidentDashboardData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initilize()
        // Do any additional setup after loading the view.
    }

//    func checkDashBoardApi()
    
    func initilize(){
        registerCell()
        tableView.contentInset = .zero
        tableView.contentInsetAdjustmentBehavior = .never
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        pagerView.delegate = self
        pagerView.dataSource = self
        pagerView.itemSize = .zero
        pagerView.automaticSlidingInterval = 3.0
        
        if residentDashboardData == nil{
            callDashBoardData { (response, status) -> (Void) in
                if status{

                    self.residentDashboardData = response
//                    if DashBoardViewController.sharedInstance.dashBoardApiCompete != nil{
//                        DashBoardViewController.sharedInstance.dashBoardApiCompete!(self.residentDashboardData!)
//                    }
                    self.tableView.reloadData()
                    self.pagerView.reloadData()
                }
            }
        }else{
            tableView.reloadData()
            pagerView.reloadData()
        }
        hideSubViews()
        ImageView.dailySOSCancel = {() in
            self.hideSubViews()
        }
        userDetailView.userDetailCancel = {() in
            self.hideSubViews()
        }
        
    }
    
    func hideSubViews(){
        
        blackView.isHidden = true
        ImageView.isHidden = true
        userDetailView.isHidden = true
        
    }
    
    func getDataResident()->ResidentDashboardData?{
        
        return residentDashboardData
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
            
            headerView.titelLabel.text = section == 0 ? "Quick Action" : "Recent Visitor"
            
            return headerView
        }else{
            return nil
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return section != 1 ? 60 : 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return residentDashboardData != nil ? 1 : 0
        }else if section == 2 {
            return residentDashboardData != nil ? (residentDashboardData?.visitorData.count)! : 0
        }
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        var cell : UITableViewCell? = nil
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuickActionTableViewCell") as! QuickActionTableViewCell
            cell.setData(data:residentDashboardData!)
            cell.quickActionClick = {(ClickType) in
                
                self.moveToQuickActionScreen(ClickAction: ClickType)
                
            }
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ExpectedVisitorTableViewCell") as! ExpectedVisitorTableViewCell
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecentVisitorTableViewCell") as! RecentVisitorTableViewCell
            cell.setData(data: (residentDashboardData?.visitorData[indexPath.row])!)
            cell.visitorImageClick = {() in
                
                self.ImageView.visitorInfo = (self.residentDashboardData?.visitorData[indexPath.row])!
                self.ImageView.reloadData()
                self.blackView.isHidden = false
                self.ImageView.isHidden = false
                
            }
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecentVisitorTableViewCell") as! RecentVisitorTableViewCell
            return cell
//            break
        }
        
//        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 2{
            userDetailView.visitorData = (residentDashboardData?.visitorData[indexPath.row])!
            userDetailView.reloadData()
            blackView.isHidden = false
            userDetailView.isHidden = false
        }
        
    }
    
    func moveToQuickActionScreen(ClickAction : QuickActionClickType){
        
        if ClickAction == .TodayClick || ClickAction == .WeekClick || ClickAction == .TotalClick {
            
            let VisitorInfoVC = self.storyboard?.instantiateViewController(withIdentifier: "VisitorInfoViewController") as! VisitorInfoViewController
            
            if ClickAction == .TodayClick{
                VisitorInfoVC.visitorType = .TodayVisitor
            }else if ClickAction == .WeekClick{
                VisitorInfoVC.visitorType = .WeeklyVisitor
            }else{
                VisitorInfoVC.visitorType = .TotalVisitor
            }
            
            Push(controller: VisitorInfoVC)
            
        }else if ClickAction == .ResidentClick{
            let ResidentInfoVC = self.storyboard?.instantiateViewController(withIdentifier: "ResidentInfoViewController") as! ResidentInfoViewController
            Push(controller: ResidentInfoVC)
        }
        
    }
    
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return residentDashboardData != nil ? (residentDashboardData?.bannerData.count)! : 0
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.set_sdWebImage(With: (residentDashboardData?.bannerData[index].banner)!, placeHolderImage: "userIcon") //image = UIImage(named: (residentDashboardData?.bannerData[index].banner)!)
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        cell.textLabel?.text = (residentDashboardData?.bannerData[index].bannerID)!
        return cell
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

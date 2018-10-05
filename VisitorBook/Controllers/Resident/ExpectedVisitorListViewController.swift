//
//  ExpectedVisitorListViewController.swift
//  VisitorBook
//
//  Created by Praveen Sharma on 04/10/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit
import ExpandingMenu

class ExpectedVisitorListViewController: ResidentAllPageViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noRecordFoundView: UIView!
    
    var expectedVisitorData : ExpectedVisitorData? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initilize()
        // Do any additional setup after loading the view.
    }
    
    func initilize(){
        
        setBackBarButton(buttonType: .DefaultHome)
        AddNewVisitButton()
        registerCell()
        CallVisitorList()
    }
    
    func registerCell(){
        tableView.register(UINib(nibName: "ExpectedVisitorsTableViewCell", bundle: nil), forCellReuseIdentifier: "ExpectedVisitorsTableViewCell")
        
    }

    func AddNewVisitButton(){
        
        let menuButtonSize: CGSize = CGSize(width: 64.0, height: 64.0)
        let menuButton = ExpandingMenuButton(frame: CGRect(origin: CGPoint.zero, size: menuButtonSize), centerImage: #imageLiteral(resourceName: "pluseMenuIcon"), centerHighlightedImage: #imageLiteral(resourceName: "pluseMenuIcon"))
        menuButton.center = CGPoint(x: self.view.bounds.width - 32.0, y: self.view.bounds.height - 72.0)
        view.addSubview(menuButton)
        
        let item1 = ExpandingMenuItem(size: menuButtonSize, title: "Create Expected Visitor", image: #imageLiteral(resourceName: "CreateNewIcon"), highlightedImage: #imageLiteral(resourceName: "CreateNewIcon"), backgroundImage: #imageLiteral(resourceName: "CreateNewIcon"), backgroundHighlightedImage: #imageLiteral(resourceName: "CreateNewIcon")) { () -> Void in
            let ExpectedVisitorVC = self.storyboard?.instantiateViewController(withIdentifier: "ExpectedVisitorViewController") as! ExpectedVisitorViewController
            
            self.Push(controller: ExpectedVisitorVC)
        }
        
        
        menuButton.addMenuItems([item1])
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expectedVisitorData != nil ? (expectedVisitorData?.expectedVisitor.count)! : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExpectedVisitorsTableViewCell") as! ExpectedVisitorsTableViewCell
    
        cell.setData(data: (expectedVisitorData?.expectedVisitor[indexPath.row])!)
        cell.viewVisitorvisitPress = {() in
            
            
            let VisitorVisitListVC = self.storyboard?.instantiateViewController(withIdentifier: "VisitorVisitListViewController") as! VisitorVisitListViewController
            VisitorVisitListVC.expectedVisitor = (self.expectedVisitorData?.expectedVisitor[indexPath.row])!
            self.Push(controller: VisitorVisitListVC)
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let qrCodeVisitorVC = self.storyboard?.instantiateViewController(withIdentifier: "qrCodeVisitorViewController") as! qrCodeVisitorViewController
        qrCodeVisitorVC.expectedVisitor = (expectedVisitorData?.expectedVisitor[indexPath.row])!
        Push(controller: qrCodeVisitorVC)
        
    }
    
    func CallVisitorList(){
        
        showLoader()
        
        let param : [String : Any] = [
            "uid": (residentData?.id)!
        ]
        
        PSServiceManager.CallAllExpectedVisitor(param: param) { (response, status, error) -> (Void) in
            
            self.dismissLoader()
            
            if(status){
                
                let jsonData = try? JSONSerialization.data(withJSONObject: response!)
                let jsonDecoder = JSONDecoder()
                self.expectedVisitorData = try? jsonDecoder.decode(ExpectedVisitorData.self, from: jsonData!)
                self.noRecordFoundView.isHidden = true
                
                self.tableView.reloadData()
            }else{
                self.noRecordFoundView.isHidden = false
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

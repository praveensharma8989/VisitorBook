//
//  HeaderViewViewController.swift
//  VisitorBook
//
//  Created by Praveen on 19/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit
import FAPanels

//typealias LeftMenuClick = () -> (Void)

class HeaderViewViewController: UIViewController {

    
    
    @IBOutlet weak var leftMenuButton: UIButton!
//    var leftMenuClick : LeftMenuClick? = nil
//    var currentAnimationType: PGSideMenuAnimationType = .slideIn
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        configureController()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func configureController() {
//        if let sideMenu = self.parent as? PGSideMenu {
//            sideMenu.animationType = self.currentAnimationType
//        }
//    }
    
    @IBAction func leftMenuButton_press(_ sender: Any) {

//        if leftMenuClick != nil{
//            leftMenuClick!()
//        }
        
//        if let sideMenuController = self.parent as? PGSideMenu {
//            sideMenuController.toggleLeftMenu()
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

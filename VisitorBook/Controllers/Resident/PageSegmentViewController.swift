//
//  PageSegmentViewController.swift
//  VisitorBook
//
//  Created by Praveen Sharma on 18/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit
import SJSegmentedScrollView
import PGSideMenu

class PageSegmentViewController: SJSegmentedViewController {

    var selectedSegment: SJSegmentTab?
    var currentAnimationType: PGSideMenuAnimationType = .slideOver
    
    override func viewDidLoad() {
        configureController()
        if let storyboard = self.storyboard {
            
            let firstViewController = storyboard
                .instantiateViewController(withIdentifier: "DashBoardViewController") as! DashBoardViewController
            firstViewController.title = "DashBoard"

            
            let secondViewController = storyboard
                .instantiateViewController(withIdentifier: "EventViewController") as! EventViewController
            secondViewController.title = "Event"

            
            let thirdViewController = storyboard
                .instantiateViewController(withIdentifier: "PostViewController") as! PostViewController
            thirdViewController.title = "Post"
            
            let header = storyboard
                .instantiateViewController(withIdentifier: "HeaderViewViewController") as! HeaderViewViewController
            
            header.leftMenuClick = {() in
                
                if let sideMenuController = self.parent as? PGSideMenu {
                    sideMenuController.toggleLeftMenu()
                }
                
            }
            
            
            headerViewController = header
            
            headerViewHeight = 100
            segmentControllers = [firstViewController,
                                  secondViewController,
                                  thirdViewController]
            
            selectedSegmentViewHeight = 5.0
            headerViewOffsetHeight = 60.0
            segmentTitleColor = .gray
            selectedSegmentViewColor = .red
            segmentShadow = SJShadow.light()
            showsHorizontalScrollIndicator = false
            showsVerticalScrollIndicator = false
            segmentBounces = false
            delegate = self
        }
        
        title = "Segment"
//        let btn = UIButton(type: .custom)
//        btn.frame = CGRect(x: 0, y: 0, width: 40, height: 30)
//        btn.addTarget(self, action: #selector(BackButtonClicked), for: .touchUpInside)
//        btn.setImage(#imageLiteral(resourceName: "backButton"), for: .normal)
//        self.navigationItem.setLeftBarButton(UIBarButtonItem(customView: btn), animated: true)
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

//    @objc func BackButtonClicked() {
//        if let sideMenuController = self.parent as? PGSideMenu {
//            sideMenuController.toggleRightMenu()
//        }
//    }
    
    func configureController() {
        if let sideMenu = self.parent as? PGSideMenu {
            sideMenu.animationType = self.currentAnimationType
        }
    }
    
    
    func getSegmentTabWithImage(_ imageName: String) -> UIView {
        
        let view = UIImageView()
        view.frame.size.width = 32
        view.image = UIImage(named: imageName)
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .white
        return view
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension PageSegmentViewController: SJSegmentedViewControllerDelegate {
    
    func didMoveToPage(_ controller: UIViewController, segment: SJSegmentTab?, index: Int) {
        
        if selectedSegment != nil {
            selectedSegment?.titleColor(.lightGray)
        }
        
        if segments.count > 0 {
            
            selectedSegment = segments[index]
            selectedSegment?.titleColor(.red)
        }
    }
}

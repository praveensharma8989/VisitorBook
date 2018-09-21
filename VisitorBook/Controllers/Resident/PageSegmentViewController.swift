//
//  PageSegmentViewController.swift
//  VisitorBook
//
//  Created by Praveen Sharma on 18/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit
import SJSegmentedScrollView
import FAPanels

class PageSegmentViewController: SJSegmentedViewController{

    
    var selectedSegment: SJSegmentTab?
    var navigationBarView : NavigationBarView?
    
    override func viewDidLoad() {
        segmentConfig()

        super.viewDidLoad()
        
        initilize()
        // Do any additional setup after loading the view.
    }

    func initilize(){
        
        navigationBarView = NavigationBarView.init(frame: (navigationController?.navigationBar.bounds)!)
        
        navigationBarView!.leftMenuClick = {() in
            
            self.panel?.openLeft(animated: true)
            
        }
        
        navigationController?.navigationBar.addSubview(navigationBarView!)
        
    }
    
    func segmentConfig(){
        
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
            
//            header.leftMenuClick = {() in
//
//                self.panel?.openLeft(animated: true)
////                if let sideMenuController = self.parent as? PGSideMenu {
////                    sideMenuController.toggleLeftMenu()
////                }
//
//            }
            
            
//            headerViewController = header
            
//            headerViewHeight = 200
            segmentControllers = [firstViewController,
                                  secondViewController,
                                  thirdViewController]
            
            
            selectedSegmentViewHeight = 5.0
//            headerViewOffsetHeight = 40.0
            segmentTitleColor = .gray
            selectedSegmentViewColor = .red
            segmentShadow = SJShadow.light()
            showsHorizontalScrollIndicator = false
            showsVerticalScrollIndicator = false
            segmentBounces = false
            delegate = self
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

//
//  GateKeeperTabBatController.swift
//  VisitorBook
//
//  Created by Praveen on 06/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit

class GateKeeperTabBatController: UITabBarController, UITabBarControllerDelegate {

    var kBarHeight : CGFloat = 58
    override func awakeFromNib() {
        self.tabBarController?.delegate = self
        self.delegate = self
    }
    
    override func viewWillLayoutSubviews() {
        
        super.viewWillLayoutSubviews()
        
        hideTopShadow()
        setBorderStyle()
        
        var tabFrame = self.tabBar.frame;
        
        if UIDevice().userInterfaceIdiom == .phone{
            
            switch UIScreen.main.nativeBounds.height {
            case 2436:
                kBarHeight = 110
            default:
                kBarHeight = 58
            }
            
        }
        
        
        print("height",tabFrame.size.height)
        if tabFrame.size.height <= kBarHeight
        {
            tabFrame.size.height = kBarHeight
            tabFrame.origin.y = view.frame.height - tabFrame.size.height
        }
        
        
        for tabbarItem in (tabBar.items)! {
            
            tabbarItem.titlePositionAdjustment = UIOffset.init(horizontal: 0, vertical: -5)
            
        }
        
        self.tabBar.frame = tabFrame;
    }

    func setBorderStyle(){
        
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: (view.frame.width/2)-40 , height: 0), cornerRadius: 15)
        
        let path1 = UIBezierPath(arcCenter: CGPoint.init(x: (view.frame.width/2), y: 30), radius: 50, startAngle: -144 * CGFloat.pi/180, endAngle: -36 * CGFloat.pi/180, clockwise: true)
        
        let path2 = UIBezierPath(roundedRect: CGRect(x: (view.frame.width/2) + 40, y: 0, width: (view.frame.width/2)-40 , height: 0), cornerRadius: 15)
        path.append(path1)
        path.append(path2)
        
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        
        mask.strokeColor = UIColor.gray.cgColor
        mask.fillColor = UIColor.clear.cgColor
        mask.lineWidth = 1
        
        tabBar.layer.addSublayer(mask)
    }
    
    public func hideTopShadow() {
        // looking for tabBar
        for subview in self.view.subviews {
            let tabBarSubviewName = String(describing: type(of: subview))
            guard tabBarSubviewName == "UITabBar" else { continue }
            
            // looking for _UIBarBackground. The other subivews are UITabBarButtons
            for tabBarSubview in subview.subviews {
                let tabBarSubviewName = String(describing: type(of: tabBarSubview))
                guard tabBarSubviewName == "_UIBarBackground" else { continue }
                
                // looking for UIImageView. This is the only subview
                for shadowView in tabBarSubview.subviews where shadowView is UIImageView {
                    shadowView.isHidden = true
                    return
                }
            }
        }
        print(" **** ERROR: Could not find the shadow view \(self.self) \(#function)")
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        if tabBarController.selectedIndex == 0 || tabBarController.selectedIndex == 1{
            AppDelegate.sharedInstance.gateKeeperSelectedIndex = tabBarController.selectedIndex
        }
        
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

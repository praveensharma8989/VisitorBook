//
//  AllPageViewController.swift
//  VisitorBook
//
//  Created by Praveen Sharma on 05/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit

enum BarButtonPosition : Int {
    case BarButtonPositionLeft = 0
    case BarButtonPositionRight
}

public enum  BackButtonType : Int {
    
    case Defauld,
    Home
    
}

enum BarButtonType : Int {
    case RightDot = 0,
    TabbarBack
    
}

public enum  navigationType : Int {
    case Transparent,
    
    white,
    
    defaultColor
    
}

public class AllPageViewController: UIViewController, UINavigationControllerDelegate {

    var viewDot : DotViewMenu?
    
    var gateKeeperData : VisitorUsers?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        gateKeeperData = CommanFunction.instance.getUserDataGateKeeper()
        // Do any additional setup after loading the view.
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setBackBarButton(buttonType : BackButtonType) {
        
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 0, y: 0, width: 40, height: 30)
        
        switch buttonType {
        case .Defauld:
            
            btn.addTarget(self, action: #selector(BackButtonClicked), for: .touchUpInside)
            btn.setImage(#imageLiteral(resourceName: "backIcon"), for: .normal)
            
        case .Home:
            
            btn.addTarget(self, action: #selector(HomeButtonClicked), for: .touchUpInside)
            btn.setImage(#imageLiteral(resourceName: "homeIcon"), for: .normal)
            
        default:
            break
        }
        
        
        self.navigationItem.setLeftBarButton(UIBarButtonItem(customView: btn), animated: true)
    }
    
    @objc func BackButtonClicked() {
        PopBack()
    }
    
    @objc func HomeButtonClicked() {
        PopToRoot()
    }
    
    func setNavigationBar(Navigationtype: navigationType ) {
        
        if Navigationtype == .Transparent {
            navigationController?.isNavigationBarHidden = false
            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            navigationController?.navigationBar.shadowImage = UIImage()
            navigationController?.navigationBar.isTranslucent = true
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
            
        }
        else {
            navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
            navigationController?.navigationBar.shadowImage = nil
            navigationController?.navigationBar.isTranslucent = false
            navigationController?.navigationBar.barTintColor = UIColor.red
            
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.APPTHEMECOLOR]
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

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

    override public func viewDidLoad() {
        super.viewDidLoad()

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
            btn.setImage(#imageLiteral(resourceName: "backButton"), for: .normal)
            
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
    
    @objc func BackToSelectedIndex() {
        self.tabBarController?.selectedIndex = AppDelegate.sharedInstance.gateKeeperSelectedIndex
    }

    // MARK:- Set BarButton Item Button With Image
    func setBarButtonItem(withButtonImage: UIImage, withPosition: BarButtonType, needAdjustMent: Bool)
    {
        let btn1 = UIButton(type: .custom)
        
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        switch withPosition {
        case .RightDot:
            
            var imageView = UIImageView.init(frame: CGRect.init(x: 8, y: 1, width: 25, height: 30))
            
            if #available(iOS 11.0, *) {
                imageView = UIImageView.init(frame: CGRect.init(x: 8, y: -1, width: 25, height: 30))
            }
            
            imageView.image = withButtonImage
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
            let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 35, height: 36))
            
            let btn1 = UIButton(type: .custom)
            btn1.frame = view.frame
            
            view.addSubview(imageView)
            view.addSubview(btn1)
            
            self.navigationItem.rightBarButtonItem = nil
            btn1.addTarget(self, action: #selector(rightNavigationButton), for: .touchUpInside)
            self.navigationItem.setRightBarButton(UIBarButtonItem(customView: view), animated: true)
            
            break
            
        case .TabbarBack:
            
            var imageView = UIImageView.init(frame: CGRect.init(x: 8, y: 1, width: 25, height: 30))
            
            if #available(iOS 11.0, *) {
                imageView = UIImageView.init(frame: CGRect.init(x: 8, y: -1, width: 25, height: 30))
            }
            
            imageView.image = withButtonImage
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
            let view = UIView.init(frame: CGRect.init(x: 0, y: 5, width: 35, height: 36))
            
            let btn1 = UIButton(type: .custom)
            btn1.frame = view.frame
            
            view.addSubview(imageView)
            view.addSubview(btn1)
            
            self.navigationItem.leftBarButtonItem = nil
            btn1.addTarget(self, action: #selector(BackToSelectedIndex), for: .touchUpInside)
            let barItem = UIBarButtonItem(customView: view)
            self.navigationController?.navigationBar.topItem?.leftBarButtonItem = barItem
//            self.navigationController?.navigationBar.addSubview(view)
//            self.navigationController?.navigationItem.setLeftBarButton(UIBarButtonItem(customView: view), animated: true)
//            self.navigationController?.navigationBar.setItems([self.navigationItem], animated: false)
            break
            
        default:
            break
            
        }
        
    }
    
    @objc func rightNavigationButton() {
        
        
        
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

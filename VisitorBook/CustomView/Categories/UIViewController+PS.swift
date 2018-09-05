//
//  UIViewController+PS.swift
//  VisitorBook
//
//  Created by Praveen Sharma on 05/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SVProgressHUD

extension UIViewController{
    
    public func showAlertMessage(titleStr:String, messageStr:String )
    {
        AppIntializer.shared.showPopUp(message:messageStr)
    }
    
    public func showLoader()
    {
        
        AppDelegate.sharedInstance.currentView = self
        
        if (NetworkReachabilityManager()?.isReachable)! == true {
            
            SVProgressHUD.show(withStatus: "Please wait...")
            
        }
        else{
            self.noInternetAvailable()
        }
    }
    
    public func dismissLoader()
    {
        //        DispatchQueue.global().async {
        //    }
        if AppDelegate.sharedInstance.currentView == self {
            SVProgressHUD.dismiss()
        }
    }
    
    func noInternetAvailable() {
        AppIntializer.shared.showPopUp(message:"Please check Internet connection")
    }
    
    public func Push(controller : UIViewController) {
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    public func pushWithoutAnimation(controller : UIViewController) {
        self.navigationController?.pushViewController(controller, animated: false)
    }
    
    public func PopBack() {
        self.navigationController!.popViewController(animated: true)
    }
    
    public func PopToRoot() {
        self.navigationController!.popToRootViewController(animated: true)
    }
    
    public func PopTo(Controller controller : UIViewController) {
        self.navigationController!.popToViewController(controller, animated: true)
    }
    
}

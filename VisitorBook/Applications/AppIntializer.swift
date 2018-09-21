//
//  AppIntializer.swift
//  VisitorBook
//
//  Created by Praveen on 05/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import UIKit
import SwiftMessages
import SVProgressHUD
import FAPanels

class AppIntializer: NSObject {
    
    
    var messagePopUp = MessageView.viewFromNib(layout: .centeredView)
    var config = SwiftMessages.Config()
    static let shared = AppIntializer()
    
    func setupIntial()
    {
        
        checkUserType()
        
        setProgressSetting()
        setupPopUp()
    }
    
    func checkUserType(){
        
        let userType = CommanFunction.instance.checkUserType()
        
        if userType == .GateKeeper{
            moveToGateKeeperScreen()
        }else if userType == .Resident{
            moveToResidentScreen()
        }else{
            moveToLoginScreen()
        }
        
        
    }
    
    func moveToLoginScreen(){
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        
        let loginViewController = storyboard.instantiateViewController(withIdentifier:"LoginViewController") as! LoginViewController
        
        let navigationcontroller = UINavigationController.init(rootViewController: loginViewController)
        
        navigationcontroller.setNavigationBarHidden(false, animated: false)
        
        AppDelegate.sharedInstance.window?.rootViewController = navigationcontroller
        
        AppDelegate.sharedInstance.window?.makeKeyAndVisible()
        
    }
    
    func moveToGateKeeperScreen(){
        
        let storyboard = UIStoryboard.init(name: "GateKeeper", bundle: nil)
        
        let NewVisitorController = storyboard.instantiateViewController(withIdentifier:"GateKeeperTabBatController") as! GateKeeperTabBatController
        
        let navigationcontroller = UINavigationController.init(rootViewController: NewVisitorController)
        
        navigationcontroller.setNavigationBarHidden(false, animated: false)
        
        AppDelegate.sharedInstance.window?.rootViewController = navigationcontroller
        
        AppDelegate.sharedInstance.window?.makeKeyAndVisible()
        
    }
    
    func moveToResidentScreen(){
        
//        let storyboard = UIStoryboard.init(name: "Resident", bundle: nil)
//
//        let NewVisitorController = storyboard.instantiateViewController(withIdentifier:"PageSegmentViewController") as! PageSegmentViewController
//
//        let navigationcontroller = UINavigationController.init(rootViewController: NewVisitorController)
//
//        navigationcontroller.setNavigationBarHidden(false, animated: false)

        
        
        
        
        let storyboard = UIStoryboard.init(name: "Resident", bundle: nil)
        
        let ContentController = storyboard.instantiateViewController(withIdentifier:"PageSegmentViewController") as! PageSegmentViewController
        
        let LeftMenuController = storyboard.instantiateViewController(withIdentifier:"LeftMenuViewController") as! LeftMenuViewController
        
        var fAPanelController = storyboard.instantiateViewController(withIdentifier:"FAPanelController") as! FAPanelController
        
//        FAPanelController
        
//        let navigationcontroller = UINavigationController.init(rootViewController: ContentController)
//
//        navigationcontroller.setNavigationBarHidden(false, animated: false)
        
//        AppDelegate.sharedInstance.window?.rootViewController = ContentController
        
        fAPanelController.leftPanelPosition = .front
        _ = fAPanelController.center(ContentController).left(LeftMenuController)
        
        AppDelegate.sharedInstance.window?.rootViewController = fAPanelController
        
//        fAPanelController = AppDelegate.sharedInstance.window?.rootViewController as! FAPanelController
        
        
//        let sideMenuController = PGSideMenu(animationType: .slideInRotate)
//        let contentController = ContentController
//        let leftMenuController = LeftMenuController
//        sideMenuController.addContentController(contentController)
//        sideMenuController.addLeftMenuController(leftMenuController)
        
        
//        AppDelegate.sharedInstance.window?.rootViewController = sideMenuController
        
        AppDelegate.sharedInstance.window?.makeKeyAndVisible()
        
    }
    
//    fileprivate func loadExampleAppStructure() {
//        self.window = UIWindow(frame: UIScreen.main.bounds)
//        self.window?.makeKeyAndVisible()
//
//        let storyboard = UIStoryboard.init(name: "Resident", bundle: nil)
//
//        let ContentController = storyboard.instantiateViewController(withIdentifier:"HeaderViewViewController") as! HeaderViewViewController
//
//        let LeftMenuController = storyboard.instantiateViewController(withIdentifier:"LeftMenuViewController") as! LeftMenuViewController
//
//        let sideMenuController = PGSideMenu(animationType: .slideIn)
//        let contentController = ContentController
//        let leftMenuController = LeftMenuController
//        sideMenuController.addContentController(contentController)
//        sideMenuController.addLeftMenuController(leftMenuController)
//        self.window?.rootViewController = sideMenuController
//    }
    
    
    func showPopUp(message : String){
        AppIntializer.shared.messagePopUp.configureContent(body: message)
        AppIntializer.shared.messagePopUp.configureTheme(backgroundColor: UIColor.init(red: 42/255, green: 62/255, blue: 81/255, alpha: 1), foregroundColor: UIColor.white)
        AppIntializer.shared.messagePopUp.backgroundView?.layer.borderWidth = 1.0
        AppIntializer.shared.messagePopUp.backgroundView?.layer.borderColor = UIColor.white.cgColor
        AppIntializer.shared.messagePopUp.bodyLabel?.textAlignment = .center
        AppIntializer.shared.messagePopUp.bodyLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        
        
        //        SwiftMessages.show(view: )
        SwiftMessages.show(config: config, view: AppIntializer.shared.messagePopUp )
    }
    
    func setProgressSetting() {
        
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setMaxSupportedWindowLevel(UIWindowLevelNormal+100)
        SVProgressHUD.setDefaultMaskType(.gradient)
        SVProgressHUD.setDefaultAnimationType(.flat)
        SVProgressHUD.setBackgroundColor(UIColor.white)
        SVProgressHUD.setForegroundColor(UIColor.red)
        SVProgressHUD.setRingRadius(20.0)
        
        
    }
    
    func setupPopUp()  {
        
        messagePopUp.configureTheme(.info)
        messagePopUp.configureTheme(backgroundColor: UIColor.TOPALERTCOLOR, foregroundColor: UIColor.white)
        messagePopUp.iconLabel?.isHidden = true
        messagePopUp.button?.isHidden = true
        messagePopUp.titleLabel?.isHidden = true
        messagePopUp.preferredHeight = 30.0
        messagePopUp.configureDropShadow()
        
        // Slide up from the bottom.
        config.presentationStyle = .top
        
        config.presentationContext = .window(windowLevel: UIWindowLevelStatusBar)

    }
    
}

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

class AppIntializer: NSObject {
    
    var messagePopUp = MessageView.viewFromNib(layout: .centeredView)
    var config = SwiftMessages.Config()
    static let shared = AppIntializer()
    
    func setupIntial()
    {
        setProgressSetting()
        setupPopUp()
    }
    
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

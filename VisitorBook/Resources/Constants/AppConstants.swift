//
//  AppConstants.swift
//  structureCoversionDemo
//
//  Created by Mobikasa on 07/09/17.
//  Copyright © 2017 mobikasa. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

typealias JSONDictionary = [String: Any]

enum CARequestApiName:String {
    
    case
    AddSignUp               = "",
    LogIn                   = "login.php",
    ForgotPassowrd          = "forgot_pwd.php",
    SignUp                  = "enquiry.php",
    VisitorOTP              = "visitorOTP.php",
    NewVisitor              = "newvisitor.php",
    OldVisitor              = "submit_repeat_visitor.php",
    AllTower                = "AllTower.php",
    AllFloor                = "AllFloor.php",
    AllFlat                 = "AllFlat.php",
    AllPurpose              = "AllPurpose.php",
    UpdateVisitor           = "updatevisitor.php",
    PendingVisit            = "PendingVisit.php",
    ResentVisitReq          = "ResentVisitReq.php",
    SearchVisitor           = "SearchVisitor.php"
    
}


struct ServiceConstant {

//    static var BaseURL: String = "https://app.chachisfood.com/"             //Live
    static var BaseURL: String = "https://gobuzy.com/vb/json/"       //Staging\

    
}

struct AppConstants {
    
    static var K_USERPASS: String = "password"
    static var K_ACCESSTOKEN: String = "AccessToken"
    static var K_USERNAME: String = "username"
    static var K_GUIDELABEL: String = "GuideLabel"
    static var K_SESSIONTOKEN: String = "X-User-Token"
    static var K_MASTERDATA_CHECKSUM: String = "masterData_Checksum"
    static var K_USERID: String = "USERID"
    static var K_DEVICE_TOKEN: String = "deviceToken"
    static var K_DEVICE_ID: String = "DeviceId"
    static var K_BADGE_COUNT: String = "badgeCount"
    static var K_APP_LAUNCH: String = "AlreadyAppLaunch"
    static var k_isOTPVerified : String = "isOtpVerified"
    static var K_USEREMAIL: String = "userEmail"
    static var k_NOTIFY: String = ""
    static var k_masterData : String = "masterData"
    
    static var k_userType : String = "userType"
    static var k_gateKeeperUser : String = "gateKeeperUser"
    
    // Date Format
    static var K_DATE_MMDDYY: String = "yy-MM-dd"
    static var K_DATE_MMDDYYYY: String = "yyyy-MM-dd"
    static var K_DATE_WITHTIME: String = "yyyy-MM-dd HH:mm:ss"
    
    //font name
    
    static let K_THEME_FONT_REGULAR = "OpenSans"
    static let K_THEME_FONT_BOLD = "OpenSans-Bold"
    static let K_THEME_FONT_SEMIBOLD = "OpenSans-SemiBold"
    static let K_THEME_FONT_LIGHT = "OpenSans-Light"
    static let K_THEME_FONT_LIGH = "Roboto-Light"
    static let K_THEME_FONT_MED = "Roboto-Medium"
    static let K_THEME_FONT_ROBOTOREG = "Roboto-Regular"
    
    //Location
    static var K_CURRENT_LOCATION: String = "currentLocation"
    static var K_UserLocation: String = "userlocation"
    
    let APP_NAME = Bundle.main.object(forInfoDictionaryKey: "MBBundleName")
    
    static func isReachableToInternet() -> Bool{
        
        return  (NetworkReachabilityManager()?.isReachable)!
        
    }
    
    
    static func resetDefaults() {
        
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
    }
    
    static func resetUserDefaultkeys(){
        
        let launchBool =  AppConstants.GET_USER_DEFAULTS(Key: AppConstants.K_APP_LAUNCH)
        
        // let locationname = AppConstants.GET_USER_DEFAULTS(Key: AppConstants.K_CURRENT_LOCATION)
        resetDefaults()
        
        //        if locationname != nil{
        //
        //            AppConstants.SAVE_USER_DEFAULTS(value: locationname as String!, key: AppConstants.K_CURRENT_LOCATION)
        //
        //        }
        if launchBool != nil{
            
            AppConstants.SAVE_USER_DEFAULTS(value: "Yes", key: AppConstants.K_APP_LAUNCH)
            
        }
    }
    static func IsIPHONEX()->Bool {
        if SCREEN_SIZE.width == 375 && SCREEN_SIZE.height > 770 {
            return true
        }
        return false
    }
    static func SAVE_USER_DEFAULTS(value: Any, key: String) {
        
        
        
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    static func GET_USER_DEFAULTS(Key: String) -> String? {
        
        return UserDefaults.standard.object(forKey: Key) as? String
        
    }
    
    static func REMOVE_USER_DEFAULTSFOR(KEY: String) {
        
        UserDefaults.standard.removeObject(forKey: KEY)
    }
    
    static let SCREEN_SIZE : CGSize = {
        
        return UIScreen.main.bounds.size
    }()
    
    static func HIDE_NETWORK_PROGRESS() {
        
        if isReachableToInternet(){
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
        }
    }
    static let APP_DELEGATE : AppDelegate = {
        
        return AppDelegate.sharedInstance
    }()
    
    static let APP_WINDOW : UIWindow? = {
        
        return AppConstants.APP_DELEGATE.window
    }()
    
    static let IS_NETWORK_REACHABLE : Bool = {
        
        return isReachableToInternet()
    }()
    
    static func SHOW_NETWORK_PROGRESS() {
        
        if isReachableToInternet(){
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            
        }
    }
    static func checkNet() ->Bool{
        
        if (NetworkReachabilityManager()?.isReachable)! == true {
            
            return true
            
        }
            
        else{
            //showAlertMessage(titleStr: "Internet Error", messageStr: "Please check Internet connection")
            //            self.showNoInternetView(completion: { (status) in
            //
            //            })
            return false
        }
        
    }
    static func tabBarNew()->UITabBarController{
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        
        return storyboard.instantiateViewController(withIdentifier: "TabbarVC") as! UITabBarController
    }
    
    static func getUniqueIdentifier() -> NSString {
        
        return UIDevice.current.identifierForVendor!.uuidString as NSString
        
    }
    
}


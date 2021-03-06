//
//  PSServiceManager.swift
//  structureCoversionDemo
//
//  Created by Praveen on 09/10/17.
//  Copyright © 2017 praveen. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

typealias completionBlock = ([String: Any]?, Bool, String?) -> (Void)
typealias completionForgotPasswordBlock = ([String: Any]?, Bool, String?,Int) -> (Void)
typealias completionUpdateProfileBlock = ([String: Any]?, Bool, String?, Int) -> (Void)
typealias homeCompletionBlock = ([String: Any]?, Bool, String?, Int) -> (Void)

class PSServiceManager: NSObject {
    
    static func filterErrorMessageUsingResponseRequestOperation(response: [String : Any]? ,errorcode: Int,error : Error?) -> String? {
        
        
        if errorcode == 400{
            
            // AppDelegate.sharedInstance.moveToLandingPage()
            
        }
        else if errorcode ==  401{
            //              HTTPClient.shared?.cancellAllOperations()
            
            HTTPClient.shared?.cancellAllOperations()
            
            AppConstants.resetUserDefaultkeys()
            
            //            UserDefaults.standard.removeObject(forKey: AppConstants.K_UserLocation)
            //            UserDefaults.standard.removeObject(forKey: AppConstants.K_CURRENT_LOCATION)
            
            
//            AppDelegate.sharedInstance.moveToLandingPage()
//            DispatchQueue.main.asyncAfter(deadline:.now() + 0.2 , execute: {
//                if response != nil && response!["message"] != nil{
//                    AppIntializer.shared.showPopUp(message: response!["message"] as! String)
//                    
//                }
//                else{
//                    AppIntializer.shared.showPopUp(message: "You have been logged out, please log in again.")
//                    
//                }
//                //                CRNotifications.showNotification(type: .error, title: "Error", message: "You have been logged out, please log in again.", dismissDelay: 2.0)
//                
//            })
            
        }
        //        else if errorcode == 405{
        //
        //            AppDelegate.sharedInstance.moveToOTPScreen()
        //
        //        }
        
        
        if(error != nil ){
            
            return error?.localizedDescription
        }
        else{
            if(response != nil){
                
                return response?["message"] as? String
            }
            else {
                
                return "Unable to connect to server. Please try again after sometime."
            }
        }
    }
    
    
    public static func userloginApi(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+CARequestApiName.LogIn.rawValue, params: param) { ( responsedata, statuscode , error) -> (Void) in
            if statuscode == 200 {
                
                if responsedata!["error"] as? Bool == true{
                    completionBlock(responsedata,true, nil)
                }else{
                    completionBlock(nil,false, responsedata!["msg"] as? String)
                }
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
            }
        }
    }
    
    public static func forgotPassword(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+CARequestApiName.ForgotPassowrd.rawValue, params: param) { ( responsedata, statuscode , error) -> (Void) in
            if statuscode == 200 {
                
                if responsedata!["error"] as? Bool == true{
                    completionBlock(responsedata,true, nil)
                }else{
                    completionBlock(nil,false, responsedata!["msg"] as? String)
                }
                
                
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
            }
        }
    }
    
    public static func signUp(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+CARequestApiName.SignUp.rawValue, params: param) { ( responsedata, statuscode , error) -> (Void) in
            if statuscode == 200 {
                
                if responsedata!["error"] as? Bool == true{
                    completionBlock(responsedata,true, nil)
                }else{
                    completionBlock(nil,false, responsedata!["msg"] as? String)
                }
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
            }
        }
    }
    
    
    public static func visitorOTP(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+CARequestApiName.VisitorOTP.rawValue, params: param) { ( responsedata, statuscode , error) -> (Void) in
            if statuscode == 200 {
                
                if responsedata!["error"] as? Bool == true{
                    completionBlock(responsedata,true, nil)
                }else{
                    completionBlock(nil,false, responsedata!["msg"] as? String)
                }
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
            }
        }
    }
    
    public static func newVisitor(param:[String:Any], imageData:Data,completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.multiPartPostHTTPRequest(baseUrl: ServiceConstant.BaseURL+CARequestApiName.NewVisitor.rawValue, imageData: imageData, imageName: "Photo", params: param, progressBlock: { (progress) -> (Void) in
            
        }, completionBlock: { (responsedata, statuscode, error) -> (Void) in
            
            if statuscode == 200 {
                
                if responsedata!["error"] as? Bool == true{
                    completionBlock(responsedata,true, nil)
                }else{
                    completionBlock(nil,false, responsedata!["msg"] as? String)
                }
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
            }
            
        })
    }
    
    public static func OldVisitor(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+CARequestApiName.OldVisitor.rawValue, params: param) { ( responsedata, statuscode , error) -> (Void) in
            if statuscode == 200 {
                
                if responsedata!["error"] as? Bool == true{
                    completionBlock(responsedata,true, nil)
                }else{
                    completionBlock(nil,false, responsedata!["msg"] as? String)
                }
                
                
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
            }
        }
    }
    
    public static func CallPendingVisit(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+CARequestApiName.PendingVisit.rawValue, params: param) { ( responsedata, statuscode , error) -> (Void) in
            if statuscode == 200 {
                
                if responsedata!["error"] as? Bool == true{
                    completionBlock(responsedata,true, nil)
                }else{
                    completionBlock(nil,false, responsedata!["msg"] as? String)
                }
                
                
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
            }
        }
    }
    
    public static func CallResentVisitReq(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+CARequestApiName.ResentVisitReq.rawValue, params: param) { ( responsedata, statuscode , error) -> (Void) in
            if statuscode == 200 {
                
                if responsedata!["error"] as? Bool == true{
                    completionBlock(responsedata,true, nil)
                }else{
                    completionBlock(nil,false, responsedata!["msg"] as? String)
                }
                
                
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
            }
        }
    }
    
    public static func CallSearchVisitor(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+CARequestApiName.SearchVisitor.rawValue, params: param) { ( responsedata, statuscode , error) -> (Void) in
            if statuscode == 200 {
                
                if responsedata!["error"] as? Bool == true{
                    completionBlock(responsedata,true, nil)
                }else{
                    completionBlock(nil,false, responsedata!["msg"] as? String)
                }
                
                
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
            }
        }
    }
    
    
    public static func CallAllTower(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+CARequestApiName.AllTower.rawValue, params: param) { ( responsedata, statuscode , error) -> (Void) in
            if statuscode == 200 {
                
                if responsedata!["error"] as? Bool == true{
                    completionBlock(responsedata,true, nil)
                }else{
                    completionBlock(nil,false, responsedata!["msg"] as? String)
                }
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
            }
        }
    }
    
    public static func CallAllFloor(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+CARequestApiName.AllFloor.rawValue, params: param) { ( responsedata, statuscode , error) -> (Void) in
            if statuscode == 200 {
                
                if responsedata!["error"] as? Bool == true{
                    completionBlock(responsedata,true, nil)
                }else{
                    completionBlock(nil,false, responsedata!["msg"] as? String)
                }
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
            }
        }
    }
    
    public static func CallAllFlat(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+CARequestApiName.AllFlat.rawValue, params: param) { ( responsedata, statuscode , error) -> (Void) in
            if statuscode == 200 {
                
                if responsedata!["error"] as? Bool == true{
                    completionBlock(responsedata,true, nil)
                }else{
                    completionBlock(nil,false, responsedata!["msg"] as? String)
                }
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
            }
        }
    }
    
    public static func CallAllPurpose(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+CARequestApiName.AllPurpose.rawValue, params: param) { ( responsedata, statuscode , error) -> (Void) in
            if statuscode == 200 {
                
                if responsedata!["error"] as? Bool == true{
                    completionBlock(responsedata,true, nil)
                }else{
                    completionBlock(nil,false, responsedata!["msg"] as? String)
                }
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
            }
        }
    }
    
    public static func CallUpdateVisitor(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+CARequestApiName.UpdateVisitor.rawValue, params: param) { ( responsedata, statuscode , error) -> (Void) in
            if statuscode == 200 {
                
                if responsedata!["error"] as? Bool == true{
                    completionBlock(responsedata,true, nil)
                }else{
                    completionBlock(nil,false, responsedata!["msg"] as? String)
                }
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
            }
        }
    }
    
    public static func CallChangePassword(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+CARequestApiName.ChangePassword.rawValue, params: param) { ( responsedata, statuscode , error) -> (Void) in
            if statuscode == 200 {
                
                if responsedata!["error"] as? Bool == true{
                    completionBlock(responsedata,true, nil)
                }else{
                    completionBlock(nil,false, responsedata!["msg"] as? String)
                }
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
            }
        }
    }
    
    public static func CallSOSDetail(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+CARequestApiName.SOSDetail.rawValue, params: param) { ( responsedata, statuscode , error) -> (Void) in
            if statuscode == 200 {
                
                if responsedata!["error"] as? Bool == true{
                    completionBlock(responsedata,true, nil)
                }else{
                    completionBlock(nil,false, responsedata!["msg"] as? String)
                }
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
            }
        }
    }
    
    public static func CallGuardLogout(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+CARequestApiName.GuardLogout.rawValue, params: param) { ( responsedata, statuscode , error) -> (Void) in
            if statuscode == 200 {
                
                if responsedata!["error"] as? Bool == true{
                    completionBlock(responsedata,true, nil)
                }else{
                    completionBlock(nil,false, responsedata!["msg"] as? String)
                }
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
            }
        }
    }
    
    public static func CallVisitExit(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+CARequestApiName.VisitExit.rawValue, params: param) { ( responsedata, statuscode , error) -> (Void) in
            if statuscode == 200 {
                
                if responsedata!["error"] as? Bool == true{
                    completionBlock(responsedata,true, nil)
                }else{
                    completionBlock(nil,false, responsedata!["msg"] as? String)
                }
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
            }
        }
    }
    
    public static func CallDashboard(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+CARequestApiName.DashBoard.rawValue, params: param) { ( responsedata, statuscode , error) -> (Void) in
            if statuscode == 200 {
                
                if responsedata!["error"] as? Bool == true{
                    completionBlock(responsedata,true, nil)
                }else{
                    completionBlock(nil,false, responsedata!["msg"] as? String)
                }
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
            }
        }
    }
    
    public static func CallMaintanance(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+CARequestApiName.Maintanance.rawValue, params: param) { ( responsedata, statuscode , error) -> (Void) in
            if statuscode == 200 {
                
                if responsedata!["error"] as? Bool == true{
                    completionBlock(responsedata,true, nil)
                }else{
                    completionBlock(nil,false, responsedata!["msg"] as? String)
                }
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
            }
        }
    }
    
    public static func CallFlatMobile(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+CARequestApiName.FlatMobile.rawValue, params: param) { ( responsedata, statuscode , error) -> (Void) in
            if statuscode == 200 {
                
                if responsedata!["error"] as? Bool == true{
                    completionBlock(responsedata,true, nil)
                }else{
                    completionBlock(nil,false, responsedata!["msg"] as? String)
                }
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
            }
        }
    }
    
    public static func CallFlatProfile(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+CARequestApiName.FlatProfile.rawValue, params: param) { ( responsedata, statuscode , error) -> (Void) in
            if statuscode == 200 {
                
                if responsedata!["error"] as? Bool == true{
                    completionBlock(responsedata,true, nil)
                }else{
                    completionBlock(nil,false, responsedata!["msg"] as? String)
                }
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
            }
        }
    }
    
    public static func CallEvents(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+CARequestApiName.Events.rawValue, params: param) { ( responsedata, statuscode , error) -> (Void) in
            if statuscode == 200 {
                
                if responsedata!["error"] as? Bool == true{
                    completionBlock(responsedata,true, nil)
                }else{
                    completionBlock(nil,false, responsedata!["msg"] as? String)
                }
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
            }
        }
    }
    
    public static func CallEventsImages(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+CARequestApiName.EventsImages.rawValue, params: param) { ( responsedata, statuscode , error) -> (Void) in
            if statuscode == 200 {
                
                if responsedata!["error"] as? Bool == true{
                    completionBlock(responsedata,true, nil)
                }else{
                    completionBlock(nil,false, responsedata!["msg"] as? String)
                }
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
            }
        }
    }
    
    public static func CallFlat_Visitor(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+CARequestApiName.Flat_Visitor.rawValue, params: param) { ( responsedata, statuscode , error) -> (Void) in
            if statuscode == 200 {
                
                if responsedata!["error"] as? Bool == true{
                    completionBlock(responsedata,true, nil)
                }else{
                    completionBlock(nil,false, responsedata!["msg"] as? String)
                }
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
            }
        }
    }
    
    public static func CallRWAList(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+CARequestApiName.RWAList.rawValue, params: param) { ( responsedata, statuscode , error) -> (Void) in
            if statuscode == 200 {
                
                if responsedata!["error"] as? Bool == true{
                    completionBlock(responsedata,true, nil)
                }else{
                    completionBlock(nil,false, responsedata!["msg"] as? String)
                }
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
            }
        }
    }
    
    public static func CallComplainList(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+CARequestApiName.ComplainList.rawValue, params: param) { ( responsedata, statuscode , error) -> (Void) in
            if statuscode == 200 {
                
                if responsedata!["error"] as? Bool == true{
                    completionBlock(responsedata,true, nil)
                }else{
                    completionBlock(nil,false, responsedata!["msg"] as? String)
                }
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
            }
        }
    }
    
    public static func CallComplainCat(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+CARequestApiName.ComplainCat.rawValue, params: param) { ( responsedata, statuscode , error) -> (Void) in
            if statuscode == 200 {
                
                if responsedata!["error"] as? Bool == true{
                    completionBlock(responsedata,true, nil)
                }else{
                    completionBlock(nil,false, responsedata!["msg"] as? String)
                }
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
            }
        }
    }
    
    public static func CallNotificationList(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+CARequestApiName.NotificationList.rawValue, params: param) { ( responsedata, statuscode , error) -> (Void) in
            if statuscode == 200 {
                
                if responsedata!["error"] as? Bool == true{
                    completionBlock(responsedata,true, nil)
                }else{
                    completionBlock(nil,false, responsedata!["msg"] as? String)
                }
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
            }
        }
    }
    
    
    
    public static func CallSOSDetailResident(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+CARequestApiName.SOSDetailResident.rawValue, params: param) { ( responsedata, statuscode , error) -> (Void) in
            if statuscode == 200 {
                
                if responsedata!["error"] as? Bool == true{
                    completionBlock(responsedata,true, nil)
                }else{
                    completionBlock(nil,false, responsedata!["msg"] as? String)
                }
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
            }
        }
    }
    
    public static func CallUpdateSOSDetail(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+CARequestApiName.UpdateSOS.rawValue, params: param) { ( responsedata, statuscode , error) -> (Void) in
            if statuscode == 200 {
                
                if responsedata!["error"] as? Bool == true{
                    completionBlock(responsedata,true, nil)
                }else{
                    completionBlock(nil,false, responsedata!["msg"] as? String)
                }
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
            }
        }
    }
    
    public static func CallLogoutFlatUser(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+CARequestApiName.LogoutFlatUser.rawValue, params: param) { ( responsedata, statuscode , error) -> (Void) in
            if statuscode == 200 {
                
                if responsedata!["error"] as? Bool == true{
                    completionBlock(responsedata,true, nil)
                }else{
                    completionBlock(nil,false, responsedata!["msg"] as? String)
                }
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
            }
        }
    }
    
    public static func CallCreateExpectedVisitor(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+CARequestApiName.CreateExpectedVisitor.rawValue, params: param) { ( responsedata, statuscode , error) -> (Void) in
            if statuscode == 200 {
                
                if responsedata!["error"] as? Bool == true{
                    completionBlock(responsedata,true, nil)
                }else{
                    completionBlock(nil,false, responsedata!["msg"] as? String)
                }
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
            }
        }
    }
    
    
    public static func CallAllExpectedVisitor(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+CARequestApiName.AllExpectedVisitor.rawValue, params: param) { ( responsedata, statuscode , error) -> (Void) in
            if statuscode == 200 {
                
                if responsedata!["error"] as? Bool == true{
                    completionBlock(responsedata,true, nil)
                }else{
                    completionBlock(nil,false, responsedata!["msg"] as? String)
                }
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
            }
        }
    }
    
    
    public static func CallExpectedVisitorVisit(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+CARequestApiName.ExpectedVisitorVisit.rawValue, params: param) { ( responsedata, statuscode , error) -> (Void) in
            if statuscode == 200 {
                
                if responsedata!["error"] as? Bool == true{
                    completionBlock(responsedata,true, nil)
                }else{
                    completionBlock(nil,false, responsedata!["msg"] as? String)
                }
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
            }
        }
    }
    
    public static func CallUpdateFlatUser(param:[String:Any], imageData:Data?,completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.multiPartPostHTTPRequest(baseUrl: ServiceConstant.BaseURL+CARequestApiName.UpdateFlatUser.rawValue, imageData: imageData, imageName: "photo", params: param, progressBlock: { (progress) -> (Void) in
            
        }, completionBlock: { (responsedata, statuscode, error) -> (Void) in
            
            if statuscode == 200 {
                
                if responsedata!["error"] as? Bool == true{
                    completionBlock(responsedata,true, nil)
                }else{
                    completionBlock(nil,false, responsedata!["msg"] as? String)
                }
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
            }
            
        })
    }
    
    public static func CallFAQ(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+CARequestApiName.FAQ.rawValue, params: param) { ( responsedata, statuscode , error) -> (Void) in
            if statuscode == 200 {
                
                if responsedata!["error"] as? Bool == true{
                    completionBlock(responsedata,true, nil)
                }else{
                    completionBlock(nil,false, responsedata!["msg"] as? String)
                }
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
            }
        }
    }
    
    public static func CallAboutUs(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+CARequestApiName.AboutUs.rawValue, params: param) { ( responsedata, statuscode , error) -> (Void) in
            if statuscode == 200 {
                
                if responsedata!["error"] as? Bool == true{
                    completionBlock(responsedata,true, nil)
                }else{
                    completionBlock(nil,false, responsedata!["msg"] as? String)
                }
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
            }
        }
    }
    
    
    public static func CallClaimForOffer(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+CARequestApiName.ClaimForOffer.rawValue, params: param) { ( responsedata, statuscode , error) -> (Void) in
            if statuscode == 200 {
                
                if responsedata!["error"] as? Bool == true{
                    completionBlock(responsedata,true, nil)
                }else{
                    completionBlock(nil,false, responsedata!["msg"] as? String)
                }
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
            }
        }
    }
    
    public static func CallStaffVerify(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+CARequestApiName.StaffVerify.rawValue, params: param) { ( responsedata, statuscode , error) -> (Void) in
            if statuscode == 200 {
                
                if responsedata!["error"] as? Bool == true{
                    completionBlock(responsedata,true, nil)
                }else{
                    completionBlock(nil,false, responsedata!["msg"] as? String)
                }
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
            }
        }
    }
    
    public static func CallStaffLogin(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+CARequestApiName.StaffLogin.rawValue, params: param) { ( responsedata, statuscode , error) -> (Void) in
            if statuscode == 200 {
                
                if responsedata!["error"] as? Bool == true{
                    completionBlock(responsedata,true, nil)
                }else{
                    completionBlock(nil,false, responsedata!["msg"] as? String)
                }
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
            }
        }
    }
    
    public static func CallStaffLogout(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+CARequestApiName.StaffLogout.rawValue, params: param) { ( responsedata, statuscode , error) -> (Void) in
            if statuscode == 200 {
                
                if responsedata!["error"] as? Bool == true{
                    completionBlock(responsedata,true, nil)
                }else{
                    completionBlock(nil,false, responsedata!["msg"] as? String)
                }
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
            }
        }
    }
    
    public static func CallSendComplain(param:[String:Any], imageData:Data?,completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.multiPartPostHTTPRequest(baseUrl: ServiceConstant.BaseURL+CARequestApiName.SendComplain.rawValue, imageData: imageData, imageName: "photos", params: param, progressBlock: { (progress) -> (Void) in
            
        }, completionBlock: { (responsedata, statuscode, error) -> (Void) in
            
            if statuscode == 200 {
                
                if responsedata!["error"] as? Bool == true{
                    completionBlock(responsedata,true, nil)
                }else{
                    completionBlock(nil,false, responsedata!["msg"] as? String)
                }
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
            }
            
        })
    }
    
    public static func CallComplainInfo(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+CARequestApiName.ComplainInfo.rawValue, params: param) { ( responsedata, statuscode , error) -> (Void) in
            if statuscode == 200 {
                
                if responsedata!["error"] as? Bool == true{
                    completionBlock(responsedata,true, nil)
                }else{
                    completionBlock(nil,false, responsedata!["msg"] as? String)
                }
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
            }
        }
    }
    
    
    public static func CallComplainReply(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+CARequestApiName.ComplainReply.rawValue, params: param) { ( responsedata, statuscode , error) -> (Void) in
            if statuscode == 200 {
                
                if responsedata!["error"] as? Bool == true{
                    completionBlock(responsedata,true, nil)
                }else{
                    completionBlock(nil,false, responsedata!["msg"] as? String)
                }
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
            }
        }
    }
    
    public static func CallRWAInfo(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+CARequestApiName.RWAInfo.rawValue, params: param) { ( responsedata, statuscode , error) -> (Void) in
            if statuscode == 200 {
                
                if responsedata!["error"] as? Bool == true{
                    completionBlock(responsedata,true, nil)
                }else{
                    completionBlock(nil,false, responsedata!["msg"] as? String)
                }
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
            }
        }
    }
    
    
    public static func CallRWAReply(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+CARequestApiName.RWAReply.rawValue, params: param) { ( responsedata, statuscode , error) -> (Void) in
            if statuscode == 200 {
                
                if responsedata!["error"] as? Bool == true{
                    completionBlock(responsedata,true, nil)
                }else{
                    completionBlock(nil,false, responsedata!["msg"] as? String)
                }
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
            }
        }
    }
    
    public static func CallStaffCategory(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+CARequestApiName.StaffCategory.rawValue, params: param) { ( responsedata, statuscode , error) -> (Void) in
            if statuscode == 200 {
                
                if responsedata!["error"] as? Bool == true{
                    completionBlock(responsedata,true, nil)
                }else{
                    completionBlock(nil,false, responsedata!["msg"] as? String)
                }
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
            }
        }
    }
    
    public static func CallStaffDetail(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+CARequestApiName.StaffDetail.rawValue, params: param) { ( responsedata, statuscode , error) -> (Void) in
            if statuscode == 200 {
                
                if responsedata!["error"] as? Bool == true{
                    completionBlock(responsedata,true, nil)
                }else{
                    completionBlock(nil,false, responsedata!["msg"] as? String)
                }
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
            }
        }
    }
    
    public static func CallAllBlogs(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+CARequestApiName.AllBlogs.rawValue, params: param) { ( responsedata, statuscode , error) -> (Void) in
            if statuscode == 200 {
                
                if responsedata!["error"] as? Bool == true{
                    completionBlock(responsedata,true, nil)
                }else{
                    completionBlock(nil,false, responsedata!["msg"] as? String)
                }
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
            }
        }
    }

    
    public static func CallAllBlogLikes(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+CARequestApiName.AllBlogLikes.rawValue, params: param) { ( responsedata, statuscode , error) -> (Void) in
            if statuscode == 200 {
                
                if responsedata!["error"] as? Bool == true{
                    completionBlock(responsedata,true, nil)
                }else{
                    completionBlock(nil,false, responsedata!["msg"] as? String)
                }
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
            }
        }
    }
    
    public static func CallAllBlogComment(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+CARequestApiName.AllBlogComment.rawValue, params: param) { ( responsedata, statuscode , error) -> (Void) in
            if statuscode == 200 {
                
                if responsedata!["error"] as? Bool == true{
                    completionBlock(responsedata,true, nil)
                }else{
                    completionBlock(nil,false, responsedata!["msg"] as? String)
                }
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
            }
        }
    }
    
    public static func CallBlogLikes(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+CARequestApiName.BlogLikes.rawValue, params: param) { ( responsedata, statuscode , error) -> (Void) in
            if statuscode == 200 {
                
                if responsedata!["error"] as? Bool == true{
                    completionBlock(responsedata,true, nil)
                }else{
                    completionBlock(nil,false, responsedata!["msg"] as? String)
                }
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
            }
        }
    }
    
    public static func CallRemoveBlog(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+CARequestApiName.RemoveBlog.rawValue, params: param) { ( responsedata, statuscode , error) -> (Void) in
            if statuscode == 200 {
                
                if responsedata!["error"] as? Bool == true{
                    completionBlock(responsedata,true, nil)
                }else{
                    completionBlock(nil,false, responsedata!["msg"] as? String)
                }
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
            }
        }
    }
    
    public static func CallBlogComment(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+CARequestApiName.BlogComment.rawValue, params: param) { ( responsedata, statuscode , error) -> (Void) in
            if statuscode == 200 {
                
                if responsedata!["error"] as? Bool == true{
                    completionBlock(responsedata,true, nil)
                }else{
                    completionBlock(nil,false, responsedata!["msg"] as? String)
                }
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
            }
        }
    }
    
    public static func CallCreateBlog(param:[String:Any], imageData:[Data]?,completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.multipleMultiPartPostHTTPRequest(baseUrl: ServiceConstant.BaseURL+CARequestApiName.CreateBlog.rawValue, imageData: imageData, imageName: "photos[]", params: param, progressBlock: { (progress) -> (Void) in
            
        }, completionBlock: { (responsedata, statuscode, error) -> (Void) in
            
            if statuscode == 200 {
                
                if responsedata!["error"] as? Bool == true{
                    completionBlock(responsedata,true, nil)
                }else{
                    completionBlock(nil,false, responsedata!["msg"] as? String)
                }
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
            }
            
        })
    }
    
    public static func CallSendSOS(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+CARequestApiName.SendSOS.rawValue, params: param) { ( responsedata, statuscode , error) -> (Void) in
            if statuscode == 200 {
                
                if responsedata!["error"] as? Bool == true{
                    completionBlock(responsedata,true, nil)
                }else{
                    completionBlock(nil,false, responsedata!["msg"] as? String)
                }
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
            }
        }
    }
    
//    public static func resendOTPCall(completionBlock:@escaping completionBlock) -> Void {
//        
//        
//        HTTPClient.shared?.getRequest(baseUrl: ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.ResendOTP.rawValue, params: nil) { ( responsedata, statuscode , error) -> (Void) in
//            
//            if statuscode == 200 {
//                
//                completionBlock(responsedata,true,nil)
//                
//            }
//                
//            else{
//                
//                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)) )
//            }
//            
//        }
//        
//    }
}


class ErrorUtility{
    
    enum MBErrorCodes : Int {
        case MBBadRequest = 400
        case MBUnAuthorized = 401
        case MBForbidden = 403
        case MBNotFound = 404
        case MBParameterMissing = 406
        case MBUserAlreadyExists = 409
        case MBServerError = 500
        case MBNotModified = 304
        case MBNoInternetConnection = -1009
        case MBNoInternetConnectionAgain = -1004
        case MBConnectionTimeOut = -1001
    }
    
    
    
    static func handlePredefinedErrorCode( errorcode: Int, andMessage message: String) -> String {
        
        switch errorcode {
        case MBErrorCodes.MBBadRequest.rawValue:
            return "Parameter Missing"
        case MBErrorCodes.MBUnAuthorized.rawValue:
            return message
        case MBErrorCodes.MBForbidden.rawValue:
            return "Forbidden"
        case MBErrorCodes.MBNotFound.rawValue:
            return "Not Found"
        case MBErrorCodes.MBParameterMissing.rawValue:
            return "Parameter Missing"
        case MBErrorCodes.MBUserAlreadyExists.rawValue:
            return "User Already Exists"
        case MBErrorCodes.MBServerError.rawValue:
            return "Server could not fullfill the request."
        case MBErrorCodes.MBNoInternetConnection.rawValue:
            return "Please check your internet connection or try again later."
        case MBErrorCodes.MBNoInternetConnectionAgain.rawValue:
            return "We are experiencing technical difficulties. Please try again later."
        case MBErrorCodes.MBConnectionTimeOut.rawValue:
            return "The request timed out."
        default:
            return message
        }
        
    }
    
    
}


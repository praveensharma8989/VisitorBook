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
    
    
    public static func  userloginApi(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
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
    
    public static func  forgotPassword(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
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
    
    public static func  signUp(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
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
    
    
    public static func  visitorOTP(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
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
    
    public static func  newVisitor(param:[String:Any], imageData:Data,completionBlock:@escaping completionBlock) -> Void {
        
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
    
    public static func  OldVisitor(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
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
    
    public static func  CallPendingVisit(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
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
    
    public static func  CallResentVisitReq(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
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
    
    public static func  CallSearchVisitor(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
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
    
    
    public static func  CallAllTower(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
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
    
    public static func  CallAllFloor(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
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
    
    public static func  CallAllFlat(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
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
    
    public static func  CallAllPurpose(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
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
    
    public static func  CallUpdateVisitor(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
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
    
    public static func  CallChangePassword(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
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
    
    public static func  CallSOSDetail(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
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
    
    public static func  CallGuardLogout(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
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
    
    public static func  CallVisitExit(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
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
    
    public static func  CallDashboard(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
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


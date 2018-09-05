//
//  MBServiceManager.swift
//  structureCoversionDemo
//
//  Created by Mobikasa on 09/10/17.
//  Copyright © 2017 mobikasa. All rights reserved.
//

import UIKit
import Alamofire

typealias completionBlock = ([String: Any]?, Bool, String?) -> (Void)
typealias completionForgotPasswordBlock = ([String: Any]?, Bool, String?,Int) -> (Void)
typealias completionUpdateProfileBlock = ([String: Any]?, Bool, String?, Int) -> (Void)
typealias homeCompletionBlock = ([String: Any]?, Bool, String?, Int) -> (Void)

class MBServiceManager: NSObject {
    
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
            
            
            AppDelegate.sharedInstance.moveToLandingPage()
            DispatchQueue.main.asyncAfter(deadline:.now() + 0.2 , execute: {
                if response != nil && response!["message"] != nil{
                    AppIntializer.shared.showPopUp(message: response!["message"] as! String)
                    
                }
                else{
                    AppIntializer.shared.showPopUp(message: "You have been logged out, please log in again.")
                    
                }
                //                CRNotifications.showNotification(type: .error, title: "Error", message: "You have been logged out, please log in again.", dismissDelay: 2.0)
                
            })
            
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
    
    
    public static func  userloginApi(param:[String:Any],completionBlock:@escaping homeCompletionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.LogIn.rawValue, params: param) { ( responsedata, statuscode , error) -> (Void) in
            if statuscode == 200 {
                
                if (AppConstants.GET_USER_DEFAULTS(Key: AppConstants.k_isOTPVerified) == nil){
                    
                    AppConstants.SAVE_USER_DEFAULTS(value: "active", key: AppConstants.k_isOTPVerified)
                }
                completionBlock(responsedata,true, nil ,200)
                //completionBlock(responsedata,true,nil)
                
            }
            else{
                
                completionBlock(responsedata,false,filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: nil) ,statuscode)
                //                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)) )
            }
        }
    }
    
    
    public static func updateDeviceToken(param:[String:Any],completionBlock:@escaping completionBlock)-> Void{
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.DeviceToken.rawValue, params: param, completionBlock: { ( responsedata, statuscode , error) -> (Void) in
            if statuscode == 200 {
                
                completionBlock(responsedata,true,nil)
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
                
            }
            
        })
        
    }
    
    public static func deleteRequest(param:[String:Any], completionBlock:@escaping completionBlock) -> Void
    {
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.DeleteRequest.rawValue, params: param, completionBlock:
            { (responsedata, statuscode , error) -> (Void) in
                
                if statuscode == 200 {
                    
                    completionBlock(responsedata, true, nil)
                    
                }
                else
                {
                    completionBlock(nil, false, (filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error)))
                }
                
        })
    }
    
    public static func acceptRequest(param:[String:Any], completionBlock:@escaping completionBlock) -> Void
    {
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.AcceptRequest.rawValue, params: param, completionBlock:
            { (responsedata, statuscode , error) -> (Void) in
                if statuscode == 200 {
                    
                    completionBlock(responsedata, true, nil)
                    
                }
                else
                {
                    completionBlock(nil, false, (filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error)))
                }
                
        })
    }
    
    public static func acceptChefRequest(param:[String:Any], completionBlock:@escaping completionBlock) -> Void
    {
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.AcceptChefRequest.rawValue, params: param, completionBlock:
            { (responsedata, statuscode , error) -> (Void) in
                if statuscode == 200 {
                    
                    completionBlock(responsedata, true, nil)
                    
                }
                else
                {
                    completionBlock(nil, false, (filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error)))
                }
                
        })
    }
    
    public static func makeOffer(param:[String:Any], completionBlock:@escaping completionBlock) -> Void
    {
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.MakeOffer.rawValue, params: param, completionBlock:
            { (responsedata, statuscode , error) -> (Void) in
                if statuscode == 200 {
                    
                    completionBlock(responsedata, true, nil)
                    
                }
                else
                {
                    completionBlock(nil, false, (filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error)))
                }
                
        })
    }
    
    public static func forgotpassword(param:[String:Any],completionBlock:@escaping completionForgotPasswordBlock) -> Void{
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.ForgotPassword.rawValue, params: param, completionBlock: { ( responsedata, statuscode , error) -> (Void) in
            if statuscode == 200 {
                
                completionBlock(responsedata,true,nil,statuscode)
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)),statuscode)
                
            }
            
        })
    }
    
    public static func udpatePhoneAPI(param:[String:Any],completionBlock:@escaping completionBlock) -> Void{
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.UpdatePhone.rawValue, params: param, completionBlock: { ( responsedata, statuscode , error) -> (Void) in
            if statuscode == 200 {
                
                completionBlock(responsedata,true,nil)
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
                
            }
            
        })
    }
    
    public static func helpView(param:[String:Any],completionBlock:@escaping completionBlock) -> Void{
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.HelpUser.rawValue, params: param, completionBlock: { ( responsedata, statuscode , error) -> (Void) in
            if statuscode == 200 {
                
                completionBlock(responsedata,true,nil)
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
                
            }
            
        })
    }
    
    
    public static func newUserSignup(param:[String:Any],completionBlock:@escaping completionBlock) -> Void{
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.RegisteredUser.rawValue, params: param, completionBlock: { ( responsedata, statuscode , error) -> (Void) in
            if statuscode == 200 {
                
                completionBlock(responsedata,true,nil)
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
                
            }
            
        })
    }
    
    public static func additionalUserSignup(param:[String:Any],completionBlock:@escaping completionBlock) -> Void{
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.AddSignUp.rawValue, params: param, completionBlock: { ( responsedata, statuscode , error) -> (Void) in
            if statuscode == 200 {
                
                completionBlock(responsedata,true,nil)
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
                
            }
            
        })
    }
    
    
    public static func userSignup(imageData: Data?, param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.multiPartPostHTTPRequest(baseUrl: ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.RegisteredUser.rawValue, imageData: imageData, imageName: "image", params: param, progressBlock: { (progress) -> (Void) in
            ////progress Block
        }) { ( responsedata, statuscode , error) -> (Void) in
            ////Completion Block
            if statuscode == 200 {
                
                completionBlock(responsedata,true,nil)
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)) )
            }
        }
        
        //
        //        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.RegisteredUser.rawValue, params: param) { ( responsedata, statuscode , error) -> (Void) in
        //
        //            if statuscode == 200 {
        //
        //                completionBlock(responsedata,true,nil)
        //
        //            }
        //            else{
        //
        //                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)) )
        //            }
        //
        //        }
        
    }
    
    public static func postDish(imageData: Data?, param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.multiPartPostHTTPRequest(baseUrl: ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.AddDish.rawValue, imageData: imageData, imageName: "dish_image", params: param, progressBlock: { (progress) -> (Void) in
            
        }) {( responsedata, statuscode , error) -> (Void) in
            if statuscode == 200 {
                
                
                completionBlock(responsedata,true,nil)
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
                
            }
        }
        
    }
    
    public static func getOTPCall(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.GetOTP.rawValue, params: param) { ( responsedata, statuscode , error) -> (Void) in
            
            if statuscode == 200 {
                if (AppConstants.GET_USER_DEFAULTS(Key: AppConstants.k_isOTPVerified) == nil){
                    
                    AppConstants.SAVE_USER_DEFAULTS(value: "active", key: AppConstants.k_isOTPVerified)
                }
                completionBlock(responsedata,true,nil)
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)) )
            }
            
        }
        
    }
    
    public static func verifyOTP(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.VerifyOTP.rawValue, params: param) { ( responsedata, statuscode , error) -> (Void) in
            
            if statuscode == 200 {
                if (AppConstants.GET_USER_DEFAULTS(Key: AppConstants.k_isOTPVerified) == nil){
                    
                    AppConstants.SAVE_USER_DEFAULTS(value: "active", key: AppConstants.k_isOTPVerified)
                }
                completionBlock(responsedata,true,nil)
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)) )
            }
            
        }
        
    }
    
    
    public static func getMasterData(completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.getRequest(baseUrl: ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.MasterData.rawValue, params: nil) { ( responsedata, statuscode , error) -> (Void) in
            
            if statuscode == 200 {
                
                completionBlock(responsedata,true,nil)
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)) )
            }
            
        }
    }
    
    public static func getRequestData(page:Int, completionBlock:@escaping homeCompletionBlock) -> Void {
        
        HTTPClient.shared?.getRequest(baseUrl: ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.GetRequest.rawValue+"?page="+String(page), params: nil) { ( responsedata, statuscode , error) -> (Void) in
            
            if statuscode == 200 {
                
                completionBlock(responsedata,true,nil,statuscode)
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)),statuscode)
            }
            
        }
    }
    
    public static func getfollowers(page:Int, param:String, completionBlock:@escaping homeCompletionBlock) -> Void
    {
        HTTPClient.shared?.getRequest(baseUrl: ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.GetFollowers.rawValue+param, params: nil)
        { ( responsedata, statuscode , error) -> (Void) in
            
            if statuscode == 200 {
                
                completionBlock(responsedata,true,nil,statuscode)
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)),statuscode)
            }
            
        }
    }
    
    public static func getUpgradePopup(app_version : String,completionBlock:@escaping homeCompletionBlock) -> Void
    {
        HTTPClient.shared?.getRequest(baseUrl: ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.UpgradeApp.rawValue+"?app_version="+String(app_version), params: nil)
        { ( responsedata, statuscode , error) -> (Void) in
            
            if statuscode == 200 {
                
                completionBlock(responsedata,true,nil,statuscode)
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)),statuscode)
            }
            
        }
    }
    
    
    public static func getTimelineCategoryApi(completionBlock:@escaping homeCompletionBlock) -> Void {
        
        HTTPClient.shared?.getRequest(baseUrl: ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.TimelineCategories.rawValue, params: nil) { ( responsedata, statuscode , error) -> (Void) in
            
            if statuscode == 200 {
                
                completionBlock(responsedata,true,nil,statuscode)
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)),statuscode)
            }
        }
        
    }
    
    public static func getTimelineSectionData(param:[String:Any], childId:Int,completionBlock:@escaping homeCompletionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.TimelineSectionData.rawValue, params: param) { ( responsedata, statuscode , error) -> (Void) in
            
            if statuscode == 200 {
                
                completionBlock(responsedata,true,nil,childId)
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)), childId)
            }
            
        }
        
    }
    
    public static func mapLocationApi(param:[String:Any], completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.MapUser.rawValue, params: param) { ( responsedata, statuscode , error) -> (Void) in
            
            if statuscode == 200 {
                if responsedata != nil && (responsedata!["status"] as! Int) == 0
                {
                    completionBlock(nil,false,error as? String)
                }
                else{
                    completionBlock(responsedata,true,nil)
                }
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
            }
            
        }
        
    }
    
    public static func getCusinesDishesListData(param:[String:Any], completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.CusineDishes.rawValue, params: param) { ( responsedata, statuscode , error) -> (Void) in
            
            if statuscode == 200 {
                
                completionBlock(responsedata,true,nil)
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
            }
            
        }
        
    }
    
    public static func searchDishChefDataApi(param:[String:Any], completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.SearchDishChef.rawValue, params: param) { ( responsedata, statuscode , error) -> (Void) in
            
            if statuscode == 200 {
                
                completionBlock(responsedata,true,nil)
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
            }
            
        }
        
    }
    
    public static func searchChefDataApi(param:[String:Any], completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.SearchChef.rawValue, params: param) { ( responsedata, statuscode , error) -> (Void) in
            
            if statuscode == 200 {
                
                completionBlock(responsedata,true,nil)
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
            }
            
        }
        
    }
    
    public static func searchDishDataApi(param:[String:Any], completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.SearchDish.rawValue, params: param) { ( responsedata, statuscode , error) -> (Void) in
            
            if statuscode == 200 {
                
                completionBlock(responsedata,true,nil)
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
            }
            
        }
        
    }
    
    public static func getMyDishesData(page:Int, completionBlock:@escaping homeCompletionBlock) -> Void {
        
        HTTPClient.shared?.getRequest(baseUrl: ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.MyDises.rawValue+"?page="+String(page), params: nil) { ( responsedata, statuscode , error) -> (Void) in
            
            if statuscode == 200 {
                
                completionBlock(responsedata,true,nil,statuscode)
                
            }
                
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)),statuscode )
            }
            
        }
        
    }
    
    public static func getMyRequests(page:Int, completionBlock:@escaping homeCompletionBlock) -> Void {
        
        HTTPClient.shared?.getRequest(baseUrl: ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.MyRequest.rawValue+"?page="+String(page), params: nil) { ( responsedata, statuscode , error) -> (Void) in
            
            if statuscode == 200 {
                
                completionBlock(responsedata,true,nil,statuscode)
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)),statuscode )
            }
            
        }
    }
    
    public static func receiveRequests(page:Int, completionBlock:@escaping homeCompletionBlock) -> Void {
        
        HTTPClient.shared?.getRequest(baseUrl: ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.ReceivedRequest.rawValue+"?page="+String(page), params: nil) { ( responsedata, statuscode , error) -> (Void) in
            
            if statuscode == 200 {
                
                completionBlock(responsedata,true,nil,statuscode)
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)),statuscode)
            }
            
        }
    }
    
    public static func getMyHistoryData(page:Int,type:Int, completionBlock:@escaping homeCompletionBlock) -> Void {
        
        HTTPClient.shared?.getRequest(baseUrl: ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.MyHistory.rawValue+"?page=\(page)" + "&data_for=\(type)", params: nil) { ( responsedata, statuscode , error) -> (Void) in
            
            
            if statuscode == 200 {
                
                completionBlock(responsedata,true,nil,statuscode)
                
            }
            else{
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)),statuscode )
            }
            
        }
        
    }
    
    public static func getLikedDishesData(page:Int, completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.getRequest(baseUrl: ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.likedDishesList.rawValue+"?page="+String(page), params: nil) { ( responsedata, statuscode , error) -> (Void) in
            
            if statuscode == 200 {
                
                completionBlock(responsedata,true,nil)
                
            }
                
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)) )
            }
            
        }
        
    }
    public static func resendOTPCall(completionBlock:@escaping completionBlock) -> Void {
        
        
        HTTPClient.shared?.getRequest(baseUrl: ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.ResendOTP.rawValue, params: nil) { ( responsedata, statuscode , error) -> (Void) in
            
            if statuscode == 200 {
                
                completionBlock(responsedata,true,nil)
                
            }
                
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)) )
            }
            
        }
        
    }
    
    public static func voiceOTPAuthApi(completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.getRequest(baseUrl: ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.voiceOTPAuth.rawValue, params: nil) { ( responsedata, statuscode , error) -> (Void) in
            
            if statuscode == 200 {
                completionBlock(responsedata, true, nil)
            }else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
            }
        }
        
    }
    
    public static func  checkUserExistenceApi(param:[String:Any],completionBlock:@escaping homeCompletionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.IsUserRegistered.rawValue, params: param ) { ( responsedata, statuscode , error) -> (Void) in
            
            if statuscode == 200 {
                
                completionBlock(responsedata,true,nil, 200)
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)), statuscode)
                
            }
            
            
        }
        
    }
    
    public static func requestDishApi(param:[String:Any], completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.RequestDish.rawValue, params: param)
        { ( responsedata, statuscode , error) -> (Void) in
            
            if statuscode == 200
            {
                
                completionBlock(responsedata,true,nil)
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)) )
                
            }
            
        }
        
    }
    
    public static func addReuestApi(param:[String:Any], completionBlock:@escaping completionBlock) -> Void {
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.AddRequest.rawValue, params: param)
        { ( responsedata, statuscode , error) -> (Void) in
            
            if statuscode == 200
            {
                
                completionBlock(responsedata,true,nil)
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)) )
                
            }
            
        }
    }
    
    public static func fetchDishDetailApi(param:[String:Any],completionBlock:@escaping homeCompletionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.DishDetail.rawValue, params:param  ) { ( responsedata, statuscode , error) -> (Void) in
            
            if statuscode == 200  {
                
                if responsedata != nil && (responsedata!["status"] as! Int) == 0 {
                    
                    completionBlock(responsedata,false,filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: nil) ,200)
                    
                }
                else{
                    completionBlock(responsedata,true,nil,statuscode)
                    
                }
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)) ,statuscode)
                
            }
            
            
        }
    }
    
    public static func fetchUserDetailApi(param:[String:Any],completionBlock:@escaping homeCompletionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.userDetail.rawValue, params: param  ) { ( responsedata, statuscode , error) -> (Void) in
            
            if statuscode == 200  {
                
                if responsedata != nil && (responsedata!["status"] as! Int) == 0
                {
                    completionBlock(responsedata,false,filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: nil),statuscode)
                    
                }
                else {
                    completionBlock(responsedata,true,nil,statuscode)
                }
            }
            else {
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)),statuscode)
            }
        }
    }
    
    public static func fetchUserFollowingApi(param:[String:Any],completionBlock:@escaping homeCompletionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.Followings.rawValue, params: param  ) { ( responsedata, statuscode , error) -> (Void) in
            
            if statuscode == 200  {
                
                if responsedata != nil && (responsedata!["status"] as! Int) == 0
                {
                    completionBlock(responsedata,false,filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: nil),statuscode)
                    
                }
                else {
                    completionBlock(responsedata,true,nil,statuscode)
                }
            }
            else {
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)),statuscode)
            }
        }
    }
    
    public static func fetchUserDishesApi(param:[String:Any],completionBlock:@escaping homeCompletionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.UserDishes.rawValue, params: param  ) { ( responsedata, statuscode , error) -> (Void) in
            
            if statuscode == 200  {
                
                if responsedata != nil && (responsedata!["status"] as! Int) == 0
                {
                    completionBlock(responsedata,false,filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: nil),statuscode)
                    
                }
                else {
                    completionBlock(responsedata,true,nil,statuscode)
                }
            }
            else {
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)) ,statuscode)
            }
        }
    }
    
    
    public static func sendUserContactApi(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.contactUser.rawValue, params: param  ) { ( responsedata, statuscode , error) -> (Void) in
            
            if statuscode == 200  {
                
                if responsedata != nil && (responsedata!["status"] as! Int) == 0
                {
                    completionBlock(responsedata,false,filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: nil))
                    
                }
                else {
                    completionBlock(responsedata,true,nil)
                }
            }
            else {
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)) )
            }
        }
    }
    
    
    
    
    public static func addRating(param:[String:Any],completionBlock:@escaping homeCompletionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.AddRating.rawValue, params:param  ) { ( responsedata, statuscode , error) -> (Void) in
            
            if statuscode == 200  {
                
                if responsedata != nil && (responsedata!["status"] as! Int) == 0 {
                    
                    completionBlock(responsedata,false,filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: nil) ,200)
                    
                }
                else{
                    completionBlock(responsedata,true,nil,statuscode)
                    
                }
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)) ,statuscode)
                
            }
            
            
        }
    }
    
    
    
    public static func likeDishApiCall(dishId: Int,completionBlock:@escaping homeCompletionBlock) -> Void {
        let params = ["dish_id" : dishId]
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.likeDish.rawValue, params:params  ) { ( responsedata, statuscode , error) -> (Void) in
            
            if statuscode == 200 {
                
                if responsedata != nil && (responsedata!["status"] as! Int) == 0
                {
                    completionBlock(responsedata,false,filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: nil),200)
                    
                }
                else {
                    completionBlock(responsedata,true,nil,200)
                }
                
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)),statuscode)
                
            }
        }
    }
    
    public static func deleteRating(param:[String:Any],completionBlock:@escaping homeCompletionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.DeleteRating.rawValue, params:param  ) { ( responsedata, statuscode , error) -> (Void) in
            
            if statuscode == 200 {
                
                if responsedata != nil && (responsedata!["status"] as! Int) == 0
                {
                    completionBlock(responsedata,false,filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: nil),200)
                    
                }
                else {
                    completionBlock(responsedata,true,nil,200)
                }
                
                
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)),statuscode )
                
            }
            
            
        }
    }
    
    public static func logoutApiCall(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.Logout.rawValue, params:param  ) { ( responsedata, statuscode , error) -> (Void) in
            
            if statuscode == 200 {
                
                completionBlock(responsedata,true,nil)
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)) )
                
            }
            
            
        }
    }
    
    public static func toggleBtnAPI(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.ToggleBtn.rawValue, params:param  ) { ( responsedata, statuscode , error) -> (Void) in
            
            if statuscode == 200 {
                
                completionBlock(responsedata,true,nil)
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)) )
                
            }
            
            
        }
    }
    
    public static func AllReviews(param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.AllRating.rawValue, params:param  ) { ( responsedata, statuscode , error) -> (Void) in
            
            if statuscode == 200 {
                
                completionBlock(responsedata,true,nil)
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)) )
                
            }
            
            
        }
    }
    
    public static func reportAbuseAPICall(dishId: Int,completionBlock:@escaping homeCompletionBlock) -> Void {
        let param = ["dish_id" : dishId]
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.reportDish.rawValue, params:param ) { ( responsedata, statuscode , error) -> (Void) in
            
            if statuscode == 200 {
                
                if responsedata != nil && (responsedata!["status"] as! Int) == 0
                {
                    completionBlock(responsedata,false,filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: nil),200)
                    
                }
                else {
                    completionBlock(responsedata,true,nil,200)
                }
                
            }
            else{
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)),statuscode)
                
            }
        }
    }
    
    public static func following_followersCountAPICall(completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.getRequest(baseUrl: ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.followfollowingcount.rawValue, params: nil) { ( responsedata, statuscode , error) -> (Void) in
            
            if statuscode == 200 {
                
                completionBlock(responsedata,true,nil)
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)) )
            }
            
        }
    }
    
    public static func userUpdateAPICall(param:[String:Any], completionBlock:@escaping completionUpdateProfileBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.userUpdate.rawValue, params: param) { ( responsedata, statuscode , error) -> (Void) in
            
            if statuscode == 200 {
                
                completionBlock(responsedata,true,nil, statuscode)
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)), statuscode)
            }
            
        }
    }
    
    public static func followUserAPICall(userId: Int, completionBlock:@escaping completionBlock) -> Void {
        let param = ["following_to" : userId]
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.FollowUser.rawValue, params: param) { ( responsedata, statuscode , error) -> (Void) in
            
            if statuscode == 200 {
                
                completionBlock(responsedata,true,nil)
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)) )
            }
            
        }
    }
    
    public static func unFollowUserAPICall(userId: Int, completionBlock:@escaping completionBlock) -> Void {
        let param = ["un_following_to" : userId]
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.UnFollowUser.rawValue, params: param) { ( responsedata, statuscode , error) -> (Void) in
            
            if statuscode == 200 {
                
                completionBlock(responsedata,true,nil)
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)) )
            }
            
        }
    }
    public static func updateProfilePic(imageData: Data, completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.multiPartPostHTTPRequest(baseUrl: ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.updateProfilePic.rawValue, imageData: imageData, imageName: "image", params: nil, progressBlock: { (progress) -> (Void) in
            ////progress Block
        }) { ( responsedata, statuscode , error) -> (Void) in
            ////Completion Block
            if statuscode == 200 {
                
                completionBlock(responsedata,true,nil)
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)) )
            }
        }
    }
    
    public static func deleteDishAPICall(dishId: Int, completionBlock:@escaping completionBlock) -> Void {
        let param = ["dish_id" : dishId]
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.DeleteDish.rawValue, params: param) { ( responsedata, statuscode , error) -> (Void) in
            
            if statuscode == 200 {
                
                completionBlock(responsedata,true,nil)
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)) )
            }
            
        }
    }
    
    public static func EditDishAPICall(imageData: Data?, param:[String:Any],completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.multiPartPostHTTPRequest(baseUrl: ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.EditDish.rawValue, imageData: imageData, imageName: "dish_image", params: param, progressBlock: { (progress) -> (Void) in
            
        }) {( responsedata, statuscode , error) -> (Void) in
            if statuscode == 200 {
                
                
                completionBlock(responsedata,true,nil)
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)))
                
            }
        }
        
    }
    
    public static func checkUserLimit(params: [String:Any], completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.checkContactLimit.rawValue, params: params) { ( responsedata, statuscode , error) -> (Void) in
            
            if statuscode == 200 {
                
                if responsedata != nil && (responsedata!["status"] as! Int) == 0
                {
                    completionBlock(responsedata,false,filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: nil))
                    
                }
                else {
                    completionBlock(responsedata,true,nil)
                }
                
                //  completionBlock(responsedata,true,nil)
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)) )
            }
            
        }
    }
    
    //    func filterErrorMessageUsingResponseRequestOperation(operation: URLSessionDataTask, error: Error) -> String {
    //        //return error.localizedDescription;
    //        let responseData = (error as NSError).userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] as? Data
    //        var jsonResponse: [AnyHashable: Any]
    //        if responseData {
    //            jsonResponse = try? JSONSerialization.jsonObject(with: responseData, options: []) as? [AnyHashable: Any] ?? [AnyHashable: Any]()
    //        }
    //        let errorCode: Int? = ((error as NSError).userInfo[AFNetworkingOperationFailingURLResponseErrorKey])?.statusCode
    //        if errorCode == 401 {
    //            MBDataBaseHandler.clearAllDataBase()
    //            MBAppInitializer.moveToInitialViewController()
    //            return jsonResponse["message"] as? String ?? ""
    //        }
    //        if errorCode == 0 && jsonResponse && jsonResponse["message"] {
    //            return MBErrorUtility.handlePredefinedErrorCode((error as NSError).code, andMessage: jsonResponse["message"])
    //        }
    //        if errorCode == 0 {
    //            return MBErrorUtility.handlePredefinedErrorCode((error as NSError?)?.code, andMessage: error?.localizedDescription)
    //        }
    //        if jsonResponse {
    //            if !((jsonResponse["message"] == "") && jsonResponse["message"] != nil) {
    //                return jsonResponse["message"]
    //            }
    //            if !((jsonResponse["errors"] == "") && jsonResponse["errors"] != nil) {
    //                return jsonResponse["errors"]
    //            }
    //        }
    //        return MBErrorUtility.handlePredefinedErrorCode(errorCode, andMessage: "Issue with server response. Please contact admin.")
    //
    //}
    
    public static func reportRatingApi(params: [String:Any], completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.reportReview.rawValue, params: params) { ( responsedata, statuscode , error) -> (Void) in
            
            if statuscode == 200 {
                
                completionBlock(responsedata,true,nil)
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)) )
            }
            
        }
    }
    
    public static func getPlannerDataApi(month:Int,year :Int,viewType:String,userId:Int,completionBlock:@escaping homeCompletionBlock) -> Void {
        let BaseUrl  = ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.PlannerData.rawValue + "?month=\(month)" + "&year=\(year)" + "&view_type=\(viewType)" + "&for_user_id=\(userId)"
        //        if(month == -1){
        //
        //            BaseUrl = ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.PlannerData.rawValue
        //        }
        //        else if(month == 13){
        //
        //             BaseUrl = ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.PlannerData.rawValue + "?month=1" + "&year=\(year+1)"
        //        }
        //        else if(month == 0){
        //
        //            BaseUrl = ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.PlannerData.rawValue + "?month=12" + "&year=\(year-1)"
        //        }
        //        else{
        //
        //            BaseUrl = ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.PlannerData.rawValue + "?month=\(month)"
        //        }
        
        HTTPClient.shared?.getRequest(baseUrl: BaseUrl, params: nil) { ( responsedata, statuscode , error) -> (Void) in
            
            if statuscode == 200 {
                
                completionBlock(responsedata,true,nil,statuscode)
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)),statuscode)
            }
            
        }
    }
    public static func setPlannerOptionsApi(params: [String:Any], completionBlock:@escaping homeCompletionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.PlannerOption.rawValue, params: params) { ( responsedata, statuscode , error) -> (Void) in
            
            if statuscode == 200 {
                
                completionBlock(responsedata,true,nil,statuscode)
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)),statuscode)
            }
            
        }
    }
    public static func AddPlanApi(params: [String:Any], completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.AddPlan.rawValue, params: params) { ( responsedata, statuscode , error) -> (Void) in
            
            if statuscode == 200 {
                
                completionBlock(responsedata,true,nil)
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)) )
            }
            
        }
    }
    
    public static func  deletePlanApi(params: [String:Any], completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.DeletePlan.rawValue, params: params) { ( responsedata, statuscode , error) -> (Void) in
            
            if statuscode == 200 {
                
                completionBlock(responsedata,true,nil)
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)) )
            }
            
        }
    }
    public static func  getOtherUserPlansApi(target_user_id: Int, completionBlock:@escaping homeCompletionBlock) -> Void {
        
        let BaseUrl  = ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.UserPlanProfile.rawValue + "?target_user_id=\(target_user_id)"
        
        HTTPClient.shared?.getRequest(baseUrl: BaseUrl, params: nil) { ( responsedata, statuscode , error) -> (Void) in
            
            if statuscode == 200 {
                
                completionBlock(responsedata,true,nil,statuscode)
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)),statuscode )
            }
            
        }
    }
    
    public static func  updateCheckboxStatus(params: [String:Any], completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.UpdateCheckbox.rawValue, params: params) { ( responsedata, statuscode , error) -> (Void) in
            
            if statuscode == 200 {
                
                completionBlock(responsedata,true,nil)
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)) )
            }
            
        }
    }
    public static func  updateUserSetting(params: [String:Any], completionBlock:@escaping completionBlock) -> Void {
        
        HTTPClient.shared?.PostHTTPRequest(baseUrl: ServiceConstant.BaseURL+ServiceConstant.Version+CARequestApiName.UserSetting.rawValue, params: params) { ( responsedata, statuscode , error) -> (Void) in
            
            if statuscode == 200 {
                
                completionBlock(responsedata,true,nil)
                
            }
            else{
                
                completionBlock(nil,false,(filterErrorMessageUsingResponseRequestOperation(response: responsedata, errorcode: statuscode, error: error ?? nil)) )
            }
            
        }
    }
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



//
//  HTTPClient.swift
//  structureCoversionDemo
//
//  Created by Mobikasa on 09/10/17.
//  Copyright © 2017 mobikasa. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

typealias CompletionBlock = (Dictionary<String, Any>?,Int, Error?) -> (Void)
typealias ProgressBlock = (Float) -> (Void)

class HTTPClient : NSObject{
    
    //    func HTTPClient()
    //    {
    //
    //    }
    private override init() {
        super.init()
        
        
    }
    static var shared :HTTPClient? {
        
        if (NetworkReachabilityManager()?.isReachable)! == true {
            
            return HTTPClient()
            
        }
        else{
            
            Alamofire.SessionManager.default.session.getAllTasks { (tasks) in
                tasks.forEach({ (task) in
                    task.cancel()
                })
            }
            
        }
        return nil
    }
    
    func cancellAllOperations()
    {
        Alamofire.SessionManager.default.session.getAllTasks { (tasks) in
            tasks.forEach({ (task) in
                task.cancel()
            })
        }
        
        //        Alamofire.SessionManager.default.session.invalidateAndCancel()
        
    }
    
    func setHTTPRequest(withAPIUrl url: String, withHttpMethod method: HTTPMethod, withParameters params: [String: Any]?) -> URLRequest? {
        
        let headers: [String:String] = setAllAuthenticationKeys()
        
        
        
        var request: URLRequest? = nil
        do {
            request = try URLRequest.init(url: url, method: method, headers: headers)
            request?.timeoutInterval = 60
            if params != nil {
                request?.httpBody = try! JSONSerialization.data(withJSONObject: params!, options: [])
            }
        }
        catch {
            print("****** exception in Http Request ********")
        }
        
        return request
    }
    func getRequest(baseUrl:String, params:[String: Any]?, completionBlock:@escaping CompletionBlock )  {
        
        let request = setHTTPRequest(withAPIUrl: baseUrl, withHttpMethod: .get, withParameters: params)
        Alamofire.request(baseUrl, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (responseData: DataResponse<Any>) in
//        Alamofire.request(request! as URLRequestConvertible).responseJSON { (responseData: DataResponse<Any>) in
            
            print("Request: \(String(describing: responseData.request))")   // original url request
            print("Response: \(String(describing: responseData.response))") // http url response
            print("Result: \(responseData.result)")                         // response serialization result
            switch (responseData.result){
                
            case .success(_):
                
                if let response = responseData.result.value{
                    
                    print("JSON: \(response)") // serialized json response
                    
                    completionBlock(responseData.result.value as? [String : Any] ,(responseData.response?.statusCode) ?? 0,responseData.result.error)
                }
                else
                {
                    completionBlock(responseData.result.value as? [String : Any] ,(responseData.response?.statusCode) ?? 0,responseData.result.error)
                    
                }
                break
            case .failure(let error):
                if (responseData.result.value == nil) {
                    
                     print("errorrCode..........." + "\(error._code)")
                    if error._code == NSURLErrorNotConnectedToInternet || error._code == NSURLErrorTimedOut {
                        if(error._code == -1005){
                           
                        }
                        else{
                              completionBlock(nil ,600 ,responseData.result.error)
                        }
                      
                        
                    }
                    else if responseData.response?.statusCode == 500 {
                        completionBlock(nil ,(responseData.response?.statusCode) ?? 0,"Unable to connect to server. Please try again after sometime." as? Error)
                        
                    }
                    else
                    {
                        completionBlock(nil ,(responseData.response?.statusCode) ?? 0,responseData.result.error)
                    }
                }
                else{
                    completionBlock(responseData.result.value as? [String : Any] ,(responseData.response?.statusCode) ?? 0,responseData.result.error)
                }
                
                break
            }
        }
        
    }
    
    func PostHTTPRequest(baseUrl:String, params:[String:Any], completionBlock:@escaping CompletionBlock) -> Void {
        
//        let request = setHTTPRequest(withAPIUrl: baseUrl, withHttpMethod: .post, withParameters: params)
        Alamofire.request(baseUrl, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (responseData: DataResponse<Any>) in
            
            print("Request: \(String(describing: responseData.request))")   // original url request
            
            print(String.init(data: responseData.data!, encoding: String.Encoding.utf8)!)
            
            print("Response: \(String(describing: responseData.response))") // http url response
            print("Result: \(responseData.result)")
            // response serialization result
            //            print(String(data: (responseData.request?.httpBody)!, encoding: String.Encoding(rawValue: 0)) as Any)
            switch (responseData.result){
                
            case .success(_):
                
                if let response = responseData.result.value{
//                    if let acesstoken = responseData.response?.allHeaderFields["AccessToken"] as? String{
//                        if acesstoken != ""{
//                            AppConstants.SAVE_USER_DEFAULTS(value: acesstoken, key: AppConstants.K_ACCESSTOKEN)
//                        }
//
//                    }
                    print("JSON://////////// \(response)") // serialized json response
                    
                }
                completionBlock(responseData.result.value as? [String : Any] ,(responseData.response?.statusCode) ?? 0,responseData.result.error)
                
                break
            case .failure(let error):
                
                if (responseData.result.value == nil) {
                    
                    if error._code == NSURLErrorNotConnectedToInternet{
                        completionBlock(nil ,600,responseData.result.error)
                        
                    } else if responseData.response?.statusCode == 500 {
                        completionBlock(nil ,500,"Unable to connect to server. Please try again after sometime." as? Error)
                        
                    }
                    else{
                        completionBlock(nil ,(responseData.response?.statusCode) ?? 0,responseData.result.error)
                    }
                }
                else{
                    completionBlock(responseData.result.value as? [String : Any] ,(responseData.response?.statusCode) ?? 0,responseData.result.error)
                }
                break
            }
        }
//        Alamofire.request(request! as URLRequestConvertible).responseJSON { (responseData: DataResponse<Any>) in
//
//            print("Request: \(String(describing: responseData.request))")   // original url request
//
//            print(String.init(data: responseData.data!, encoding: String.Encoding.utf8)!)
//
//            print("Response: \(String(describing: responseData.response))") // http url response
//            print("Result: \(responseData.result)")
//            // response serialization result
//            //            print(String(data: (responseData.request?.httpBody)!, encoding: String.Encoding(rawValue: 0)) as Any)
//            switch (responseData.result){
//
//            case .success(_):
//
//                if let response = responseData.result.value{
//                    if let acesstoken = responseData.response?.allHeaderFields["AccessToken"] as? String{
//                        if acesstoken != ""{
//                            AppConstants.SAVE_USER_DEFAULTS(value: acesstoken, key: AppConstants.K_ACCESSTOKEN)
//                        }
//
//                    }
//                    print("JSON://////////// \(response)") // serialized json response
//
//                }
//                completionBlock(responseData.result.value as? [String : Any] ,(responseData.response?.statusCode) ?? 0,responseData.result.error)
//
//                break
//            case .failure(let error):
//
//                if (responseData.result.value == nil) {
//
//                    if error._code == NSURLErrorNotConnectedToInternet{
//                        completionBlock(nil ,600,responseData.result.error)
//
//                    } else if responseData.response?.statusCode == 500 {
//                        completionBlock(nil ,500,"Unable to connect to server. Please try again after sometime." as? Error)
//
//                    }
//                    else{
//                        completionBlock(nil ,(responseData.response?.statusCode) ?? 0,responseData.result.error)
//                    }
//                }
//                else{
//                    completionBlock(responseData.result.value as? [String : Any] ,(responseData.response?.statusCode) ?? 0,responseData.result.error)
//                }
//                break
//            }
//        }
    }
    
    ///MARK:- Multipart Post Service Call
    func multiPartPostHTTPRequest(baseUrl: String, imageData: Data? , imageName : String?, params:[String:Any]?, progressBlock: @escaping ProgressBlock, completionBlock:@escaping CompletionBlock) -> Void {
        let request = setHTTPRequest(withAPIUrl: baseUrl, withHttpMethod: .post, withParameters: params)
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            
            // Adding ImageData
            if imageData != nil
            {
                multipartFormData.append(imageData!, withName: imageName ?? "image", fileName: "image.jpg", mimeType: "image/jpeg")
            }
            
            // Adding Param Dictionary
            if params != nil
            {
                for (key, value) in params!
                {
                    if value is String || value is Int || value is NSNumber
                    {
                        multipartFormData.append("\(String(describing: value))".data(using: .utf8)!, withName: key)
                    }
                }
            }
        }, with: request! as URLRequestConvertible) { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (Progress) in
                    print("Upload Progress: \(Progress.fractionCompleted)")
                })
                
                upload.responseJSON { responseData in
                    
                    switch responseData.result {
                    case .success:
                        if let response = responseData.result.value{
                            if let acesstoken = responseData.response?.allHeaderFields["AccessToken"] as? String{
                                AppConstants.SAVE_USER_DEFAULTS(value: acesstoken, key: AppConstants.K_ACCESSTOKEN)
                            }
                            print("JSON://////////// \(response)") // serialized json response
                            
                            completionBlock(responseData.result.value as? [String : Any] ,(responseData.response?.statusCode) ?? 0,responseData.result.error)
                            break
                        }
                        
                    case .failure(let error):
                        if (responseData.result.value == nil) {
                            
                            if error._code == NSURLErrorNotConnectedToInternet{
                                completionBlock(nil ,600,responseData.result.error)
                                
                            }
                            else if responseData.response?.statusCode == 500 {
                                completionBlock(nil ,500,"Unable to connect to server. Please try again after sometime." as? Error)
                                
                            }
                            else{
                                completionBlock(nil ,(responseData.response?.statusCode) ?? 0,responseData.result.error)
                            }
                        }
                        else{
                            completionBlock(responseData.result.value as? [String : Any] ,(responseData.response?.statusCode) ?? 0,responseData.result.error)
                        }
                    }
                }
                break
            case .failure(let encodingError):
                completionBlock(nil ,0,encodingError)
            }
        }
        
        
        
        //        Alamofire.upload(multipartFormData:{ multipartFormData in
        //
        //            // Adding ImageData
        //            if imageData != nil
        //            {
        //                multipartFormData.append(imageData!, withName: imageName ?? "image", fileName: "image.jpg", mimeType: "image/jpeg")
        //            }
        //
        //            // Adding Param Dictionary
        //            if params != nil
        //            {
        //                for (key, value) in params!
        //                {
        //                    if value is String || value is Int
        //                    {
        //                        multipartFormData.append("\(String(describing: value))".data(using: .utf8)!, withName: key)
        //                    }
        //                }
        //            }
        //        },
        //                         usingThreshold:UInt64.init(),
        //                         to:baseUrl,
        //                         method:.post,
        //                         headers:headers,
        //                         encodingCompletion: { encodingResult in
        //                            switch encodingResult {
        //                            case .success(let upload, _, _):
        //
        //                                upload.uploadProgress(closure: { (Progress) in
        //                                    print("Upload Progress: \(Progress.fractionCompleted)")
        //                                })
        //
        //                                upload.responseJSON { responseData in
        //
        //                                    switch responseData.result {
        //                                    case .success:
        //                                        if let response = responseData.result.value{
        //                                            if let acesstoken = responseData.response?.allHeaderFields["AccessToken"] as? String{
        //                                                AppConstants.SAVE_USER_DEFAULTS(value: acesstoken, key: AppConstants.K_ACCESSTOKEN)
        //                                            }
        //                                            print("JSON://////////// \(response)") // serialized json response
        //
        //                                            completionBlock(responseData.result.value as? [String : Any] ,(responseData.response?.statusCode) ?? 0,responseData.result.error)
        //                                            break
        //                                        }
        //
        //                                    case .failure(let error):
        //                                        if (responseData.result.value == nil) {
        //
        //                                            if error._code == NSURLErrorNotConnectedToInternet{
        //                                                completionBlock(nil ,600,responseData.result.error)
        //
        //                                            }else{
        //                                            completionBlock(nil ,(responseData.response?.statusCode) ?? 0,responseData.result.error)
        //                                             }
        //                                        }
        //                                        else{
        //                                            completionBlock(responseData.result.value as? [String : Any] ,(responseData.response?.statusCode) ?? 0,responseData.result.error)
        //                                        }
        //                                    }
        //                                }
        //                                break
        //                            case .failure(let encodingError):
        //                                completionBlock(nil ,0,encodingError)
        //                            }
        //        })
    }
    
    func setAllAuthenticationKeys() -> [String:String] {
        
        var headers: [String:String] = [
            "Content-Type": "application/json",
            "Accept" : "application/json"
        ]
        
//        if let appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"]{
//            headers["appVersion"] = appVersion as? String
//        }
//
//        if let authtoken = AppConstants.GET_USER_DEFAULTS(Key: AppConstants.K_ACCESSTOKEN){
//            headers[AppConstants.K_ACCESSTOKEN] = authtoken
//        }
//        if let deviceToken = AppConstants.GET_USER_DEFAULTS(Key: AppConstants.K_DEVICE_TOKEN){
//            headers[AppConstants.K_DEVICE_TOKEN] = deviceToken
//        }
//
//        if let deviceid = AppConstants.GET_USER_DEFAULTS(Key: AppConstants.K_DEVICE_ID){
//            headers[AppConstants.K_DEVICE_ID] = deviceid
//        }
//        else{
//
//            headers[AppConstants.K_DEVICE_ID] = "asfdads43534534534"
//        }
        
        return headers
    }
    
}


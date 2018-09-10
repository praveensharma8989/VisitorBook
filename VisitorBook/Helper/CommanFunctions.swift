//
//  CommanFunctions.swift
//  VisitorBook
//
//  Created by Praveen Sharma on 04/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import Foundation

enum UserType : Int{
    case NoUser = 0
    case Residant
    case GateKeeper
}

class CommanFunction: NSObject {
    
    static var instance = CommanFunction()
    
    func saveUserDataGateKeeper(data: [String : Any]){
        
        let value : Any = data
        
        
        UserDefaults.standard.set(value, forKey: AppConstants.k_gateKeeperUser)
        UserDefaults.standard.synchronize()
        
    }
    
    func getUserDataGateKeeper()-> VisitorUsers?{
        let value = UserDefaults.standard.object(forKey: AppConstants.k_gateKeeperUser)
//        let value = UserDefaults.standard.array(forKey: AppConstants.k_gateKeeperUser)
        
        if value != nil{
            let jsonData = try? JSONSerialization.data(withJSONObject: value!)
            let jsonDecoder = JSONDecoder()
            let userData = try? jsonDecoder.decode(VisitorUsers.self, from: jsonData!)
            
            return userData
        }
        
        return nil
        
    }
    
    func removeGateKeeper(){
        UserDefaults.standard.removeObject(forKey: AppConstants.k_gateKeeperUser)
        UserDefaults.standard.synchronize()
    }
    
    func checkUserType()->UserType{
        
        let userType = UserDefaults.standard.integer(forKey: AppConstants.k_userType)
        
        
        if userType == 2{
            return .GateKeeper
        }else if userType == 1{
            return .Residant
        }else{
            return .NoUser
        }
    
    }
    
    func setUserType(user : UserType){
        
        var value : Int
        
        if user == .GateKeeper{
            value = 2
        }else if user == .Residant{
            value = 1
        }else{
            value = 0
        }
        
        UserDefaults.standard.set(value, forKey: AppConstants.k_userType)
        UserDefaults.standard.synchronize()
    }
    
    func RemoveUserType(){
        
        UserDefaults.standard.removeObject(forKey: AppConstants.k_userType)
        UserDefaults.standard.synchronize()
    }
    
}

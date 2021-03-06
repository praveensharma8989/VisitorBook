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
    case Resident
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
    
    func saveUserDataGateKeeperPassword(data: String){
        
        let value : Any = data
        
        
        UserDefaults.standard.set(value, forKey: AppConstants.k_gateKeeperUserPassword)
        UserDefaults.standard.synchronize()
        
    }
    
    func getUserDataGateKeeperPassword()-> String?{
        let value = UserDefaults.standard.string(forKey: AppConstants.k_gateKeeperUserPassword)
        
        
        
        return value
        
    }
    
    func removeGateKeeperPassword(){
        UserDefaults.standard.removeObject(forKey: AppConstants.k_gateKeeperUserPassword)
        UserDefaults.standard.synchronize()
    }
    
    func clearGateKeeperData(){
        removeGateKeeperPassword()
        RemoveUserType()
        setUserType(user: .NoUser)
        removeGateKeeper()
    }
    
    func clearFlatUserData(){
        removeResident()
        RemoveUserType()
        setUserType(user: .NoUser)
        removeResidentFlatProfile()
        removeResidentDashBoard()
    }
    
    
    func saveUserDataResident(data: [String : Any]){
        
        let value : Any = data
        
        UserDefaults.standard.set(value, forKey: AppConstants.k_residentUser)
        UserDefaults.standard.synchronize()
        
    }
    
    func getUserDataResident()-> ResidentData?{
        let value = UserDefaults.standard.object(forKey: AppConstants.k_residentUser)
        //        let value = UserDefaults.standard.array(forKey: AppConstants.k_gateKeeperUser)
        
        if value != nil{
            let jsonData = try? JSONSerialization.data(withJSONObject: value!)
            let jsonDecoder = JSONDecoder()
            let userData = try? jsonDecoder.decode(ResidentData.self, from: jsonData!)
            
            return userData
        }
        
        return nil
        
    }
    
    func removeResident(){
        UserDefaults.standard.removeObject(forKey: AppConstants.k_residentUser)
        UserDefaults.standard.synchronize()
    }
    
    func saveResidentFlatProfile(data: [String : Any]){
        
        let value : Any = data
        
        UserDefaults.standard.set(value, forKey: AppConstants.k_residentFlatProfile)
        UserDefaults.standard.synchronize()
        
    }
    
    func getResidentFlatProfile()-> FlateProfileData?{
        let value = UserDefaults.standard.object(forKey: AppConstants.k_residentFlatProfile)
        
        if value != nil{
            let jsonData = try? JSONSerialization.data(withJSONObject: value!)
            let jsonDecoder = JSONDecoder()
            let userData = try? jsonDecoder.decode(FlateProfileData.self, from: jsonData!)
            
            return userData
        }
        
        return nil
        
    }
    
    func removeResidentFlatProfile(){
        UserDefaults.standard.removeObject(forKey: AppConstants.k_residentFlatProfile)
        UserDefaults.standard.synchronize()
    }
    
    func saveUserDataResidentDashBoard(data: ResidentDashboardData){
        do{
       // print()
      
            
            let dataToSave = try JSONEncoder().encode(data)
            let encodeData = NSKeyedArchiver.archivedData(withRootObject: dataToSave)
            
            UserDefaults.standard.set(encodeData, forKey: AppConstants.k_residentUserDashboard)
            UserDefaults.standard.synchronize()
            
         
        }
        catch{
            print(error)
        }
        
    }
    
    func getUserDataResidentDashBoard()-> ResidentDashboardData?{
        let value = UserDefaults.standard.object(forKey: AppConstants.k_residentUserDashboard)
        //        let value = UserDefaults.standard.array(forKey: AppConstants.k_gateKeeperUser)
        
        if value != nil{
            do{
                let valueToRetrieve = UserDefaults.standard.value(forKey: AppConstants.k_residentUserDashboard)
                let unArchievedValue = NSKeyedUnarchiver.unarchiveObject(with: valueToRetrieve as! Data)
                let decodedValue = try JSONDecoder().decode(ResidentDashboardData.self, from: unArchievedValue as! Data) as ResidentDashboardData
                //            print(decodedValue)
                return decodedValue
                
            }
            catch{
                print(error)
            }
        }
        
        return nil
        
    }
    
    func removeResidentDashBoard(){
        UserDefaults.standard.removeObject(forKey: AppConstants.k_residentUserDashboard)
        UserDefaults.standard.synchronize()
    }
    
    func checkUserType()->UserType{
        
        let userType = UserDefaults.standard.integer(forKey: AppConstants.k_userType)
        
        
        if userType == 2{
            return .GateKeeper
        }else if userType == 1{
            return .Resident
        }else{
            return .NoUser
        }
    
    }
    
    func setUserType(user : UserType){
        
        var value : Int
        
        if user == .GateKeeper{
            value = 2
        }else if user == .Resident{
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
    
    func getFCMTocken()->String{
        
        if UserDefaults.standard.string(forKey: AppConstants.k_FCMTocken) != nil {
            return UserDefaults.standard.string(forKey: AppConstants.k_FCMTocken)!
        }else{
            return ""
        }
        
    }
    
    func setFCMTocken(user : String){
        
        UserDefaults.standard.set(user, forKey: AppConstants.k_FCMTocken)
        UserDefaults.standard.synchronize()
    }
    
    func RemoveFCMTocken(){
        
        UserDefaults.standard.removeObject(forKey: AppConstants.k_FCMTocken)
        UserDefaults.standard.synchronize()
    }
    
}

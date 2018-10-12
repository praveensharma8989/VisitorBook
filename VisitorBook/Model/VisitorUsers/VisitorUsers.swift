//
//  VisitorUsers.swift
//  VisitorBook
//
//  Created by Praveen on 05/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import Foundation

struct VisitorUsers: Codable {
    let code: Int
    let error: Bool
    let msg, id, cid, name: String?
    let email, mobile, status: String?
}


struct QREntryData: Codable {
    let code: Int
    let error: Bool
    let msg, logintype, id, otp: String?
    let mobile: String?
    
    enum CodingKeys: String, CodingKey {
        case code, error, msg, logintype, id
        case otp = "OTP"
        case mobile
    }
}

struct QRLoginData: Codable {
    let code: Int
    let error: Bool
    let msg, id, cid, uid: String?
    let name, mobile, validTo, tower: String?
    let floor, flat, responseData, pushNotification: String?
    
    enum CodingKeys: String, CodingKey {
        case code, error, msg, id, cid, uid, name, mobile
        case validTo = "valid_to"
        case tower, floor, flat
        case responseData = "Response_Data"
        case pushNotification = "PushNotification"
    }
}

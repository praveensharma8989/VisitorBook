//
//  ResidentInfoData.swift
//  VisitorBook
//
//  Created by Praveen Sharma on 25/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import Foundation

struct ResidentInfoData: Codable {
    let code: Int
    let error: Bool
    let msg: String
    let flatUser: [FlatUser]
    
    enum CodingKeys: String, CodingKey {
        case code, error, msg
        case flatUser = "Flat_User"
    }
}

struct FlatUser: Codable {
    let id, cid: String?
    let usertype: String?
    let name, mobile, email: String?
    let address: String?
    let photo: String?
    let gender: String?
    let age: String?
    let position: String?
    let vehicleNo, stickerNo, maintanance: String?
    let tower: String?
    let floor: String?
    let flat: String?
    
    enum CodingKeys: String, CodingKey {
        case id, cid, usertype, name, mobile, email, address, photo, gender, age, position
        case vehicleNo = "vehicle_no"
        case stickerNo = "sticker_no"
        case maintanance, tower, floor, flat
    }
}

struct RWAInfoData: Codable {
    let code: Int
    let error: Bool
    let msg: String
    let rwaInfo: RWAInfo?
    let rwaReply: [RWAReply]?
    
    enum CodingKeys: String, CodingKey {
        case code, error, msg
        case rwaInfo = "RWA_Info"
        case rwaReply = "RWA_Reply"
    }
}

struct RWAReply: Codable {
    let id, replyFrom, flats, message: String
    let replyDate, status: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case replyFrom = "Reply_From"
        case flats, message
        case replyDate = "reply_date"
        case status
    }
}

struct RWAInfo: Codable {
    let id, cid, usertype, name: String?
    let mobile, email, address: String?
    let photo: String?
    let gender, position, age, vehicleNo: String?
    let stickerNo, maintanance, tower, floor: String?
    let flat: String?
    
    enum CodingKeys: String, CodingKey {
        case id, cid, usertype, name, mobile, email, address, photo, gender, position, age
        case vehicleNo = "vehicle_no"
        case stickerNo = "sticker_no"
        case maintanance, tower, floor, flat
    }
}

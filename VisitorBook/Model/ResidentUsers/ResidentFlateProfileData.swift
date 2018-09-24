//
//  ResidentFlateProfileData.swift
//  VisitorBook
//
//  Created by Praveen Sharma on 25/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import Foundation

struct FlateProfileData: Codable {
    let code: Int
    let error: Bool
    let msg, id, cid, usertype: String
    let name, mobile, email, address: String?
    let photo: String?
    let gender, age, vehicleNo, stickerNo: String?
    let maintanance, tower, floor, flat: String?
    let percentage: Int
    let qrCode: String?
    
    enum CodingKeys: String, CodingKey {
        case code, error, msg, id, cid, usertype, name, mobile, email, address, photo, gender, age
        case vehicleNo = "vehicle_no"
        case stickerNo = "sticker_no"
        case maintanance, tower, floor, flat
        case percentage = "Percentage"
        case qrCode = "QrCode"
    }
}

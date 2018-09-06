//
//  NewVisitorData.swift
//  VisitorBook
//
//  Created by Praveen on 06/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import Foundation

struct NewVisitorData: Codable {
    let code: Int
    let error: Bool
    let msg, id, cid, name: String
    let company, mobile, email, address: String
    let purpose, visitDate, inTime, outTime: String
    let vehicle, photo, tower, floor: String
    let flats, flatOwnerName, flatOwnerMobile, otp: String
    
    enum CodingKeys: String, CodingKey {
        case code, error, msg, id, cid, name, company, mobile, email, address, purpose
        case visitDate = "visit_date"
        case inTime = "in_time"
        case outTime = "out_time"
        case vehicle, photo
        case tower = "Tower"
        case floor = "Floor"
        case flats = "Flats"
        case flatOwnerName = "Flat_Owner_name"
        case flatOwnerMobile = "Flat_Owner_mobile"
        case otp = "OTP"
    }
}

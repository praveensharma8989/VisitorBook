//
//  DailySOSData.swift
//  VisitorBook
//
//  Created by Praveen on 14/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import Foundation

struct DailySOSData: Codable {
    let code: Int
    let error: Bool
    let msg: String
    let sosData: [SosData]
    
    enum CodingKeys: String, CodingKey {
        case code, error, msg
        case sosData = "SOS_DATA"
    }
}

struct SosData: Codable {
    let id: String?
    let name: String?
    let mobile: String?
    let flat: String?
    let sendTime: String?
    let photo: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, mobile, flat
        case sendTime = "send_time"
        case photo
    }
}

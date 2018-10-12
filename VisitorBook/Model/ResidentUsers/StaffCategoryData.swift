//
//  StaffCategoryData.swift
//  VisitorBook
//
//  Created by Praveen Sharma on 08/10/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import Foundation

struct StaffCategoryData: Codable {
    let code: Int
    let error: Bool
    let msg: String
    let category: [CategoryData]
}

struct CategoryData: Codable {
    let id, category: String
}


struct StaffCategoryInfoData: Codable {
    let code: Int
    let error: Bool
    let category, msg: String
    let staffData: [StaffDatum]
    
    enum CodingKeys: String, CodingKey {
        case code, error, category, msg
        case staffData = "Staff_Data"
    }
}

struct StaffDatum: Codable {
    let id, name, mobile, email: String
    let cardNo, status: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, mobile, email
        case cardNo = "card_no"
        case status
    }
}

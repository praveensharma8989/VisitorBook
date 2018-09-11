//
//  PendingVisitData.swift
//  VisitorBook
//
//  Created by Praveen on 10/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import Foundation

struct PendingVisitData: Codable {
    let code: Int
    let error: Bool
    let msg: String
    let pendingVisit: [PendingVisit]
    
    enum CodingKeys: String, CodingKey {
        case code, error, msg
        case pendingVisit = "Pending_Visit"
    }
}

struct PendingVisit: Codable {
    let id, name, email, mobile: String?
    let company, address, meetPurpose, vehicle: String?
    let visitDate, outDate, status, visitorType: String?
    let tower, floor, flats, flatOwnerName: String?
    let flatOwnerMobile: String?
    let photo: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, email, mobile, company, address
        case meetPurpose = "Meet_purpose"
        case vehicle
        case visitDate = "visit_date"
        case outDate = "out_date"
        case status
        case visitorType = "Visitor_Type"
        case tower = "Tower"
        case floor = "Floor"
        case flats = "Flats"
        case flatOwnerName = "Flat_Owner_name"
        case flatOwnerMobile = "Flat_Owner_mobile"
        case photo
    }
}

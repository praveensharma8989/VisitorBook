//
//  VehicleData.swift
//  VisitorBook
//
//  Created by Praveen on 11/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import Foundation

struct VehicleData: Codable {
    let code: Int
    let error: Bool
    let msg: String
    let complain: [Complain]
    
    enum CodingKeys: String, CodingKey {
        case code, error, msg
        case complain = "Complain"
    }
}

struct Complain: Codable {
    let id, name, email, mobile: String
    let company, address, meetPurpose, vehicle: String
    let visitDate, inTime, status, tower: String
    let floor, flats: String
    let photo: String

    
    enum CodingKeys: String, CodingKey {
        case id, name, email, mobile, company, address
        case meetPurpose = "Meet_purpose"
        case vehicle
        case visitDate = "visit_date"
        case inTime = "in_time"
        case status
        case tower = "Tower"
        case floor = "Floor"
        case flats = "Flats"
        case photo
    }
}

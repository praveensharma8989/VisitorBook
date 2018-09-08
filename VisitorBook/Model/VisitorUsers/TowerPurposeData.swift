//
//  TowerPurposeData.swift
//  VisitorBook
//
//  Created by Praveen Sharma on 08/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import Foundation

struct TowerData: Codable {
    let code: Int
    let error: Bool
    let msg: String
    let tower: [Tower]
    
    enum CodingKeys: String, CodingKey {
        case code, error, msg
        case tower = "Tower"
    }
}

struct Tower: Codable {
    let id, towerName, discription, status: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case towerName = "tower_name"
        case discription, status
    }
}


struct FloorData: Codable {
    let code: Int
    let error: Bool
    let msg: String
    let floor: [Floor]
    
    enum CodingKeys: String, CodingKey {
        case code, error, msg
        case floor = "Floor"
    }
}

struct Floor: Codable {
    let id, floor, status: String
}

struct FlateData: Codable {
    let code: Int
    let error: Bool
    let msg: String
    let flat: [Flat]
    
    enum CodingKeys: String, CodingKey {
        case code, error, msg
        case flat = "Flat"
    }
}

struct Flat: Codable {
    let id, flat, name, email: String
    let mobile, status: String
}

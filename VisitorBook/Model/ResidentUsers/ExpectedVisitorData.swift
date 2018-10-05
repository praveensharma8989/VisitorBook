//
//  ExpectedVisitorData.swift
//  VisitorBook
//
//  Created by Praveen Sharma on 04/10/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import Foundation


struct ExpectedVisitorData: Codable {
    let code: Int
    let error: Bool
    let msg: String
    let expectedVisitor: [ExpectedVisitor]
    
    enum CodingKeys: String, CodingKey {
        case code, error, msg
        case expectedVisitor = "Expected_Visitor"
    }
}

struct ExpectedVisitor: Codable {
    let id, name, mobile, purpose: String
    let validTo, noOfVisit: String
    let socityPhoto: String
    let qrCode: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, mobile, purpose
        case validTo = "Valid_to"
        case noOfVisit = "No_of_Visit"
        case socityPhoto = "Socity_photo"
        case qrCode = "QrCode"
    }
}



struct ExpectedVisitorVisitData: Codable {
    let code: Int
    let error: Bool
    let msg: String
    let expectedVisitorVisit: [ExpectedVisitorVisit]
    
    enum CodingKeys: String, CodingKey {
        case code, error, msg
        case expectedVisitorVisit = "ExpectedVisitor"
    }
}

struct ExpectedVisitorVisit: Codable {
    let id: String
    let name: String?
    let email, mobile, company, address: String?
    let meetPurpose, vehicle, visitDate: String?
    let outDate: String?
    let exitStatus: String?
    let status: String?
    let visitorType: String?
    let photo: String?
    let gender, age, vehicleNo, stickerNo: String?
    let sosName1, sosMob1, sosName2, sosMob2: String?
    let sosMsg: String?
    let exitCode: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, email, mobile, company, address
        case meetPurpose = "Meet_purpose"
        case vehicle
        case visitDate = "visit_date"
        case outDate = "out_date"
        case exitStatus = "exit_status"
        case status
        case visitorType = "Visitor_Type"
        case photo, gender, age
        case vehicleNo = "vehicle_no"
        case stickerNo = "sticker_no"
        case sosName1 = "sos_name1"
        case sosMob1 = "sos_mob1"
        case sosName2 = "sos_name2"
        case sosMob2 = "sos_mob2"
        case sosMsg = "sos_msg"
        case exitCode = "exit_code"
    }
}

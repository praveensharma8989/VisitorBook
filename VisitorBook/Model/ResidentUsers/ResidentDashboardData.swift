//
//  ResidentDashboardData.swift
//  VisitorBook
//
//  Created by Praveen on 18/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import Foundation

struct ResidentDashboardData: Codable {
    let code: Int
    let error: Bool
    let msg, today, weekly, total: String?
    let notification, complaint, name, userType: String?
    let maintanance: String?
    let photo: String?
    let bannerData: [BannerDatum]
    let visitorData: [VisitorData]
    
    enum CodingKeys: String, CodingKey {
        case code, error, msg
        case today = "Today"
        case weekly = "Weekly"
        case total = "Total"
        case notification = "Notification"
        case complaint = "Complaint"
        case name
        case userType = "user_type"
        case maintanance, photo
        case bannerData = "Banner_Data"
        case visitorData = "Visitor_Data"
    }
}

struct BannerDatum: Codable {
    let bannerID: String?
    let banner: String?
    
    enum CodingKeys: String, CodingKey {
        case bannerID = "Banner_id"
        case banner = "Banner"
    }
}

struct VisitorData: Codable {
    let id, name, email, mobile: String?
    let company, address, meetPurpose, vehicle: String?
    let visitDate, outDate: String?
    let exitStatus: String?
    let status, visitorType: String?
    let photo: String
    let gender, age, vehicleNo, stickerNo: String?
    let sosName1, sosMob1, sosName2, sosMob2: String?
    let sosMsg: String?
    
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
    }
}

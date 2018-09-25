//
//  NotificationInfoData.swift
//  VisitorBook
//
//  Created by Praveen Sharma on 25/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import Foundation

struct NotificationInfoData: Codable {
    let code: Int
    let error: Bool
    let msg: String
    let notification: [NotificationData]
    
    enum CodingKeys: String, CodingKey {
        case code, error, msg
        case notification = "Notification"
    }
}

struct NotificationData: Codable {
    let id, subject, message: String?
    let status: String?
    let sendDate: String?
    
    enum CodingKeys: String, CodingKey {
        case id, subject, message, status
        case sendDate = "send_date"
    }
}

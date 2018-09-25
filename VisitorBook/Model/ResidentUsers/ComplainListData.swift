//
//  ComplainListData.swift
//  VisitorBook
//
//  Created by Praveen on 25/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import Foundation


struct ComplainListData: Codable {
    let code: Int
    let error: Bool
    let msg: String?
    let complain: [ComplainData]?
    
    enum CodingKeys: String, CodingKey {
        case code, error, msg
        case complain = "Complain"
    }
}

struct ComplainData: Codable {
    let id, cmplid, subject, message: String?
    let rating, feedback, priority, status: String?
    let sendDate, unreadReply: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case cmplid = "CMPLID"
        case subject, message, rating, feedback, priority, status
        case sendDate = "send_date"
        case unreadReply = "UnreadReply"
    }
}

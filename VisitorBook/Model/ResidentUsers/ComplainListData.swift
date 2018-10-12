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

struct CategoryList: Codable {
    let code: Int
    let error: Bool
    let msg: String
    let category: [Category]
    
    enum CodingKeys: String, CodingKey {
        case code, error, msg
        case category = "Category"
    }
}


struct CompaintInfoData: Codable {
    let code: Int
    let error: Bool
    let msg: String
    let complainInfo: ComplainInfo
    let complainReply: [ComplainReply]?
    
    enum CodingKeys: String, CodingKey {
        case code, error, msg
        case complainInfo = "Complain_Info"
        case complainReply = "Complain_Reply"
    }
}

struct ComplainInfo: Codable {
    let id, cmplid, subject, message: String
    let photo: String?
    let rating, feedback, priority, status: String?
    let sendDate: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case cmplid = "CMPLID"
        case subject, message, photo, rating, feedback, priority, status
        case sendDate = "send_date"
    }
}

struct ComplainReply: Codable {
    let id, replyMsg, replyDate: String
    let replyBy: String
    let userType: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case replyMsg = "Reply_Msg"
        case replyDate = "Reply_Date"
        case replyBy = "Reply_By"
        case userType = "UserType"
    }
}


struct Category: Codable {
    let id, category: String
}

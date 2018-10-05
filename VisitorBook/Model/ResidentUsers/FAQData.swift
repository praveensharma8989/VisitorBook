//
//  FAQData.swift
//  VisitorBook
//
//  Created by Praveen Sharma on 04/10/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import Foundation

struct FAQData: Codable {
    let code: Int
    let error: Bool
    let msg: String
    let faq: [FAQ]
    
    enum CodingKeys: String, CodingKey {
        case code, error, msg
        case faq = "FAQ"
    }
}

struct FAQ: Codable {
    let id, question, answer: String
}

struct AboutUsData: Codable {
    let code: Int
    let error: Bool
    let msg, aboutus: String
    
    enum CodingKeys: String, CodingKey {
        case code, error, msg
        case aboutus = "Aboutus"
    }
}

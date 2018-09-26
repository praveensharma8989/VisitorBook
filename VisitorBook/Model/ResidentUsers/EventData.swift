//
//  EventData.swift
//  VisitorBook
//
//  Created by Praveen on 26/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import Foundation

struct EventData: Codable {
    let code: Int
    let error: Bool
    let msg: String
    let eventData: [EventDatum]
    
    enum CodingKeys: String, CodingKey {
        case code, error, msg
        case eventData = "Event_Data"
    }
}

struct EventDatum: Codable {
    let id, eventDate, title, discription: String
    let imageNums: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case eventDate = "event_date"
        case title, discription
        case imageNums = "Image_nums"
    }
}

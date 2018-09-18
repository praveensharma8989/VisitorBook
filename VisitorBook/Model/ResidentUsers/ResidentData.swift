//
//  ResidentData.swift
//  VisitorBook
//
//  Created by Praveen on 18/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import Foundation

struct ResidentData: Codable {
    let code: Int
    let error: Bool
    let msg, id, cid, otp: String
}

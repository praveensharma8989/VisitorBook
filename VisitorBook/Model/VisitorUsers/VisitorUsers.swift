//
//  VisitorUsers.swift
//  VisitorBook
//
//  Created by Praveen on 05/09/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import Foundation

struct VisitorUsers: Codable {
    let code: Int
    let error: Bool
    let msg, id, cid, name: String
    let email, mobile, status, password: String
}

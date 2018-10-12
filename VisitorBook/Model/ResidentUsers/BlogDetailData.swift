//
//  BlogDetailData.swift
//  VisitorBook
//
//  Created by Praveen Sharma on 08/10/18.
//  Copyright © 2018 Praveen Sharma. All rights reserved.
//

import Foundation

struct BlogDetailData: Codable {
    let code: Int
    let error: Bool
    var nums: Int
    let msg: String
    var blogDetails: [BlogDetail]
    
    enum CodingKeys: String, CodingKey {
        case code, error, nums, msg
        case blogDetails = "Blog_Details"
    }
}

struct BlogDetail: Codable {
    let srno: Int
    let id: String
    let usertype: String?
    let name: String?
    let flats: String?
    let postTime: String?
    let photo: String?
    var message, totalLikes, totalComment, currUserLike: String?
    let blogRemove: String?
    let imagesPart: [ImagesPart]?
    
    enum CodingKeys: String, CodingKey {
        case srno, id, usertype, name
        case flats = "Flats"
        case postTime = "post_time"
        case photo, message
        case totalLikes = "Total_Likes"
        case totalComment = "Total_Comment"
        case currUserLike = "Curr_User_Like"
        case blogRemove = "Blog_Remove"
        case imagesPart = "Images_Part"
    }
}

struct ImagesPart: Codable {
    let id: String
    let images: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case images = "Images"
    }
}

struct BlogLikeData: Codable {
    let code: Int
    let error: Bool
    let totalLikes, msg: String
    let blogLikesUser: [BlogLikesUser]
    
    enum CodingKeys: String, CodingKey {
        case code, error
        case totalLikes = "Total_Likes"
        case msg
        case blogLikesUser = "Blog_Likes_User"
    }
}

struct BlogLikesUser: Codable {
    let id, name, usertype, flats: String
    let photo: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, usertype
        case flats = "Flats"
        case photo
    }
}

struct BlogCommentData: Codable {
    let code: Int
    let error: Bool
    let totalComment, msg: String
    let blogCommentDetails: [BlogCommentDetail]
    
    enum CodingKeys: String, CodingKey {
        case code, error
        case totalComment = "Total_Comment"
        case msg
        case blogCommentDetails = "Blog_Comment_Details"
    }
}

struct BlogCommentDetail: Codable {
    let id, name, usertype, flats: String
    let photo: String
    let comment: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, usertype
        case flats = "Flats"
        case photo
        case comment = "Comment"
    }
}


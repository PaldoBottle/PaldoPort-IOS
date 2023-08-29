//
//  User.swift
//  PaldoPort
//
//  Created by seonwoo on 2023/08/11.
//

// 예시를 넣어둔거임

import Foundation

struct UserData: Codable {
    var user: [User]?
    
    enum CodingKeys: String, CodingKey {
        case user
    }
}

struct User : Codable {
    var nickname: String?
    var profileImage: String?
    var introduce: String?
    var gender: String?
    var birth: String?
    var phone: String?
    var name: String?
    var isActive: String?
    var isFollowed: Bool?
    var isBlocked: Bool?
    var following: String?
    var follower: String?
    var postCount: String?
    
    enum CodingKeys: String, CodingKey {
        case nickname = "nick"
        case profileImage = "profile_img"
        case introduce
        case gender = "sex"
        case birth
        case phone
        case name = "nm"
        case isActive = "act_yn"
        case isFollowed = "follow"
        case isBlocked = "block"
        case following = "following_cnt"
        case follower = "follower_cnt"
        case postCount = "post_cnt"
    }
}

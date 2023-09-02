//
//  User.swift
//  PaldoPort
//
//  Created by seonwoo on 2023/08/11.
//

// 예시를 넣어둔거임

import Foundation

struct User: Codable {
    var id : String
    var point : Int
    var profileImg : String
    
    enum CodingKeys: String, CodingKey {
        case id
        case point
        case profileImg
    }
}

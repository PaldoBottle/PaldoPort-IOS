//
//  BaseResponse.swift
//  PaldoPort
//
//  Created by seonwoo on 2023/08/11.
//


// 리팩토링 할때 사용하려고

import Foundation

struct BaseResponse<T: Codable>: Codable {
    let message: String?
    let status: Int?
    let data: T?
    
    // CodingKey는 json에서 예를 들어 msg 이런 형식으로 왔으면 msg를
    // message로 연결할 수 있게 도와주는 프로토콜
    enum CodingKeys: String, CodingKey {
        case message
        case status
        case data
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decode(Int.self, forKey: .status)
        message = try values.decode(String.self, forKey: .message)
        data = try values.decode(T.self, forKey: .data)
    }
}

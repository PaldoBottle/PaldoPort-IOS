//
//  LoginParam.swift
//  PaldoPort
//
//  Created by seonwoo on 2023/09/06.
//

import Foundation

struct LoginParam : Codable{
    var accessToken : String
    var memberInfo : User
}

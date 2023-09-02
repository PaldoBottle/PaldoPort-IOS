//
//  Stamp.swift
//  PaldoPort
//
//  Created by seonwoo on 2023/09/03.
//

import Foundation

struct Stamp: Codable {
    var name : String
    var supDistrict : String
    var district : String
    var have : Bool
}

struct StampDetail: Codable {
    var point : Int
    var publishDate : String?
    var publishNumber : Int?
    var description : String?
}

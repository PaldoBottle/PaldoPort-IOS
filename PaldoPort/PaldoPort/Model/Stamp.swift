//
//  Stamp.swift
//  PaldoPort
//
//  Created by seonwoo on 2023/09/03.
//

import Foundation

struct Stamp: Codable {
    var supDistrict : String
    var district : String
    var have : Bool
    var imageUrl : String
}

struct StampDetail: Codable {
    var publishDate : String?
    var publishNumber : Int?
    var point : Int?
    var imageUrl : String
}

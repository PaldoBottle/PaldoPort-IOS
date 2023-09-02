//
//  Region.swift
//  PaldoPort
//
//  Created by seonwoo on 2023/09/03.
//

import Foundation

struct RegionData: Codable{
    var description : String
}

struct Region {
    var district : String
    var supDistrict : String
    var description : String
}

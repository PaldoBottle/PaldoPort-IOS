//
//  Annotation.swift
//  PaldoPort
//
//  Created by seonwoo on 2023/08/02.
//

import Foundation


struct Annotation : Codable{
    // 위도
    var latitude : Double
    // 경도
    var longitude : Double
    var supDistrict : String
    var district : String
    var name : String
    
}

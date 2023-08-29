//
//  Annotation.swift
//  PaldoPort
//
//  Created by seonwoo on 2023/08/02.
//

import Foundation


struct Annotation : Decodable{
    var id : Int
    
    // 위도
    var latitude : Double
    // 경도
    var longitude : Double
    
    var locationName : String
    
}

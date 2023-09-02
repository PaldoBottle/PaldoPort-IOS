//
//  Challenge.swift
//  PaldoPort
//
//  Created by seonwoo on 2023/09/03.
//

import Foundation

struct Challenge: Codable {
    var name : String
    var description : String
    var point : Int
    var isAchieved : Bool?
}

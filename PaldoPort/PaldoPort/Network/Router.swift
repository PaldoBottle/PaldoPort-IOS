//
//  Router.swift
//  PaldoPort
//
//  Created by seonwoo on 2023/08/11.
//


// 리팩토링 할때 사용하려고

import Foundation
import Alamofire

public protocol Router {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var parameters: [String: Any]? { get }
    var encoding: ParameterEncoding? { get }
}

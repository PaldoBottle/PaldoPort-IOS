//
//  LoginAPI.swift
//  PaldoPort
//
//  Created by seonwoo on 2023/08/11.
//

import Foundation
import RxSwift
import Alamofire

struct LoginAPI {
    static func loginWithSocial(token : String)->Observable<User>{
        return Observable.create{ observer -> Disposable in
            
            let url = ""
            let headers : HTTPHeaders = ["Content-Type" : "application/json"]
            let params: Parameters = ["token" : token]
            
            let request = AF.request(url,
                                     method: .post,
                                     parameters: params,
                                     encoding: JSONEncoding.default,
                                     headers: headers)
            
            request.responseDecodable(of: User.self){ response in
                switch response.result {
                case .success(let data):
                    observer.onNext(data)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
}

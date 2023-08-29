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
    static func loginWithKaKao(token : String)->Observable<User>{
        return Observable.create{ observer -> Disposable in
            
            let url = ""
            let headers : HTTPHeaders = ["Content-Type" : "application/json"]
            let params: Parameters = ["token" : token]
            
            let request = AF.request(url,
                                     method: .post,
                                     parameters: params,
                                     encoding: JSONEncoding.default,
                                     headers: headers)
            
            request.responseData(completionHandler: { (response) in
                        switch response.result{
                        case .success:
                            guard let statusCode = response.response?.statusCode else {
                                return
                            }
                            
                            switch statusCode {
                            case 200:
                                guard let data = response.value else {
                                    return
                                }
                                let decoder = JSONDecoder()
                                guard let decodedData = try? decoder.decode(BaseResponse<User>.self, from: data) else {
                                    return}
                                observer.onNext(decodedData.data!)
                                observer.onCompleted()
                            default:
                                print("예외처리")
                            }
                        case .failure(let error):
                            print(error)
                            observer.onError(error)
                        }
                    })
            
            return Disposables.create()
        }
    }
    
    static func loginWithGoogle(token : String)->Observable<User>{
        return Observable.create{ observer -> Disposable in
            
            let url = ""
            let headers : HTTPHeaders = ["Content-Type" : "application/json"]
            let params: Parameters = ["token" : token]
            
            let request = AF.request(url,
                                     method: .post,
                                     parameters: params,
                                     encoding: JSONEncoding.default,
                                     headers: headers)
            
            request.responseData(completionHandler: { (response) in
                        switch response.result{
                        case .success:
                            guard let statusCode = response.response?.statusCode else {
                                return
                            }
                            
                            switch statusCode {
                            case 200:
                                guard let data = response.value else {
                                    return
                                }
                                let decoder = JSONDecoder()
                                guard let decodedData = try? decoder.decode(BaseResponse<User>.self, from: data) else {
                                    return}
                                observer.onNext(decodedData.data!)
                                observer.onCompleted()
                            default:
                                print("예외처리")
                            }
                        case .failure(let error):
                            print(error)
                            observer.onError(error)
                        }
                    })
            
            return Disposables.create()
        }
    }
    
    
    static func logout()->Observable<Bool>{
        return Observable.create{ observer -> Disposable in
            
            let url = ""
            let headers : HTTPHeaders = ["Content-Type" : "application/json"]
            
            let request = AF.request(url,
                                     method: .post,
                                     encoding: JSONEncoding.default,
                                     headers: headers)
            
            request.responseData(completionHandler: { (response) in
                        switch response.result{
                        case .success:
                            guard let statusCode = response.response?.statusCode else {
                                return
                            }
                            
                            switch statusCode {
                            case 200:
                                guard let data = response.value else {
                                    return
                                }
                                let decoder = JSONDecoder()
                                guard let decodedData = try? decoder.decode(BaseResponse<Bool>.self, from: data) else {
                                    return}
                                observer.onNext(decodedData.data!)
                                observer.onCompleted()
                            default:
                                print("예외처리")
                            }
                        case .failure(let error):
                            print(error)
                            observer.onError(error)
                        }
                    })
            
            return Disposables.create()
        }
    }
    
    

}

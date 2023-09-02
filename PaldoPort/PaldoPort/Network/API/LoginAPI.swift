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
    static let shared = LoginAPI()
    
    func loginWithKaKao(token : String)->Observable<User>{
        return Observable.create{ observer -> Disposable in
            
            let url = APIConstants.loginWithKakao
            let headers : HTTPHeaders = ["Content-Type" : "application/json"]
            let params: Parameters = ["Authorization_code" : token]
            
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
                                guard let decodedData = try? decoder.decode(User.self, from: data) else {
                                    return}
                                observer.onNext(decodedData)
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
    
    func loginWithGoogle(token : String)->Observable<User>{
        return Observable.create{ observer -> Disposable in
            
            let url = APIConstants.loginWithGoogle
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
    
    
    func logout()->Observable<Bool>{
        return Observable.create{ observer -> Disposable in
            
            let url = APIConstants.logout
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
    
    func getUser()->Observable<User>{
       
       return Observable.create{ observer -> Disposable in
           
           let url = APIConstants.getUser
           let headers : HTTPHeaders = ["Content-Type" : "application/json"]
           let params: Parameters = ["authToken" : KeyChain().read(key: "token")]
           
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
                               guard let decodedData = try? decoder.decode(User.self, from: data) else {
                                   return}
                               observer.onNext(decodedData)
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

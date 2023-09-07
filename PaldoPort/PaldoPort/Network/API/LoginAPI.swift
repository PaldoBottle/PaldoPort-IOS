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
    
    func loginWithKaKao(token : String , completion: @escaping (NetworkResult<Any>)->Void){
            
            let url = APIConstants.loginWithKakao
            print(token)
            let headers : HTTPHeaders = ["Content-Type" : "application/json", "Authorization_code" : token]
            
            let request = AF.request(url,
                                     method: .get,
                                     headers: headers)
            
            request.responseData(completionHandler: { (response) in
                        switch response.result{
                        case .success:
                            guard let statusCode = response.response?.statusCode else {
                                return
                            }
                            print(statusCode)
                            switch statusCode {
                            case 200, 201:
                                guard let data = response.value else {
                                    return
                                }
                                let decoder = JSONDecoder()
                                guard let decodedData = try? decoder.decode(LoginParam.self, from: data) else {
                                    return}
                                completion(.success(decodedData))
                            default:
                                print("예외처리")
                            }
                        case .failure(let error):
                            print(error)
                            completion(.networkFail)
                        }
                    })
    }
    
    func loginWithGoogle(token : String , completion: @escaping (NetworkResult<Any>)->Void){
            
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
                                completion(.success(decodedData.data!))
                            default:
                                print("예외처리")
                            }
                        case .failure(let error):
                            print(error)
                            completion(.networkFail)
                        }
                    })
    }
    
    
    func logout(completion: @escaping (NetworkResult<Any>) -> Void){
            
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
                                completion(.success(decodedData.data!))
                            default:
                                print("예외처리")
                            }
                        case .failure(let error):
                            print(error)
                            completion(.networkFail)
                        }
                    })
    }
    
    func getUser(completion: @escaping (NetworkResult<Any>) -> Void){
                  
           let url = APIConstants.getUser
           let headers : HTTPHeaders = ["Content-Type" : "application/json"]
           let params: Parameters = ["authToken" : "Bearer " + KeyChain().read(key: "token")!]

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
                           print(statusCode)
                           switch statusCode {
                           case 200:
                               guard let data = response.value else {
                                   return
                               }
                               let decoder = JSONDecoder()
                               guard let decodedData = try? decoder.decode(User.self, from: data) else {
                                   return}
                               completion(.success(decodedData))
                           default:
                               print("예외처리")
                           }
                       case .failure(let error):
                           print(error)
                           completion(.networkFail)
                       }
                   })
           
   }
    
    

}

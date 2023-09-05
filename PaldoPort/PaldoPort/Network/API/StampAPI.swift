//
//  StampAPI.swift
//  PaldoPort
//
//  Created by seonwoo on 2023/09/02.
//

import Foundation
import RxSwift
import Alamofire

struct StampAPI{
    static let shared = StampAPI()
    
    func getAllStamp(completion: @escaping (NetworkResult<Any>) -> Void){
       
           let url = APIConstants.getAllStamp
           let headers : HTTPHeaders = ["Content-Type" : "application/json"]
           let params: Parameters = ["authToken" : "cGFsZG9fbWFzdGVyYWNjb3VudA=="]
           
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
                               guard let decodedData = try? decoder.decode([Stamp].self, from: data) else {
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
    
    
    
    func issueStamp(supDistrict : String, district : String, completion: @escaping (NetworkResult<Any>)->Void){
            let url = APIConstants.issueStamp
            let headers : HTTPHeaders = ["Content-Type" : "application/json"]
            let params: Parameters = ["supDistrict" : supDistrict , "district" : district, "authToken" : "cGFsZG9fbWFzdGVyYWNjb3VudA=="]
            
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
                                guard let decodedData = try? decoder.decode(StampDetail.self, from: data) else {
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
    
    func getStampDetail(supDistrict : String, district : String,completion: @escaping (NetworkResult<Any>)->Void){
        
            let url = APIConstants.getStampDetail + "/\(supDistrict)/\(district)/detail"
            let headers : HTTPHeaders = ["Content-Type" : "application/json"]
            
            let request = AF.request(url,
                                     method: .get,
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
                                guard let decodedData = try? decoder.decode(StampDetail.self, from: data) else {
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

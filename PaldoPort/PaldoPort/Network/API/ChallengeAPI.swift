
import Foundation
import RxSwift
import Alamofire

struct ChallengeAPI{
    static let shared = ChallengeAPI()
    
    func getAchievedChallenge()->Observable<[Challenge]>{
       
       return Observable.create{ observer -> Disposable in
           
           let url = APIConstants.getAchievedChallenge
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
                               guard let decodedData = try? decoder.decode([Challenge].self, from: data) else {
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
    
    
    func getAllChallengeList()->Observable<[Challenge]>{
       
       return Observable.create{ observer -> Disposable in
           
           let url = APIConstants.getAllChallengeList
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
                               guard let decodedData = try? decoder.decode([Challenge].self, from: data) else {
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

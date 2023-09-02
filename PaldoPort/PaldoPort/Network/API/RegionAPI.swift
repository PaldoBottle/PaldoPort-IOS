
import Foundation
import RxSwift
import Alamofire

struct RegionAPI{
    static let shared = RegionAPI()
    
    func getAllAnnotation()->Observable<[Annotation]>{
       
       return Observable.create{ observer -> Disposable in
           
           let url = APIConstants.getAllAnnotation
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
                               guard let decodedData = try? decoder.decode([Annotation].self, from: data) else {
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

    
     func getRegionDetail(supDistrict : String, district : String)->Observable<Region>{
        
        return Observable.create{ observer -> Disposable in
            
            let url = APIConstants.getRegion + "/\(supDistrict)/\(district)/detail"
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
                                guard let decodedData = try? decoder.decode(RegionData.self, from: data) else {
                                    return}
                                var region : Region = Region(district: district, supDistrict: supDistrict, description: decodedData.description)
                                observer.onNext(region)
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


import Foundation
import RxSwift
import Alamofire

struct RegionAPI{
    static let shared = RegionAPI()
    
    func getAllAnnotation(completion: @escaping (NetworkResult<Any>) -> Void){
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
                               completion(.success(decodedData))
                           default:
                               completion(.networkFail)
                           }
                       case .failure(let error):
                           print(error)
                           completion(.networkFail)
                       }
                   })
       
   }

    
     func getRegionDetail(supDistrict : String, district : String, completion: @escaping (NetworkResult<Region>)->Void){
        
            var url = APIConstants.getRegion + "/\(supDistrict)/\(district)/detail"
            let urlEncoding = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

            let headers : HTTPHeaders = ["Content-Type" : "application/json"]
            
            let request = AF.request(urlEncoding,
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
                                completion(.success(region))
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

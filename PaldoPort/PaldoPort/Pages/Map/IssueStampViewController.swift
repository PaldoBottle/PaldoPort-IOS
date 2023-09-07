//
//  IssueStampViewController.swift
//  PaldoPort
//
//  Created by seonwoo on 2023/08/30.
//

import Foundation
import UIKit
import CoreLocation

class IssueStampViewController : UIViewController{
    
    var supDistrict : String = ""
    var district : String = ""
    var name : String = ""
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var landMarkName: UITextField!
    @IBOutlet weak var des: UITextView!
    @IBOutlet weak var districtName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        landMarkName.text = name
        districtName.text = supDistrict + " " + district
        getRegionDetail()
        getCurrentLocation()
    }
    
    
    @IBAction func onTapIssueStamp(_ sender: Any) {
        
        if(supDistrict == "서울시"){
            LoadingIndicator.showLoading()
            
            StampAPI.shared.issueStamp(supDistrict: supDistrict, district: district){
                (networkResult) in
                switch networkResult{
                case .success(let data):
                    let stampDetail : StampDetail = data as! StampDetail
                    if let getStampViewController = self.storyboard?.instantiateViewController(withIdentifier: "GetStampViewController") as? GetStampViewController{
                        getStampViewController.districtStr = self.supDistrict+" "+self.district
                        getStampViewController.nameStr = self.name
                        getStampViewController.order = stampDetail.publishNumber!
                        getStampViewController.imageURL = stampDetail.imageUrl
                        
                        self.present(getStampViewController, animated: true, completion: nil)
                    }

                case .requestErr(let msg):
                if let message = msg as? String {
                    print(message)
                }
                case .pathErr:
                    print("pathErr in getRegionDetail")
                case .serverErr:
                    print("serverErr in getRegionDetail")
                case .networkFail:
                    print("networkFail in getRegionDetail")
                }
                LoadingIndicator.hideLoading()
            }
        }else{
            self.showAlert()
        }
        

    }
    
    func getCurrentLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func getRegionDetail(){
        RegionAPI.shared.getRegionDetail(supDistrict: self.supDistrict, district: self.district){
            (networkResult) in
                switch networkResult{
                case .success(let data):
                    let region : Region = data
                    print(region)
                    DispatchQueue.main.async {
                        self.des.text = region.description
                    }

                case .requestErr(let msg):
                if let message = msg as? String {
                    print(message)
                }
                case .pathErr:
                    print("pathErr in getRegionDetail")
                case .serverErr:
                    print("serverErr in getRegionDetail")
                case .networkFail:
                    print("networkFail in getRegionDetail")
                }
        }
    }
    
}

extension IssueStampViewController : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           guard let userLocation = locations.first else {
               return
           }

           // 위치 정보에서 구역 정보 가져오기
           let geocoder = CLGeocoder()
           geocoder.reverseGeocodeLocation(userLocation) { (placemarks, error) in
               if let error = error {
                   print("위치 정보를 가져오는 데 실패했습니다: \(error.localizedDescription)")
                   return
               }

               if let placemark = placemarks?.first {
//                   if let administrativeArea = placemark.administrativeArea{
//                       print("현재 도시 : \(administrativeArea)")
//                   }
                   if let locality = placemark.locality {
                       print("현재 구역: \(locality)")
                   }
                   if let locality = placemark.subLocality {
                       print("현재 구역: \(locality)")
                   }
                   
               }
           }

           // 위치 정보 업데이트 중지
           locationManager.stopUpdatingLocation()
       }

       func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
           print("위치 정보를 가져오는 데 실패했습니다: \(error.localizedDescription)")
       }
    
        func showAlert(){
          let alert = UIAlertController(title: "랜드마크를 방문해서 스탬프를 얻어보세요!", message: "해당 랜드마크가 있는 지역으로 가면 스탬프를 발급할 수 있어요.", preferredStyle: .alert )
          let confirm = UIAlertAction(title: "확인", style: .default, handler: nil)
          
          alert.addAction(confirm)
          
          present(alert, animated: true, completion: nil)
      }
}

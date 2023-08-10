//
//  ViewController.swift
//  PaldoPort
//
//  Created by seonwoo on 2023/08/02.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    @IBOutlet weak var pardoPortLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    var locationManager: CLLocationManager!
    
    let viewModel = MapViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.sendSubviewToBack(mapView)
        view.bringSubviewToFront(pardoPortLabel)

        getUserLocationInfo()
        mapInit()
        annotationInit()
    }
    
    
    @IBAction func onTapMenuButton(_ sender: Any) {
        let menuModal = MenuModalViewController()
        present(menuModal, animated: true, completion: nil)
    }
    
    
    func getUserLocationInfo(){
        // user location 정보 받아오기
        locationManager = CLLocationManager()
        locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
    }

    func mapInit(){
        // 기본지도
        mapView.preferredConfiguration = MKStandardMapConfiguration()
        
        mapView.mapType = MKMapType.standard
        
        // 줌 가능 여부
        mapView.isZoomEnabled = true
        // 이동 가능 여부
        mapView.isScrollEnabled = true
        // 회전 가능 여부
        mapView.isRotateEnabled = true
        // 나침판 표시 여부
        mapView.showsCompass = true
        // 위치 사용 시 사용자의 현재 위치를 표시
        mapView.showsUserLocation = true
        
        mapView.setUserTrackingMode(.follow, animated: true)
        
    }
    
    func annotationInit(){
        
        for annotation in viewModel.annotations {
            let pin = MKPointAnnotation()
        
            pin.coordinate = CLLocationCoordinate2D(latitude: annotation.latitude, longitude: annotation.longitude)
            pin.title = annotation.locationName
            mapView.addAnnotation(pin)
        }
    }

}

extension MapViewController: CLLocationManagerDelegate {
    
    func getLocationUsagePermission() {
        //location4
        self.locationManager.requestWhenInUseAuthorization()

    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        //location5
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            print("GPS 권한 설정됨")
        case .restricted, .notDetermined:
            print("GPS 권한 설정되지 않음")
            getLocationUsagePermission()
        case .denied:
            print("GPS 권한 요청 거부됨")
            getLocationUsagePermission()
        default:
            print("GPS: Default")
        }
    }
}

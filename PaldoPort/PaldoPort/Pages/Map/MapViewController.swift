//
//  ViewController.swift
//  PaldoPort
//
//  Created by seonwoo on 2023/08/02.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var pardoPortLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    var locationManager: CLLocationManager!
    
    var annotations : [Annotation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        view.sendSubviewToBack(mapView)
        view.bringSubviewToFront(pardoPortLabel)
        
        getAnnotation()
        getUserLocationInfo()
        mapInit()
    }
    
    
    @IBAction func onTapMenuButton(_ sender: Any) {
        let menuModal = MenuModalViewController()
        menuModal.gotoStampPage = {
            self.goToStampPage()
        }
        menuModal.gotoChallengePage = {
            self.gotoChallengePage()
        }
        present(menuModal, animated: true)
        
    }
    
    func gotoChallengePage(){
        let viewContoller = UIStoryboard(name: "Challenge", bundle: nil).instantiateViewController(withIdentifier: "ChallengeViewController")
        
        self.navigationController?.pushViewController(viewContoller, animated: true)
    }
    
    func goToStampPage(){
        let viewContoller = UIStoryboard(name: "MyStamp", bundle: nil).instantiateViewController(withIdentifier: "MyStampViewController")
        
        self.navigationController?.pushViewController(viewContoller, animated: true)
    }
    
    func getAnnotation(){
        RegionAPI.shared.getAllAnnotation{
            (networkResult) in
                            switch networkResult{
                            case .success(let data):
                                DispatchQueue.main.async {
                                    self.annotations = data as! [Annotation]
                                    self.annotationInit()
                                    self.registerAnnotationView()
                                }
                            case .requestErr(let msg):
                                if let message = msg as? String {
                                    print(message)
                                }
                            case .pathErr:
                                print("pathErr in getAnnotationAPI")
                            case .serverErr:
                                print("serverErr in getAnnotationAPI")
                            case .networkFail:
                                print("networkFail in getAnnotationAPI")
                            }
        }
    }
    
    func onTapAnnotation(supDistrict : String, district : String, name : String){
        if let issueStampViewController = self.storyboard?.instantiateViewController(withIdentifier: "IssueStampViewController") as? IssueStampViewController{
            issueStampViewController.district = district
            issueStampViewController.supDistrict = supDistrict
            issueStampViewController.name = name
            present(issueStampViewController, animated: true, completion: nil)
        }
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
        
        for annotation in annotations {
            let pin = MKPointAnnotation()
            
            pin.coordinate = CLLocationCoordinate2D(latitude: annotation.latitude, longitude: annotation.longitude)
            pin.title = annotation.name
            pin.subtitle = annotation.supDistrict + " " + annotation.district
            mapView.addAnnotation(pin)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {
            return nil
        }

        let identifier = "custom"
        var annotationView : MKMarkerAnnotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)

        annotationView.markerTintColor = UIColor.mainColor
        annotationView.glyphImage = UIImage(systemName : "train.side.front.car")
        
        return annotationView

    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let annotation = view.annotation
        let subTitle : String = annotation?.subtitle! ?? ""
        let separatedArray = subTitle.components(separatedBy: " ")

        let supDistrict : String = separatedArray[0]
        let district : String = separatedArray[1]
        let name : String = annotation?.title! ?? ""
        
        
        onTapAnnotation(supDistrict: supDistrict, district: district, name: name )
    }
    
    func pushStampPage(){
        guard let viewController = UIStoryboard(name: "MyStamp", bundle: nil).instantiateViewController(identifier: "MyStampViewController") as? MyStampViewController else {return}
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func registerAnnotationView(){
        mapView.register(ClusterAnnotationView.self
                         , forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)
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

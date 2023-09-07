//
//  StampDetailViewController.swift
//  PaldoPort
//
//  Created by seonwoo on 2023/09/06.
//

import Foundation
import UIKit

class StampDetailViewController: UIViewController {
    var supDistrict : String = ""
    var district : String = ""
    var imageUrl : String = ""
    
    @IBOutlet weak var districtTitle: UILabel!
    @IBOutlet weak var supDistrictTitle: UILabel!
    @IBOutlet weak var imageVIew: UIImageView!
    @IBOutlet weak var pointTitle: UILabel!
    @IBOutlet weak var orderTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: imageUrl)
        imageVIew.kf.setImage(with:url)
        
        supDistrictTitle.text = supDistrict
        districtTitle.text = district
        imageVIew.layer.cornerRadius = imageVIew.frame.width/2
        imageVIew.clipsToBounds = true
        
        getStampDetail()
    }
    
    
    func getStampDetail(){
        StampAPI.shared.getStampDetail(supDistrict: self.supDistrict, district: self.district){
            (networkResult) in
                switch networkResult{
                case .success(let data):
                    let stamp : StampDetail = data as! StampDetail
                    DispatchQueue.main.async {
                        self.pointTitle.text = "\(stamp.point!) 포인트"
                        self.orderTitle.text = "\(stamp.publishNumber ?? 0)번째로 발급하였습니다."
                    }

                case .requestErr(let msg):
                if let message = msg as? String {
                    print(message)
                }
                case .pathErr:
                    print("pathErr in getStampDetail")
                case .serverErr:
                    print("serverErr in getStampDetail")
                case .networkFail:
                    print("networkFail in getStampDetail")
                }
        }
    }

}

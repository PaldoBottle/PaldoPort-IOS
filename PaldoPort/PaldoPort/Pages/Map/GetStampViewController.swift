//
//  GetStampViewController.swift
//  PaldoPort
//
//  Created by seonwoo on 2023/09/05.
//

import Foundation
import UIKit
import Kingfisher

class GetStampViewController : UIViewController{
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var district: UILabel!
    @IBOutlet weak var orderGetString: UILabel!
    
    var nameStr : String = ""
    var districtStr : String = ""
    var imageURL : String = ""
    var order : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.text = nameStr
        district.text = districtStr
        orderGetString.text = "\(order)번째로 발급하였습니다."
        
        let url = URL(string: imageURL)
        imageView.kf.setImage(with:url)
        imageView.layer.cornerRadius = imageView.frame.height/2
        imageView.clipsToBounds = true
        
        getUser()
    }
    
    
    @IBAction func onTapConfirm(_ sender: Any) {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true)
    }
    
    func getUser(){
        LoginAPI.shared.getUser{
            (networkResult) in
            switch networkResult{
            case .success(let data):
                let user : User = data as! User
                UserManager.shared.setUser(user)
            case .requestErr(let msg):
                if let message = msg as? String {
                    print(message)
                }
            case .pathErr:
                print("pathErr in getUser")
            case .serverErr:
                print("serverErr in getUser")
            case .networkFail:
                print("networkFail in getUser")
            }
        }
        
    }
}

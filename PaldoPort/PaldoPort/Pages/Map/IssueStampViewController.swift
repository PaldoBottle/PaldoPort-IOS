//
//  IssueStampViewController.swift
//  PaldoPort
//
//  Created by seonwoo on 2023/08/30.
//

import Foundation
import UIKit

class IssueStampViewController : UIViewController{
    
    var supDistrict : String = ""
    var district : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func onTapIssueStamp(_ sender: Any) {
        StampAPI.shared.issueStamp(supDistrict: "", district: "")
    }
    
}

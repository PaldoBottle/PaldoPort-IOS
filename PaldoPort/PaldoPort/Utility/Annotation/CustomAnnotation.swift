//
//  CustomAnnotation.swift
//  PaldoPort
//
//  Created by seonwoo on 2023/08/29.
//

import Foundation
import MapKit

class CustomAnnotation: NSObject, MKAnnotation {

    // This property must be key-value observable, which the `@objc dynamic` attributes provide.
    @objc dynamic var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(title: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
    }
}

//
//  MapViewModel.swift
//  PaldoPort
//
//  Created by seonwoo on 2023/08/02.
//

import Foundation

class MapViewModel{
    
    var annotations : [Annotation] = []
    
    init(){
        annotations = [
            Annotation(id: 1, latitude: 37.57861, longitude: 126.97722, supDistrict: "서울", district : "경복궁"),
            Annotation(id: 2, latitude: 37.570013917406, longitude: 126.9780542555, supDistrict: "서울", district : "광화문"),
            Annotation(id: 0, latitude: 37.567191, longitude: 127.010490, supDistrict: "서울", district: "DDP"),
        ]
    }
    
    
}


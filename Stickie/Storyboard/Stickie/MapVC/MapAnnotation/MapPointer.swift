//
// Created by CiaoLee on 2017. 12. 4..
// Copyright (c) 2017 CiaoLee. All rights reserved.
//

import Foundation
import MapKit

class MapPointer: NSObject, MKAnnotation {
    let mapPk: String
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D

    init(mapPk pk: String, nickname: String, location: CLLocationCoordinate2D) {
        self.mapPk = pk
        coordinate = location
        subtitle = nickname
        super.init()
    }
}
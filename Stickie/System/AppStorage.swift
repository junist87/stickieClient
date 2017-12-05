//
//  AppStorage.swift
//  Stickie
//
//  Created by CiaoLee on 2017. 11. 16..
//  Copyright © 2017년 CiaoLee. All rights reserved.
//

import Foundation
import CoreLocation

class AppStorage {
    var email: String!
    var password: String!
    var currentLocation: CLLocation!
    var centerLocation: CLLocation!
    var requestRadius: Double = 0.001
    let url = "http://192.168.0.5:8080"
//    let url = "http://192.168.0.24:8080"

    func restore() {
        email = nil
        password = nil
        currentLocation = nil
        centerLocation = nil
    }
}

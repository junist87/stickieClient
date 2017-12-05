//
//  SystemSettings.swift
//  Stickie
//
//  Created by CiaoLee on 2017. 11. 23..
//  Copyright © 2017년 CiaoLee. All rights reserved.
//

import Foundation
import UIKit

class SystemSettings {
    let url = "http://192.168.0.5:8080"
    func getAppStorage() -> AppStorage {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.appStorage
    }
}

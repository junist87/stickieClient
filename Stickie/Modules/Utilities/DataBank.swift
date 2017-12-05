//
//  DataBank.swift
//  Stickie
//
//  Created by CiaoLee on 2017. 11. 16..
//  Copyright © 2017년 CiaoLee. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DataBank {
    func getAppStorage() -> AppStorage {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.appStorage
    }
}

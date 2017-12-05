//
//  AlertLibrary.swift
//  Stickie
//
//  Created by CiaoLee on 2017. 11. 10..
//  Copyright © 2017년 CiaoLee. All rights reserved.
//

import Foundation
import UIKit

class AlertLibrary {
    func popAlertMessage(message:String)  -> UIAlertController{
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        return alert
    }

    func popAlertMessage(message:String, rootVC: UIViewController){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        rootVC.present(alert, animated: true)
    }
}

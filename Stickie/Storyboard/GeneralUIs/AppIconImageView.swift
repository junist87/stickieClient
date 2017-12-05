//
//  AppIconImageView.swift
//  Stickie
//
//  Created by CiaoLee on 2017. 11. 23..
//  Copyright © 2017년 CiaoLee. All rights reserved.
//

import UIKit

class AppIconImageView: UIImageView {
    let displayImage = UIImage(named: "appicon.png")
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.image = displayImage
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
    }
}

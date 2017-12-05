//
//  IconBarButton.swift
//  Stickie
//
//  Created by CiaoLee on 2017. 11. 24..
//  Copyright © 2017년 CiaoLee. All rights reserved.
//

import UIKit

class IconBarButton: UIButton {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setDefault()
    }
    
    private func setDefault() {
        self.setTitleColor(UIColor.orange, for: UIControlState.normal)
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        self.backgroundColor = UIColor.white
        self.layer.borderColor = UIColor.orange.cgColor
        self.layer.borderWidth = 0.5
    }

}

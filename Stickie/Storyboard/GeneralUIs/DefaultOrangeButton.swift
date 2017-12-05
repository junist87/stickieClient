//
//  DefaultOrangeButton.swift
//  Stickie
//
//  Created by CiaoLee on 2017. 11. 23..
//  Copyright © 2017년 CiaoLee. All rights reserved.
//

import UIKit

class DefaultOrangeButton: UIButton {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setDefault()
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setDefault()
    }
    
    
    
    private func setDefault() {
        self.setTitleColor(UIColor.white, for: UIControlState.normal)
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        self.backgroundColor = UIColor.orange
        
    }

}

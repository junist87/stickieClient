//
//  IndicatorUIView.swift
//  Stickie
//
//  Created by CiaoLee on 2017. 11. 23..
//  Copyright © 2017년 CiaoLee. All rights reserved.
//

import UIKit

class IndicatorUIView: UIView {
    let rootVC: UIViewController
    let infoBarWidth: CGFloat = 150
    let infoBarHeight: CGFloat = 100
    
    init(rootVC ctrl: UIViewController, message: String?) {
        self.rootVC = ctrl
        super.init(frame: rootVC.view.frame)
        // 블러효과
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.frame
        blurEffectView.alpha = 0.5
        self.addSubview(blurEffectView)
        
        // 검은화면
        let black = UIView()
        black.frame = self.frame
        black.alpha = 0.5
        self.addSubview(black)
        
        // 인디케이터
        if let mes = message {
            let indicator = getInfoView(message: mes)
            indicator.center = CGPoint(x: frame.width/2, y: frame.height/2)
            addSubview(indicator)
        } else {
            let indicator = UIActivityIndicatorView()
            indicator.startAnimating()
            indicator.center = CGPoint(x: frame.width/2, y: frame.height/2)
            addSubview(indicator)
        }
        
        self.alpha = 0
    }
    
    private func getInfoView(message: String) -> UIView {
        let pallet = UIView()
        pallet.frame = CGRect(x: 0, y: 0, width: infoBarWidth, height: infoBarHeight)
        pallet.backgroundColor = UIColor.white
        pallet.layer.cornerRadius = 5
        pallet.clipsToBounds = true
        pallet.layer.borderColor = UIColor.gray.cgColor
        pallet.layer.borderWidth = 0.5
        
        let orangeBar = UIView()
        orangeBar.frame = CGRect(x: 0, y: 0, width: infoBarWidth, height: 20)
        orangeBar.backgroundColor = UIColor.orange
        pallet.addSubview(orangeBar)
        
        let label = UILabel()
        label.frame = CGRect(x: 0, y: orangeBar.frame.maxY + 10, width: infoBarWidth, height: 30)
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.text = message
        pallet.addSubview(label)
        
        let indicator = UIActivityIndicatorView()
        indicator.activityIndicatorViewStyle = .gray
        indicator.startAnimating()
        indicator.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        indicator.center = CGPoint(x: pallet.frame.width/2, y: label.frame.maxY + 15 )
        pallet.addSubview(indicator)
        
        let upperLabel = UILabel()
        upperLabel.frame = CGRect(x: 5, y: 0, width: infoBarWidth - 5, height: 20)
        upperLabel.font = UIFont.systemFont(ofSize: 12)
        upperLabel.textColor = UIColor.white
        upperLabel.textAlignment = .left
        upperLabel.text = "Processing"
        pallet.addSubview(upperLabel)
        
        let upperCloseLabel = UILabel()
        upperCloseLabel.frame = CGRect(x: 0, y: 0, width: infoBarWidth - 5, height: 20)
        upperCloseLabel.font = UIFont.systemFont(ofSize: 12)
        upperCloseLabel.textColor = UIColor.white
        upperCloseLabel.textAlignment = .right
        upperCloseLabel.text = "●"
        pallet.addSubview(upperCloseLabel)
        
        
        return pallet
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show() {
        rootVC.view.addSubview(self)
        self.alpha = 0
        UIView.animate(withDuration: TimeInterval(0.2)) {
            self.alpha = 1
        }
    }
    
    func hide() {
        UIView.animate(withDuration: TimeInterval(0.2)) {
            self.alpha = 0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200)) {
            self.removeFromSuperview()
        }
    }
    
}

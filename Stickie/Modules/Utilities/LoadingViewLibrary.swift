//
//  LoadingViewLibrary.swift
//  Stickie
//
//  Created by CiaoLee on 2017. 11. 15..
//  Copyright © 2017년 CiaoLee. All rights reserved.
//

import Foundation
import UIKit

class LoadingViewLibrary {
    private var view: UIView?
    private var grayBgIndicator: UIView?
    private let bgAnimateInterval = 0.2
    private let bgViewAlpha: CGFloat = 0.3
    
    init(targetView: UIView) {
        self.view = targetView
    }
    
    private func getGrayBgIndicator(frame: CGRect) -> UIView {
        // 배경화면
        let background = UIView()
        background.frame = frame
        background.backgroundColor = UIColor.black
        background.alpha = bgViewAlpha
        
        // 인디케이터 생성 후 입력
        let indicator = UIActivityIndicatorView()
        indicator.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        indicator.center = CGPoint(x: frame.width/2, y: frame.height/2)
        indicator.startAnimating()
    
        background.addSubview(indicator)
        return background
    }
    
    func startGrayBgIndicator() {
        // uiview 가 등록되어있고, 인디케이터가 실행되지 않을때만 실행한다.
        guard let targetView = self.view, grayBgIndicator == nil else {
            return
        }
        
        // 인디케이터를 만들고 등록한다
        grayBgIndicator = getGrayBgIndicator(frame: targetView.frame);
        grayBgIndicator?.alpha = 0
        targetView.addSubview(grayBgIndicator!)
        
        // 서서히 페이드인하는 효과
        UIView.animate(withDuration: TimeInterval(bgAnimateInterval)) {
            self.grayBgIndicator?.alpha = self.bgViewAlpha
        }
    }
    
    func stopGrayBgIndicator() {
        // uiview 가 등록되어있고, 인디케이터가 실행중일때만 실행한다.
        guard grayBgIndicator != nil else {
            return
        }
        // 서서히 페이드아웃 하는 효과
        UIView.animate(withDuration: TimeInterval(bgAnimateInterval)) {
            self.grayBgIndicator?.alpha = 0
        }
        
        // 객체 삭제
        grayBgIndicator?.removeFromSuperview()
        grayBgIndicator = nil
    }
}

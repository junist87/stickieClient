//
//  BgUIView.swift
//  Stickie
//
//  Created by CiaoLee on 2017. 11. 25..
//  Copyright © 2017년 CiaoLee. All rights reserved.
//

import UIKit

class BgUIView: UIView {

    let rootVC: UIViewController
    let innerView: InnerUIView
    let animateTime: Double = 0.2
    let leftMargin: CGFloat = 10
    let bottomMargin: CGFloat = 80
    lazy var animateTimeMilliseconds: Int = {
        return (Int)(animateTime * 1000)
    }()
    var bg: UIView!
    lazy var touchBlocker: UIView = {
        let blocker = UIView()
        blocker.frame = rootVC.view.frame
        return blocker
    }()
    var askExit: (() -> Bool)!

    init(rootVC vc: UIViewController, innerView inner: InnerUIView, innerViewPosition: InnerViewPosition) {
        self.rootVC = vc
        self.innerView = inner
        super.init(frame: rootVC.view.frame)

        self.bg = getBg()
        innerView.rootVC = self.rootVC
        innerView.hide = self.hide
        self.askExit = innerView.askExit


        // 배경화면 등록
        self.addSubview(self.bg)

        // 이너뷰 포지션
        addInnerViewPosition(position: innerViewPosition)

        // 매인뷰등록
        self.addSubview(innerView)

        // 배경에 제스쳐등록
        bg.isUserInteractionEnabled = true
        bg.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapBg)))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func tapBg() {
        if askExit() {
            showAlertExit()
        } else {
            self.hide()
        }
    }

    func addInnerViewPosition(position: InnerViewPosition) {
        var cgRect: CGRect!
        switch position {
        case .Center:
            let minX = (self.frame.width - innerView.frame.width) / 2
            let minY = (self.frame.height - innerView.frame.height) / 2
            cgRect = CGRect(x: minX, y: minY, width: innerView.frame.width, height: innerView.frame.height)
        case .Dock:
            let minX = (self.frame.width - innerView.frame.width) / 2
            let minY = (self.frame.height - innerView.frame.height)
            cgRect = CGRect(x: minX, y: minY, width: innerView.frame.width, height: innerView.frame.height)
        case .left:
            let minX = self.frame.width - (innerView.frame.width + leftMargin)
            let minY = self.frame.height - (innerView.frame.height + bottomMargin)
            cgRect = CGRect(x: minX, y: minY, width: innerView.frame.width, height: innerView.frame.height)
        }
        self.innerView.frame = cgRect
    }

    func showAlertExit() {
        let alert = UIAlertController(title: nil, message: "창을 닫으시겠습니까?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default) { (_) in
            self.hide()
        })
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        rootVC.present(alert, animated: true)
    }

    func show() {
        self.unableTouch()
        self.alpha = 0
        innerView.whenInnerViewShow()
        rootVC.view.addSubview(self)
        UIView.animate(withDuration: TimeInterval(animateTime)) {
            self.alpha = 1
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(animateTimeMilliseconds)) {
            self.ableTouch()
        }
    }

    func hide() {
        // 터치 방지
        self.unableTouch()
        // 이너뷰 클로즈 함수 실행
        innerView.whenInnerViewHide()
        // 에니메이션 실행
        UIView.animate(withDuration: TimeInterval(animateTime)) {
            self.alpha = 0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(animateTimeMilliseconds)) {
            self.ableTouch()
            self.removeFromSuperview()
        }
    }

    func unableTouch() {
        self.addSubview(touchBlocker)
    }

    func ableTouch() {
        touchBlocker.removeFromSuperview()
    }

    private func getBg() -> UIView {
        // 블러효과
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = rootVC.view.frame
        blurEffectView.alpha = 0.5
        return blurEffectView
    }
}

enum BgMode {
    case Dock
    case Default
}

enum InnerViewPosition {
    case Dock
    case Center
    case left
}




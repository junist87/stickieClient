//
//  BarButtonTrayUIView.swift
//  Stickie
//
//  Created by CiaoLee on 2017. 12. 1..
//  Copyright © 2017년 CiaoLee. All rights reserved.
//

import Foundation
import UIKit

class BarButtonUIView: InnerUIView {
    @IBOutlet var imgIcon01: UIImageView!
    @IBOutlet var imgIcon02: UIImageView!
    @IBOutlet var imgIcon03: UIImageView!
    @IBOutlet var imgIcon04: UIImageView!

    @IBOutlet var lbName01: UILabel!
    @IBOutlet var lbName02: UILabel!
    @IBOutlet var lbName03: UILabel!
    @IBOutlet var lbName04: UILabel!

    @IBOutlet weak var writerView: WriterUIView!


    lazy var writerViewBg: BgUIView = {
        let view = BgUIView(rootVC: rootVC, innerView: writerView, innerViewPosition: InnerViewPosition.Center)
        return view
    }()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.clear

    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.setDefault()
    }

    private func setDefault() {
        setDefaultImg(imageView: imgIcon01)
        setDefaultImg(imageView: imgIcon02)
        setDefaultImg(imageView: imgIcon03)
        setDefaultImg(imageView: imgIcon04)

        imgIcon01.image = UIImage(named: "down.png")
        lbName01.text = ""
        lbName01.textColor = UIColor.white
        imgIcon02.image = UIImage(named: "write.png")
        lbName02.text = "글쓰기"
        lbName02.textColor = UIColor.white
        imgIcon03.image = UIImage(named: "user.png")
        lbName03.text = "유저정보"
        lbName03.textColor = UIColor.white
        imgIcon04.image = UIImage(named: "logout.png")
        lbName04.text = "로그아웃"
        lbName04.textColor = UIColor.white


        imgIcon01.isUserInteractionEnabled = true
        imgIcon01.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapImgView01)))

        imgIcon02.isUserInteractionEnabled = true
        imgIcon02.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapImgView02)))

        imgIcon03.isUserInteractionEnabled = true
        imgIcon03.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapImgView03)))

        imgIcon04.isUserInteractionEnabled = true
        imgIcon04.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapImgView04)))
    }

    // 닫기
    @objc func tapImgView01() {
        self.hide()
    }

    // 글쓰기
    @objc func tapImgView02() {
        writerViewBg.show()
        self.hide()
    }

    // 유저정보
    @objc func tapImgView03() {
        self.hide()
        let userVC = rootVC.storyboard?.instantiateViewController(withIdentifier: "UserVC") as! UserVC
        userVC.modalTransitionStyle = .crossDissolve
        rootVC.present(userVC, animated: true)
    }

    // 로그아웃
    @objc func tapImgView04() {
        // 기존데이터를 삭제하고 로그아웃 한다.
        CLAccount().removeUserInfo()
        DataBank().getAppStorage().restore()
        rootVC.dismiss(animated: true)
    }

    override func whenInnerViewShow() {
        showIconBar()
    }

    override func whenInnerViewHide() {
        hideIconBar()
    }

    private func showIconBar() {
        showIcon(image: self.imgIcon01, interval: 0)
        showIcon(image: self.imgIcon02, interval: 100)
        showIcon(image: self.imgIcon03, interval: 150)
        showIcon(image: self.imgIcon04, interval: 200)

    }

    private func hideIconBar() {
        hideIcon(image: self.imgIcon01, interval: 200)
        hideIcon(image: self.imgIcon02, interval: 150)
        hideIcon(image: self.imgIcon03, interval: 100)
        hideIcon(image: self.imgIcon04, interval: 0)

    }

    private func showIcon(image: UIView, interval: Int) {
        // 애니메니션
        image.alpha = 0
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(interval)) {
            UIView.animate(withDuration: TimeInterval(0.2)) {
                image.alpha = 1
            }
        }

    }

    private func hideIcon(image: UIView, interval: Int) {
        // 에니메이션
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(interval)) {
            UIView.animate(withDuration: TimeInterval(0.2)) {
                image.alpha = 0
            }
        }


    }


    private func setDefaultImg(imageView: UIImageView) {
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.clipsToBounds = true
        NSLog("IconBarButton Initialization: \(imageView)")
    }

    override func askExit() -> Bool {
        return false
    }
}

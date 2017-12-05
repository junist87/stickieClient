//
// Created by CiaoLee on 2017. 11. 30..
// Copyright (c) 2017 CiaoLee. All rights reserved.
//

import Foundation
import UIKit

class IntroVCVWAction: VWAction {
    let rootVC: UIViewController

    init(_ vc: UIViewController) {
        self.rootVC = vc
    }

    func success(_ response: NSDictionary) {
        moveMainVC()
    }

    func fail(_ response: NSDictionary) {
        moveLoginVC()
    }

    func error(_ response: NSDictionary) {
        popUpMessage("서버 접속 오류")
        moveLoginVC()
    }

    func popUpMessage(_ message: String) {
        let alert = AlertLibrary().popAlertMessage(message: message)
        self.rootVC.present(alert, animated: true)
    }

    func moveMainVC() {
        animate()
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
            let mainVC = VCLoader().getVC(vcName: "MapVC", storyboard: self.rootVC.storyboard!)
            self.rootVC.present(mainVC, animated: false)
        }
    }

    func moveLoginVC() {
        animate()
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
            let loginVC = VCLoader().getVC(vcName: "LoginVC", storyboard: self.rootVC.storyboard!)
            self.rootVC.present(loginVC, animated: true)
        }
    }

    func animate() {
        let blurEffect = UIBlurEffect(style: .extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = rootVC.view.frame
        blurEffectView.alpha = 0


        let whiteBg = UIView()
        whiteBg.frame = rootVC.view.frame
        whiteBg.backgroundColor = UIColor.white
        whiteBg.alpha = 0
        rootVC.view.addSubview(whiteBg)


        UIView.animate(withDuration: TimeInterval(0.5)) {
            blurEffectView.alpha = 1
            whiteBg.alpha = 1
        }
    }
}

//
// Created by CiaoLee on 2017. 11. 30..
// Copyright (c) 2017 CiaoLee. All rights reserved.
//

import Foundation
import UIKit

class ForgotVWAction: VWAction {
    let hide: () -> Void
    let indicator: IndicatorUIView
    let rootVC: UIViewController

    init(indicator indi: IndicatorUIView, hide hi: @escaping () -> Void, rootVC vc: UIViewController) {
        self.hide = hi
        self.indicator = indi
        self.rootVC = vc
    }

    func success(_ response: NSDictionary) {
        // 인디케이터 종료
        indicator.hide()
        // 뷰를 닫는다
        hide()
        // 알림창을 띄운다
        AlertLibrary().popAlertMessage(message: "가입하신 이메일로 새로운\n비밀번호와 인증키를 발송하였습니다.", rootVC: rootVC)
    }

    func fail(_ response: NSDictionary) {
        // 인디케이터를 종료한다
        indicator.hide()
        // 알림창을 띄운디
        AlertLibrary().popAlertMessage(message: "등록되지 않은 이메일 입니다", rootVC: rootVC)
    }

    func error(_ response: NSDictionary) {
        // 인디케이터를 종료한다
        indicator.hide()
        // 알림창을 띄운디
        AlertLibrary().popAlertMessage(message: "알 수 없는 에러", rootVC: rootVC)
    }

}
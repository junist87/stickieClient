//
//  JoinVWAction.swift
//  Stickie
//
//  Created by CiaoLee on 2017. 11. 30..
//  Copyright © 2017년 CiaoLee. All rights reserved.
//

import Foundation
import UIKit

class JoinVWAction : VWAction {
    let hide: () -> Void
    let indicator: IndicatorUIView
    let rootVC: UIViewController

    init(indicator indi: IndicatorUIView, hide hi: @escaping () -> Void, rootVC vc: UIViewController) {
        self.hide = hi
        self.indicator = indi
        self.rootVC = vc
    }

    func success(_ response: NSDictionary) {
        // 메시지를 보여준다
        AlertLibrary().popAlertMessage(message: "등록된 메일로 인증키를 전송하였습니다", rootVC: rootVC)
        // 인디케이터를 종료한다
        indicator.hide()
        // 창을 닫는다
        hide()
    }
    
    func fail(_ response: NSDictionary) {
        // 인디케이터를 종료한다
        indicator.hide()

        // 알림 메세지를 보여준다
        AlertLibrary().popAlertMessage(message: "중복된 이메일 입니다", rootVC: rootVC)
    }
    
    func error(_ response: NSDictionary) {
        AlertLibrary().popAlertMessage(message: "알 수 없는 에러", rootVC: rootVC)
    }
}

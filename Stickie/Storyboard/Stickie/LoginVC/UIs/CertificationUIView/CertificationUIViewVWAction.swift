//
// Created by CiaoLee on 2017. 11. 30..
// Copyright (c) 2017 CiaoLee. All rights reserved.
//

import Foundation
import UIKit

class CertificationUIViewVWAction: VWAction {
    let hide: () -> Void
    let indicator: IndicatorUIView
    let rootVC: UIViewController

    init(indicator indi: IndicatorUIView, hide hi: @escaping () -> Void, rootVC vc: UIViewController) {
        self.hide = hi
        self.indicator = indi
        self.rootVC = vc
    }

    func success(_ response: NSDictionary) {
        // 인디케이터와 창을 닫는다
        indicator.hide()
        hide()

        // 메인프로그램 뷰로 이동한다
        let mainVC = VCLoader().getVC(vcName: "MapVC", storyboardName: "stickie")!
        rootVC.present(mainVC, animated: true)
    }

    func fail(_ response: NSDictionary) {
        // 응답코드
        guard let failType = response["errorType"] else {
            return
        }

        // 형변환
        let code = failType as! Int

        indicator.hide()    // 인디케이터와 창을 닫는다
        let alert = AlertLibrary()  // 메시지

        switch code {
        case 0: // 틀린키
            alert.popAlertMessage(message: "잘못된 인증키 입니다", rootVC: rootVC)
        case 1: // 이메일 없음
            alert.popAlertMessage(message: "등록되지 않은 이메일 입니다", rootVC: rootVC)
        case 2: // 비밀번호 틀림
            alert.popAlertMessage(message: "잘못된 패스워드 입니다", rootVC: rootVC)
        default:
            alert.popAlertMessage(message: "알 수 없는 에러", rootVC: rootVC)
        }
    }

    func error(_ response: NSDictionary) {
        AlertLibrary().popAlertMessage(message: "서버 에러\n다시 한번 시도하여 주십시오", rootVC: rootVC)
    }
}

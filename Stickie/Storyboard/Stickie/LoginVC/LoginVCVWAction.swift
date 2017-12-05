//
// Created by CiaoLee on 2017. 11. 30..
// Copyright (c) 2017 CiaoLee. All rights reserved.
//

import Foundation
import UIKit

class LoginVCVWAction: VWAction {
    let indicator: IndicatorUIView
    let rootVC: UIViewController
    let viewCertiBg: BgUIView

    init(indication indi: IndicatorUIView, viewCertiBg certi: BgUIView, rootVC vc: UIViewController) {
        self.indicator = indi
        self.rootVC = vc
        self.viewCertiBg = certi
    }

    func success(_ response: NSDictionary) {
        // 인디케이터를 종료한다
        indicator.hide()

        // 프로그램뷰로 이동한다
        let mainVC = VCLoader().getVC(vcName: "MapVC", storyboard: self.rootVC.storyboard!)
        rootVC.present(mainVC, animated: true)
    }

    func fail(_ response: NSDictionary) {

        let failType = response["errorType"] as! Int // 응답신호
        let alert = AlertLibrary()  // 알람 라이브러리

        // 인디케이터를 종료한다
        indicator.hide()

        switch failType {
        case 0: // 이메일 에러
            alert.popAlertMessage(message: "등록된 이메일이 없습니다", rootVC: rootVC)
        case 1: // 패스워드 에러
            alert.popAlertMessage(message: "패스워드가 틀렸습니다", rootVC: rootVC)
        case 2: // 잠긴 계정
            viewCertiBg.show()
        default:
            alert.popAlertMessage(message: "알 수 없는 에러", rootVC: rootVC)
        }
    }

    func error(_ response: NSDictionary) {
        AlertLibrary().popAlertMessage(message: "서버 연결에 실패하였습니다\n다시 시도하여 주십시오", rootVC: rootVC)
    }


}

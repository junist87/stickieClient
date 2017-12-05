//
// Created by CiaoLee on 2017. 12. 1..
// Copyright (c) 2017 CiaoLee. All rights reserved.
//

import Foundation
import UIKit

class WriterVWAction: VWAction {
    let hide: () -> Void
    let indicator: IndicatorUIView
    let rootVC: UIViewController

    init(indicator indi: IndicatorUIView, hide hi: @escaping () -> Void, rootVC vc: UIViewController) {
        self.hide = hi
        self.indicator = indi
        self.rootVC = vc
    }

    func success(_ response: NSDictionary) {
        indicator.hide()
        hide()
    }

    func fail(_ response: NSDictionary) {
        AlertLibrary().popAlertMessage(message: "글 쓰기에 실패하였습니다", rootVC: rootVC)
    }

    func error(_ response: NSDictionary) {
        AlertLibrary().popAlertMessage(message: "서버 에러", rootVC: rootVC)
    }
}
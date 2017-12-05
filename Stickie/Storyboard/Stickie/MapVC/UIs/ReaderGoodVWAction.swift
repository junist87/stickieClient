//
// Created by CiaoLee on 2017. 12. 4..
// Copyright (c) 2017 CiaoLee. All rights reserved.
//

import Foundation


class ReaderGoodVWAction: VWAction {
    let refresh: () -> Void
    let indicator: IndicatorUIView

    init(refresh re: @escaping () -> Void, indicator indi: IndicatorUIView) {
        self.indicator = indi
        self.refresh = re
    }

    func success(_ response: NSDictionary) {
        self.refresh()
        self.indicator.hide()
    }

    func fail(_ response: NSDictionary) {
    }

    func error(_ response: NSDictionary) {
    }
}
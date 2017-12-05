//
// Created by CiaoLee on 2017. 12. 4..
// Copyright (c) 2017 CiaoLee. All rights reserved.
//

import Foundation
import UIKit


class MapPointerViewVWAction: VWAction {
    let viewReaderBg: BgUIView
    let viewReader: ReaderUIView
    let mapPk: String
    let indicator: IndicatorUIView

    init(reader: ReaderUIView, bgViewer: BgUIView, mapPk pk: String, indicator indi: IndicatorUIView) {
        NSLog("어노테이션뷰 : mapPk - \(pk)")
        self.mapPk = pk
        self.viewReader = reader
        self.viewReaderBg = bgViewer
        self.indicator = indi
    }

    func success(_ response: NSDictionary) {
        viewReader.viewMapPointDetail(mapPk: self.mapPk)
        viewReaderBg.show()
        indicator.hide()
    }

    func fail(_ response: NSDictionary) {
        indicator.hide()
    }

    func error(_ response: NSDictionary) {
        indicator.hide()
    }
}
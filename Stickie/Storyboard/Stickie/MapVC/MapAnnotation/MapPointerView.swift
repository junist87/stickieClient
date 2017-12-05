//
// Created by CiaoLee on 2017. 12. 4..
// Copyright (c) 2017 CiaoLee. All rights reserved.
//

import Foundation
import MapKit
import UIKit
import UIKit

class MapPointerView: MKAnnotationView {
    let mapPk: String
    let rootVC : UIViewController
    let viewReaderBg: BgUIView
    let viewReader: ReaderUIView
    let clMapBoard = CLMapBoard()
    let mapBoardService = MapBoardService()
    let indicator: IndicatorUIView

    init(annotation: MKAnnotation?, reuseIdentifier: String?, reader: ReaderUIView, bgViewer: BgUIView, mapPk pk: String, rootVC vc: UIViewController) {
        NSLog("어노테이션뷰 : mapPk - \(pk)")
        self.mapPk = pk
        self.viewReader = reader
        self.viewReaderBg = bgViewer
        self.rootVC = vc
        self.indicator = IndicatorUIView(rootVC: vc, message: "서버에 접속중")
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)

        self.canShowCallout = false
        self.isSelected = true
        changePinColor(isRead: clMapBoard.isRead(mapPk: pk))

    }

    // 맵 어노테이션을 클릭했을때 실행되는 메소드
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected == true {

            // 선택이 되었을때
            changePinColor(isRead: true)


            // 통신하기
            NSLog("annotationView MapPk \(mapPk)")
            indicator.show()
            let vwActions = MapPointerViewVWAction(reader: viewReader, bgViewer: viewReaderBg, mapPk: mapPk, indicator: indicator)
            mapBoardService.readMapPoint(mapPk: self.mapPk, vwActions: vwActions)
        }

    }

    func changePinColor(isRead: Bool) {
        clMapBoard.setRead(mapPk: mapPk, isRead: isRead)
        var imageName: String!
        if isRead {
            imageName = "redPin.png"
        } else {
            imageName = "bluePin.png"
        }
        guard let pin = UIImage(named: imageName) else {
            return
        }
        pin.withRenderingMode(.alwaysOriginal)
        self.image = pin
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
//
//  MapVWAction.swift
//  Stickie
//
//  Created by CiaoLee on 2017. 12. 2..
//  Copyright © 2017년 CiaoLee. All rights reserved.
//

import Foundation
import MapKit
import UIKit


class MapRequestVWAction: VWAction {
    private let dataBank = DataBank()
    private let mapView: MKMapView
    private var mapPoint = [MapPoint]()

    init(mapView view: MKMapView, mapPointList: [MapPoint]) {
        self.mapView = view
        self.mapPoint = mapPointList
    }

    // 성공하면 맵 리스트를 갱신한다.
    func success(_ response: NSDictionary) {
        let clMapBoard = CLMapBoard()
        let clUserInfo = CLUserInfo()
        guard let currentLocation = dataBank.getAppStorage().currentLocation else {
            return
        }

        let getMapPoint = clMapBoard.getMapPointList(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude, degree: dataBank.getAppStorage().requestRadius)

        for map in getMapPoint {
            // 이미 등록이 되어있다면 패스
            let swt = self.mapPoint.contains() { element in
                if element.pk == map.pk {
                    return true
                } else {
                    return false
                }
            }

            if !swt {
                let nickname = clUserInfo.getNickname(accountPk: map.accountPk)
                NSLog("맵에 등록하기 : nickname = \(nickname), accountPl = \(map.accountPk)")

                let mapPointer = MapPointer(mapPk: map.pk, nickname: nickname, location: CLLocationCoordinate2D(latitude: map.latitude, longitude: map.longitude))
                mapView.addAnnotation(mapPointer)
                self.mapPoint.append(map)
            }

        }

    }

    func fail(_ response: NSDictionary) {

    }

    func error(_ response: NSDictionary) {

    }

}

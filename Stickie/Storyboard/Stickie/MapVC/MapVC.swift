//
//  MapVC.swift
//  Stickie
//
//  Created by CiaoLee on 2017. 11. 15..
//  Copyright © 2017년 CiaoLee. All rights reserved.
//

import UIKit
import MapKit

class MapVC: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    // interface builder
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var leftIconBar: BarButtonUIView!
    @IBOutlet var viewReader: ReaderUIView!
    @IBOutlet var imgMenu: UIImageView!
    
    lazy var viewReaderBg: BgUIView = {
        return BgUIView(rootVC: self, innerView: viewReader, innerViewPosition: InnerViewPosition.Center)
    }()

    lazy var leftIconBarViewBg: BgUIView = {
        return BgUIView(rootVC: self, innerView: leftIconBar, innerViewPosition: InnerViewPosition.left)
    }()

    // 맵 관련 변수들
    var locationManager: CLLocationManager!
    var meLocation: MKCoordinateRegion?
    var clickedMapPk: String!

    // 시스템 변수
    let dataBank = DataBank()
    let mapBoardService = MapBoardService()
    var mapPoint = [MapPoint]()

    override func viewDidAppear(_ animated: Bool) {
        setUISettings()
        getLocationAuth()
        requestMapPoint()
    }
    
  
    
    @objc func popUpMenu() {
        leftIconBarViewBg.show()
    }


    func setUISettings() {
        mapView.frame = self.view.frame
        mapView.delegate = self
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        imgMenu.clipsToBounds = true
        imgMenu.layer.cornerRadius = imgMenu.frame.width/2
        imgMenu.isUserInteractionEnabled = true
        imgMenu.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(popUpMenu)))
        imgMenu.image = UIImage(named: "up.png")
        imgMenu.frame = CGRect(x: view.frame.width - 80, y: view.frame.height - 150, width: 60, height: 60)
    }

    func getLocationAuth() {
        // 맵 정보를 쓸수있게 시스템인증하는 곳
        let status = CLLocationManager.authorizationStatus()
        if status == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        }
        if status == .denied || status == .restricted {
            AlertLibrary().popAlertMessage(message: "위치서비스 기능을 활성화 하여야 합니다.", rootVC: self)
            return
        }
        locationManager.startUpdatingLocation()
    }


    // gps 신호가 바뀔때마다 호출되는 메소드
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let appStorage = dataBank.getAppStorage()

        // 현재위치 저장
        let currentLocation = locations.last!
        appStorage.currentLocation = currentLocation

        // 맵 데이터를 불러온다
        if isRequestMapPoint() {
            NSLog("MapVC 맵을 Request 합니다")
            requestMapPoint()
        }

        // 맵에 내 위치 보여주기
        let viewRegion = MKCoordinateRegionMakeWithDistance(currentLocation.coordinate, 150, 150)
        mapView.setRegion(viewRegion, animated: true)

    }

    // 맵을 요청한다.
    func requestMapPoint() {
        if let currentLocation = dataBank.getAppStorage().currentLocation {
            let vwActions = MapRequestVWAction(mapView: self.mapView, mapPointList: self.mapPoint)
            mapBoardService.request(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude, vwActions: vwActions)
        }
    }


    // 맵로딩을 하는지 체크하는 메소드
    private func isRequestMapPoint() -> Bool {
        // 좌표값이 존재 하는지 검사
        let appStorage = dataBank.getAppStorage()

        // 좌표가 없다면 바로 리퀘스트
        if let current = appStorage.currentLocation {
            guard let center = appStorage.centerLocation else {
                appStorage.centerLocation = current
                return true
            }

            // 기준 거리 불러오기
            let degree = appStorage.requestRadius
            let curLat = current.coordinate.latitude
            let curLon = current.coordinate.longitude
            let cenLat = center.coordinate.latitude
            let cenLon = center.coordinate.longitude

            // 기준좌표값 +- degree 상태에 있으면 true, 아니면 false
            if (((cenLat - degree) < (curLat)) && (curLat < (cenLat + degree))) &&
                       (((cenLon - degree) < (curLon)) && (curLon < (cenLon + degree))) {
                return false
            } else {
                NSLog("맵 로딩을 해야 합니다.")
                return true
            }
        } else {
            return false
        }
    }

    // 마커를 클릭했을때
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 2 클릭한 마커가 지정한것이 아니라면 패스
        guard let annotation = annotation as? MapPointer else {
            return nil
        }
        // 3 맵이름
        let identifier = "marker"
        var view: MKAnnotationView
        // 4
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            //view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view = MapPointerView(annotation: annotation, reuseIdentifier: identifier, reader: viewReader, bgViewer: viewReaderBg, mapPk: annotation.mapPk, rootVC: self)
        }
        return view
    }

}




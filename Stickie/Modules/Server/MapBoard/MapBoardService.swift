//
// Created by CiaoLee on 2017. 12. 1..
// Copyright (c) 2017 CiaoLee. All rights reserved.
//

import Foundation


class MapBoardService: ServerTemplate {
    private let serverInfo = DataBank().getAppStorage().url
    private let clMapBoard = CLMapBoard()
    private let clMapGood = CLMapGood()

    func uploadStickie(contents: String, latitude: Double, longitude: Double, vwActions: VWAction) {
        // 요청 파라미터 생성
        let param = ParameterMaker()
        param.addParameter(key: "contents", value: contents)
        param.addParameter(key: "latitude", value: latitude)
        param.addParameter(key: "longitude", value: longitude)

        // 레스트 URL 생성
        let restUrl = serverInfo + "/mapboard/upload"

        // 비동기 통신시작
        self.authTemplate(param: param, restUrl: restUrl, baActions: BAMapBoardUploadStickie(), vwActions: vwActions)
    }


    func request(latitude: Double, longitude: Double, vwActions: VWAction) {
        let radius: Double = DataBank().getAppStorage().requestRadius
        // 요청 파라미터 생성
        let param = ParameterMaker()
        param.addParameter(key: "latitude", value: latitude)
        param.addParameter(key: "longitude", value: longitude)
        param.addParameter(key: "radius", value: radius)
        //param.addParameter(key: "mapPk", value: requestMapPointList(latitude: latitude, longitude: longitude, degree: radius))

        // 레스트 URL 생성
        let restUrl = serverInfo + "/mapboard/request"

        // 비동기 통신시작
        self.authTemplate(param: param, restUrl: restUrl, baActions: BAMapBoardRequest(), vwActions: vwActions)
    }

    func readMapPoint(mapPk: String, vwActions: VWAction) {
        // 요청 파라미터 생성
        let param = ParameterMaker()
        param.addParameter(key: "readMapPk", value: mapPk)

        // 레스트 URL 생성
        let restUrl = serverInfo + "/mapboard/read"

        // 좋아요 리스트 삭제
        clMapGood.deleteAll(mapPk: mapPk)


        // 비동기 통신시작
        self.authTemplate(param: param, restUrl: restUrl, baActions: BAMapBoardReadRequest(), vwActions: vwActions)
    }

    func upgradeGood(mapPk: String, vwActions: VWAction) {
        // 요청 파라미터 생성
        let param = ParameterMaker()
        param.addParameter(key: "readMapPk", value: mapPk)

        // 레스트 URL 생성
        let restUrl = serverInfo + "/mapboard/upgradeGood"

        // 좋아요 리스트 삭제
        clMapGood.deleteAll(mapPk: mapPk)

        // 비동기 통신시작
        self.authTemplate(param: param, restUrl: restUrl, baActions: BAMapBoardGood(), vwActions: vwActions)
    }

    func downgradeGood(mapPk: String, vwActions: VWAction) {
        // 요청 파라미터 생성
        let param = ParameterMaker()
        param.addParameter(key: "readMapPk", value: mapPk)

        // 레스트 URL 생성
        let restUrl = serverInfo + "/mapboard/downgradeGood"

        // 좋아요 리스트 삭제
        clMapGood.deleteAll(mapPk: mapPk)

        // 비동기 통신시작
        self.authTemplate(param: param, restUrl: restUrl, baActions: BAMapBoardGood(), vwActions: vwActions)
    }

    private func requestMapPointList(latitude: Double, longitude: Double, degree: Double) -> [String] {
        let list = clMapBoard.getMapPointList(latitude: latitude, longitude: longitude, degree: degree)

        var responseList = [String]()
        for mapPoint in list {
            responseList.append(mapPoint.pk)
        }
        return responseList
    }
}


struct RQMapPoint {
    let mapPk: String
}

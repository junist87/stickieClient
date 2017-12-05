//
// Created by CiaoLee on 2017. 12. 4..
// Copyright (c) 2017 CiaoLee. All rights reserved.
//

import Foundation


class BAMapBoardReadRequest: BAAction {
    private let clMapBoard = CLMapBoard()
    private let clUserInfo = CLUserInfo()
    private let clMapGood = CLMapGood()

    func success(response: NSDictionary) {
        let responseTranslator = ResponseTranslator()
        // 맵 정보 저장
        let mapList = responseTranslator.transMapPoint(response["mapList"])
        for mapPoint in mapList {
            clMapBoard.insert(mapPoint: mapPoint)
        }

        // 유저인포 저장
        let accountList = responseTranslator.transAccount(response["accountList"])
        for account in accountList {
            clUserInfo.saveUserInfo(accountPk: account.pk, nickname: account.nickname)
        }

        // 좋아요 리스트
        let mapGoodList = responseTranslator.transMapGood(response["mapGoodList"])
        clMapGood.insert(mapGoodList: mapGoodList)

    }

    func fail(response: NSDictionary) {
    }

    func error(response: NSDictionary) {
    }
}
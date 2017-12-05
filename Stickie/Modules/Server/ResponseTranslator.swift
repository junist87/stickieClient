//
// Created by CiaoLee on 2017. 12. 3..
// Copyright (c) 2017 CiaoLee. All rights reserved.
//

import Foundation
import SwiftyJSON

class ResponseTranslator {
    func transMapPoint(_ response: Any) -> [MapPoint] {
        var list = [MapPoint]()

        let mapList = JSON(response).array!
        for mapPoint in mapList {
            let accountPk = mapPoint["accountPk"].string!
            let mapPk = mapPoint["pk"].string!
            let contents = mapPoint["contents"].string!
            let createDate = mapPoint["createDate"].string!
            let latitude = mapPoint["latitude"].double!
            let longitude = mapPoint["longitude"].double!
            let good = mapPoint["good"].int64!

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-dd-MM"
            let date = dateFormatter.date(from: createDate)!
            list.append(MapPoint(pk: mapPk, accountPk: accountPk, contents: contents, createDate: date, latitude: latitude, longitude: longitude, good: good))

        }
        return list
    }


    func transAccount(_ response: Any) -> [Account] {
        var list = [Account]()

        let accountList = JSON(response).array!
        for account in accountList {
            let pk = account["pk"].string!
            let email = account["email"].string!
            let nickname = account["nickname"].string!
            if let password = account["password"].string {
                let account = Account(pk: pk, email: email, password: password, nickname: nickname)
                list.append(account)
            } else {
                let account = Account(pk: pk, email: email, password: nil, nickname: nickname)
                list.append(account)
            }
        }

        return list
    }

    func transMapGood(_ response: Any) -> [MapGood] {
        var list = [MapGood]()

        let accountList = JSON(response).array!
        for account in accountList {
            let mapPk = account["mapPk"].string!
            let accountPk = account["accountPk"].string!
            let mapGood = MapGood(mapPk: mapPk, accountPk: accountPk)
            list.append(mapGood)
        }

        return list
    }

    func transMapScrap(_ response: Any) -> [MapScrap] {
        var list = [MapScrap]()

        let accountList = JSON(response).array!
        for account in accountList {
            let mapPk = account["mapPk"].string!
            let accountPk = account["accountPk"].string!
            let mapScrap = MapScrap(mapPk: mapPk, accountPk: accountPk)
            list.append(mapScrap)
        }

        return list
    }
}

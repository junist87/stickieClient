//
// Created by CiaoLee on 2017. 11. 27..
// Copyright (c) 2017 CiaoLee. All rights reserved.
//

import Foundation
import UIKit

struct MapPoint {
    let pk: String
    let accountPk: String
    let contents: String
    let createDate: Date
    let latitude: Double
    let longitude: Double
    let good: Int64
}

struct Account {
    let pk: String
    let email: String
    let password: String!
    let nickname: String
}

struct MapGood {
    let mapPk: String
    let accountPk: String
}

struct MapScrap {
    let mapPk: String
    let accountPk: String
}


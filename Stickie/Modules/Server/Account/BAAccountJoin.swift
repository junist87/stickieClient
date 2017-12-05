//
// Created by CiaoLee on 2017. 11. 29..
// Copyright (c) 2017 CiaoLee. All rights reserved.
//

import Foundation

class BAAccountJoin: BAAction {

    private let appStorage = DataBank().getAppStorage()

    func success(response: NSDictionary) {
        // 어카운트 정보 입력
        let accountList = ResponseTranslator().transAccount(response["accountList"])
        for account in accountList {
            CLAccount().saveUserInfo(email: account.email, password: account.password, accountPk: account.pk)
        }
    }

    func fail(response: NSDictionary) {
    }

    func error(response: NSDictionary) {
    }
}
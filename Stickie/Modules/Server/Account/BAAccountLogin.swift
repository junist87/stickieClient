//
// Created by CiaoLee on 2017. 11. 29..
// Copyright (c) 2017 CiaoLee. All rights reserved.
//

import Foundation

class BAAccountLogin: BAAction {
    private let appStorage = DataBank().getAppStorage()

    /*
    로그인 승인이 되었을때
    */
    func success(response: NSDictionary) {
        // 어카운트 정보 입력
        let accountList = ResponseTranslator().transAccount(response["accountList"])
        for account in accountList {
            CLAccount().saveUserInfo(email: account.email, password: account.password, accountPk: account.pk)
        }
    }

    /*
    로그인 승인이 실패하였을때
    */
    func fail(response: NSDictionary) {
        CLAccount().removeUserInfo()
    }

    /*
    서버연결에 실패하였을 때
    */
    func error(response: NSDictionary) {
        CLAccount().removeUserInfo()
    }


}

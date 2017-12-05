//
// Created by CiaoLee on 2017. 11. 29..
// Copyright (c) 2017 CiaoLee. All rights reserved.
//

import Foundation


class BAAccountCertification: BAAction {
    private let appStorage = DataBank().getAppStorage()

    /*
    승인에 성공하였을때
    */
    func success(response: NSDictionary) {
        // 어카운트 정보 입력
        let accountList = ResponseTranslator().transAccount(response["accountList"]!)
        for account in accountList {
            _ = CLAccount().saveUserInfo(email: account.email, password: account.password, accountPk: account.pk)
        }
    }


    /*
    승인이 실패하였을때
    */
    func fail(response: NSDictionary) {
    }

    /*
    서버연결에 실패하였을 때
    */
    func error(response: NSDictionary) {
    }


}

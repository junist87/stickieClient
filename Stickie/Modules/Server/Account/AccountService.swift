//
//  AccountService.swift
//  Stickie
//
//  Created by CiaoLee on 2017. 11. 23..
//  Copyright © 2017년 CiaoLee. All rights reserved.
//

import Foundation

class AccountService: ServerTemplate {
    private let serverInfo = DataBank().getAppStorage().url


    func login(email: String, password: String,
               vwActions: VWAction) {
        // 요청 파라미터 생성
        let param = ParameterMaker()
        param.addParameter(key: "email", value: email)
        param.addParameter(key: "password", value: password)
        
        // 로그인 정보 임시 저장
        let appStroage = DataBank().getAppStorage()
        appStroage.email = email
        appStroage.password = password
        
        // 레스트 URL 생성
        let restUrl = serverInfo + "/account/login"

        // 비동기 통신시작
        self.simpleTemplate(param: param, restUrl: restUrl, baActions: BAAccountLogin(), vwActions: vwActions)

    }

    func join(email: String, password: String, nickname: String, vwActions: VWAction) {
        // 요청 파라미터 생성
        let param = ParameterMaker()
        param.addParameter(key: "email", value: email)
        param.addParameter(key: "password", value: password)
        param.addParameter(key: "nickname", value: nickname)

        // 레스트 URL 생성
        let restUrl = serverInfo + "/account/join"

        // 비동기 통신시작
        self.simpleTemplate(param: param, restUrl: restUrl, baActions: BAAccountJoin(), vwActions: vwActions)
    }

    func forgot(email: String, vwActions: VWAction) {
        // 요청 파라미터 생성
        let param = ParameterMaker()
        param.addParameter(key: "email", value: email)

        // 레스트 URL 생성
        let restUrl = serverInfo + "/account/forgot"

        // 비동기 통신시작
        self.simpleTemplate(param: param, restUrl: restUrl, baActions: BAAccountForgot(), vwActions: vwActions)

    }

    func certification(email: String, password: String, key: String, vwActions: VWAction) {
        // 요청 파라미터 생성
        let param = ParameterMaker()
        param.addParameter(key: "email", value: email)
        param.addParameter(key: "password", value: password)
        param.addParameter(key: "authorizationKey", value: key)

        // 레스트 URL 생성
        let restUrl = serverInfo + "/account/certification"

        // 비동기 통신시작
        self.simpleTemplate(param: param, restUrl: restUrl, baActions: BAAccountCertification(), vwActions: vwActions)
    }


}

//
//  SVTemplate.swift
//  Stickie
//
//  Created by CiaoLee on 2017. 11. 28..
//  Copyright © 2017년 CiaoLee. All rights reserved.
//

import Foundation
import Alamofire

class ServerTemplate {
    let manager: SessionManager = {
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = TimeInterval(1)
        return manager
    }()


    func simpleTemplate(param: ParameterMaker, restUrl: String, baActions: BAAction, vwActions: VWAction) {
        let request = self.manager.request(restUrl, method: .post, parameters: param.getParameters(), encoding: JSONEncoding.default)

        let actions = ActionDictionaryHandler(baActions: baActions, vwActions: vwActions).getActions()

        NSLog("Request Url : \(restUrl)")
        NSLog("Request Parameter: \(param.getParameters())")
        request.responseJSON { (response) in
            guard let json = response.result.value as? NSDictionary else {
                //
                actions[-1]?(NSDictionary())
                return
            }
            
            NSLog("Server Response: \(json)")
            let responseType = json["response"] as! Int
            actions[responseType]?(json)
        }
    }


    func authTemplate(param: ParameterMaker, restUrl: String, baActions: BAAction, vwActions: VWAction) {

        // 응답후 처리
        let actions = ActionDictionaryHandler(baActions: baActions, vwActions: vwActions).getActions()

        // 로그인 데이터 가져오기
        guard let clAccount = CLAccount().getRecentlyAccount() else {
            // 아이디 정보를 가지고 올수 없는것은 실패
            actions[-1]?(NSDictionary())
            return
        }

        param.addParameter(key: "email", value: clAccount.email)
        param.addParameter(key: "password", value: clAccount.password)

        // 요청 생성
        let request = self.manager.request(restUrl, method: .post, parameters: param.getParameters(), encoding: JSONEncoding.default)

        NSLog("Request Url : \(restUrl)")
        NSLog("Request Parameter: \(param.getParameters())")
        request.responseJSON { (response) in
            guard let json = response.result.value as? NSDictionary else {
                //서버에 접속할수 없는것은 에러
                actions[-1]?(NSDictionary())
                return
            }

            NSLog("Server Response: \(json)")
            let responseType = json["response"] as! Int
            actions[responseType]?(json)
        }
    }
}

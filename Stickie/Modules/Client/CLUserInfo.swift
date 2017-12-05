//
//  CLUserInfo.swift
//  Stickie
//
//  Created by CiaoLee on 2017. 12. 3..
//  Copyright © 2017년 CiaoLee. All rights reserved.
//

import Foundation
import CoreData

class CLUserInfo: ClientService {
    func saveUserInfo(accountPk: String, nickname: String) {
        // 기존값이 없다면 새로저장
        guard let userInfo = getUserInfo(accountPk) else {
            let info = self.getNewMo("UserInfo") as! UserInfoMO
            info.accountPk = accountPk
            info.nickname = nickname
            _ = self.commit()
            return
        }
        
        // 기존값이 존재한다면 수정해서 저장
        userInfo.nickname = nickname
        _ = self.commit()
    }
    
    func getNickname(accountPk: String) -> String {
        guard let userInfo = getUserInfo(accountPk) else {
            return ""
        }

        if let nickname = userInfo.nickname {
            return nickname
        } else  {
            return ""
        }
    }
    
    
    private func getUserInfo(_ accountPk: String) -> UserInfoMO? {
        let fetchRequest: NSFetchRequest<UserInfoMO> = UserInfoMO.fetchRequest() // 가저올 데이터 엔티티 정보입력
        let pred = NSPredicate(format: "accountPk = %@", accountPk)
        fetchRequest.predicate = pred
        
        // 값이 존재하지 않으면 새로운 값을 리턴한다
        guard let resultSet = try? context.fetch(fetchRequest) else {
            return nil
        }
        
        // 값이 존재하면 그 값을 리턴한다
        if resultSet.count == 0 {
            return nil
        } else {
            return resultSet[0]
        }
    }
}

//
//  CLAccount.swift
//  Stickie
//
//  Created by CiaoLee on 2017. 11. 11..
//  Copyright © 2017년 CiaoLee. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class CLAccount: ClientService {
    func getRecentlyAccount() -> (email: String, password: String, accountPk: String)? {
        let fetchRequest: NSFetchRequest<AccountMO> = AccountMO.fetchRequest() // 가저올 데이터 엔티티 정보입력
        let sort = NSSortDescriptor(key: "regdate", ascending: false)   // 최근데이터순으로 정렬
        let pred = NSPredicate(format: "user = true")
        fetchRequest.sortDescriptors = [sort]
        fetchRequest.predicate = pred
        
        do {
            let resultSet = try context.fetch(fetchRequest)
            // 최근 데이터만 한개만 리턴한다.
            if resultSet.count == 0 {
                // 가저온 데이터가 없다면 nil 값을 리턴한다.
                return nil
            }
            return (resultSet[0].email!, resultSet[0].password!, resultSet[0].accountPk!)
        } catch {
            // 기타 예외 사항이 생기면 nil 값을 리턴한다.
            return nil
        }
    }
    
    // 모든 로그인 데이터를 삭제한다.
    func removeUserInfo() {
        let fetchRequest: NSFetchRequest<AccountMO> = AccountMO.fetchRequest()
        let pred = NSPredicate(format: "user = true")
        fetchRequest.predicate = pred
        
        do {
            let resultSet = try context.fetch(fetchRequest)
            for account in resultSet {
                self.context.delete(account)
            }
            try context.save()
        } catch {
            context.rollback()
        }
    }
    
    func saveUserInfo(email: String, password: String, accountPk: String) -> Bool{
        let account = self.getNewMo("Account") as! AccountMO
        
        account.email = email
        account.password = password
        account.accountPk = accountPk
        account.user = true
        
        return self.commit()
    }
    
}



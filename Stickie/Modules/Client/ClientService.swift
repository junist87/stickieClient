//
//  ClientService.swift
//  Stickie
//
//  Created by CiaoLee on 2017. 11. 22..
//  Copyright © 2017년 CiaoLee. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class ClientService {
    // 데이터베이스 컨텍스트 로딩
    final let context: NSManagedObjectContext = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }()
    
    final func commit() -> Bool{
        do {
            try context.save()
            NSLog("코어데이터 업데이트됨")
            return true
        } catch {
            context.rollback()
            NSLog("코어데이터 업데이트 실패")
            return false
        }
    }
    
    final func delete(mo: NSManagedObject) -> Bool {
        context.delete(mo)
        return self.commit()
    }
    
    final func getNewMo(_ entityName: String) -> NSManagedObject {
        return NSEntityDescription.insertNewObject(forEntityName: entityName, into: context)
    }
}

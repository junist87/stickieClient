//
//  CLMapScrap.swift
//  Stickie
//
//  Created by CiaoLee on 2017. 12. 4..
//  Copyright © 2017년 CiaoLee. All rights reserved.
//

import Foundation
import CoreData


class CLMapScrap: ClientService {
    func insert(mapScrapList: [MapScrap]) {
        for mapScrap in mapScrapList {
            let mapScrapMO = self.getNewMo("MapGood") as! MapScrapMO
            mapScrapMO.mapPk = mapScrap.mapPk
            mapScrapMO.accountPk = mapScrap.accountPk
        }
        
        _ = self.commit()
    }
    
    func isScrap(mapPk: String, accountPk: String) -> Bool {
        let fetchRequest: NSFetchRequest<MapScrapMO> = MapScrapMO.fetchRequest()
        let pred = NSPredicate(format: "mapPk = %@ AND accountPk = %@", mapPk, accountPk)
        fetchRequest.predicate = pred
        
        do {
            guard let resultSet = try? context.fetch(fetchRequest) else {
                return false
            }
            if resultSet.count == 0 {
                return false
            } else {
                return true
            }
        }
    }

    func getScrapList(accountPk: String) -> [MapScrap] {
        let fetchRequest: NSFetchRequest<MapScrapMO> = MapScrapMO.fetchRequest()
        let pred = NSPredicate(format: "accountPk = %@", accountPk)
        fetchRequest.predicate = pred
        
        do {
            var response = [MapScrap]()
            guard let resultSet = try? context.fetch(fetchRequest) else {
                return response
            }
            
            for mapScrapMO in resultSet {
                response.append(MapScrap(mapPk: mapScrapMO.mapPk!, accountPk: mapScrapMO.accountPk!))
            }
            return response
        }
    }
    
    // 글의 모든데이터를 삭제한다
    func deleteAll(accountPk: String) {
        let fetchRequest: NSFetchRequest<MapScrapMO> = MapScrapMO.fetchRequest()
        let pred = NSPredicate(format: "accountPk = %@", accountPk)
        fetchRequest.predicate = pred
        
        do {
            guard let resultSet = try? context.fetch(fetchRequest) else {
                return
            }
            for mapGood in resultSet {
                context.delete(mapGood)
            }
            _ = self.commit()
        }
    }
}

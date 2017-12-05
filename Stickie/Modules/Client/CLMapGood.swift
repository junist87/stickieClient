//
//  CLMapGood.swift
//  Stickie
//
//  Created by CiaoLee on 2017. 12. 4..
//  Copyright © 2017년 CiaoLee. All rights reserved.
//

import Foundation
import CoreData

class CLMapGood: ClientService {
    func insert(mapGoodList: [MapGood]) {
        var mapPkList = [String]()
        for mapGood in mapGoodList {
            let mapGoodMO = self.getNewMo("MapGood") as! MapGoodMO
            mapGoodMO.mapPk = mapGood.mapPk
            mapGoodMO.accountPk = mapGood.accountPk
        }

        _ = self.commit()
    }

    func getGoodCount(mapPk: String) -> Int {
        let fetchRequest: NSFetchRequest<MapGoodMO> = MapGoodMO.fetchRequest()
        let pred = NSPredicate(format: "mapPk = %@", mapPk)
        fetchRequest.predicate = pred

        do {
            guard let resultSet = try? context.fetch(fetchRequest) else {
                return 0
            }
            return resultSet.count
        }
    }

    func isGood(mapPk: String, accountPk: String) -> Bool {
        let fetchRequest: NSFetchRequest<MapGoodMO> = MapGoodMO.fetchRequest()
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

    // 글의 모든데이터를 삭제한다
    func deleteAll(mapPk: String) {
        let fetchRequest: NSFetchRequest<MapGoodMO> = MapGoodMO.fetchRequest()
        let pred = NSPredicate(format: "mapPk = %@", mapPk)
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

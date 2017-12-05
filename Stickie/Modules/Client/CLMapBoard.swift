//
// Created by CiaoLee on 2017. 11. 27..
// Copyright (c) 2017 CiaoLee. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CLMapBoard: ClientService {


    // 데이터를 입력할때 사용하는 메소드
    func insert(mapPoint: MapPoint) -> Bool {
        // 중복값 검사

        // 중복이면 이미 있는 값에 대입
        guard isDuplicated(mapPk: mapPoint.pk) else {
            let map = getMapPointMO(mapPk: mapPoint.pk)!
            map.good = mapPoint.good
            map.contents = mapPoint.contents
            _ = self.commit()
            return false
        }

        // 중복이 아니면 새로운 값에 대입
        let map = self.getNewMo("MapBoard") as! MapBoardMO
        map.accountPk = mapPoint.accountPk
        map.contents = mapPoint.contents
        map.latitude = mapPoint.latitude
        map.longitude = mapPoint.longitude
        map.createDate = mapPoint.createDate
        map.pk = mapPoint.pk
        map.isRead = false
        map.good = mapPoint.good
        return self.commit()
    }

    func delete(mapPk: String) -> Bool {
        guard isDuplicated(mapPk: mapPk) else {
            return false
        }
        let fetchRequest: NSFetchRequest<MapBoardMO> = MapBoardMO.fetchRequest() // 가저올 데이터 엔티티 정보입력
        let pred = NSPredicate(format: "pk = %@", mapPk)
        fetchRequest.predicate = pred

        do {
            let resultSet = try! context.fetch(fetchRequest)
            for mapMo in resultSet {
                context.delete(mapMo)
            }
            return true
        }

    }


    func getMapPointList(latitude: Double, longitude: Double, degree: Double) -> [MapPoint] {
        let fetchRequest: NSFetchRequest<MapBoardMO> = MapBoardMO.fetchRequest()
        let pred = NSPredicate(format: "(%lf <= latitude) AND (latitude <= %lf) AND (%lf < longitude) AND (longitude <= %lf)", latitude - degree, latitude + degree, longitude - degree, longitude + degree)
        fetchRequest.predicate = pred

        do {
            let resultSet = try? context.fetch(fetchRequest)
            guard let result = resultSet else {
                return [MapPoint]()
            }
            return swapList(resultSet: result)
        }
    }

    func getMapPoint(mapPk: String) -> MapPoint? {
        let fetchRequest: NSFetchRequest<MapBoardMO> = MapBoardMO.fetchRequest()
        let pred = NSPredicate(format: "pk = %@", mapPk)
        fetchRequest.predicate = pred

        do {
            guard let resultSet = try? context.fetch(fetchRequest) else {
                return nil
            }

            if resultSet.count == 0 {
                return nil
            } else {
                return swapList(resultSet: resultSet)[0]
            }
        }
    }

    func getMapPointMO(mapPk: String) -> MapBoardMO? {
        let fetchRequest: NSFetchRequest<MapBoardMO> = MapBoardMO.fetchRequest()
        let pred = NSPredicate(format: "pk = %@", mapPk)
        fetchRequest.predicate = pred

        do {
            guard let resultSet = try? context.fetch(fetchRequest) else {
                return nil
            }

            if resultSet.count == 0 {
                return nil
            } else {
                return resultSet[0]
            }
        }
    }

    func setRead(mapPk: String, isRead: Bool) {
        let fetchRequest: NSFetchRequest<MapBoardMO> = MapBoardMO.fetchRequest()
        let pred = NSPredicate(format: "pk = %@", mapPk)
        fetchRequest.predicate = pred

        do {
            if let resultSet = try? context.fetch(fetchRequest) {
                if resultSet.count == 0 {
                    return
                }
                resultSet[0].isRead = isRead
                self.commit()

            }
        }
    }

    func isRead(mapPk: String) -> Bool {
        let fetchRequest: NSFetchRequest<MapBoardMO> = MapBoardMO.fetchRequest()
        let pred = NSPredicate(format: "pk = %@", mapPk)
        fetchRequest.predicate = pred

        do {
            if let resultSet = try? context.fetch(fetchRequest) {
                if resultSet.count == 0 {
                    return false
                }
                return resultSet[0].isRead
            }
        }
        return false
    }


    private func swapList(resultSet: [MapBoardMO]) -> [MapPoint] {
        NSLog("로컬 맵포인트 카운터 : \(resultSet.count)")
        var list = [MapPoint]()
        for mapPoint in resultSet {
            if let map = swapVo(mapBoard: mapPoint) {
                list.append(map)
            }
        }
        return list
    }

    private func swapVo(mapBoard: MapBoardMO) -> MapPoint? {
        if let pk = mapBoard.pk, let accountPk = mapBoard.accountPk, let contents = mapBoard.contents,
           let createDate = mapBoard.createDate {
            return MapPoint(pk: pk, accountPk: accountPk, contents: contents, createDate: createDate, latitude: mapBoard.latitude, longitude: mapBoard.longitude, good: mapBoard.good)
        }
        return nil
    }

    // 중복값 검사
    private func isDuplicated(mapPk: String) -> Bool {
        let fetchRequest: NSFetchRequest<MapBoardMO> = MapBoardMO.fetchRequest() // 가저올 데이터 엔티티 정보입력
        let pred = NSPredicate(format: "pk = %@", mapPk)
        fetchRequest.predicate = pred
        do {
            let resultSet = try? context.fetch(fetchRequest)
            if resultSet?.count == 0 {
                return true
            } else {
                return false
            }
        }
    }


}

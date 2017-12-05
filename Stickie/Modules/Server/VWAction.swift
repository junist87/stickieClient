//
// Created by CiaoLee on 2017. 11. 30..
// Copyright (c) 2017 CiaoLee. All rights reserved.
//

import Foundation


protocol VWAction {
    func success(_ response: NSDictionary) -> Void
    func fail(_ response: NSDictionary) -> Void
    func error(_ response: NSDictionary) -> Void
}



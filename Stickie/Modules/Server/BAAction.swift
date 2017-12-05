//
// Created by CiaoLee on 2017. 11. 29..
// Copyright (c) 2017 CiaoLee. All rights reserved.
//

import Foundation
import Alamofire

protocol BAAction {
    func success(response: NSDictionary)
    func fail(response: NSDictionary)
    func error(response: NSDictionary)
}

//
// Created by CiaoLee on 2017. 11. 30..
// Copyright (c) 2017 CiaoLee. All rights reserved.
//

import Foundation
import Alamofire

class ParameterMaker {
    private var param = Parameters()

    func addParameter(key: String, value: Any) {
        param[key] = value
    }

    func getParameters() -> Parameters {
        return self.param
    }
}

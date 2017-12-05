//
// Created by CiaoLee on 2017. 11. 29..
// Copyright (c) 2017 CiaoLee. All rights reserved.
//

import Foundation

class ActionDictionaryHandler {
    let baSuccess: (NSDictionary)  -> Void
    let vwSuccess: (NSDictionary) -> Void

    let baFail: (NSDictionary) -> Void
    let vwFail: (NSDictionary) -> Void

    let baError: (NSDictionary)  -> Void
    let vwError: (NSDictionary) -> Void


    init (baActions: BAAction, vwActions: VWAction) {
        self.baSuccess = baActions.success
        self.vwSuccess = vwActions.success

        self.baFail = baActions.fail
        self.vwFail = vwActions.fail

        self.baError = baActions.error
        self.vwError = vwActions.error
    }

    func getActions() -> [Int: (NSDictionary) -> Void] {
        var actions = [Int: (NSDictionary) -> Void]()
        actions[0] = success
        actions[1] = fail
        actions[-1] = error
        return actions
    }

    private func success(response: NSDictionary) {
        baSuccess(response)
        vwSuccess(response)
    }

    private func fail(response: NSDictionary) {
        baFail(response)
        vwFail(response)
    }

    private func error(response: NSDictionary) {
        baError(response)
        vwError(response)
    }
}

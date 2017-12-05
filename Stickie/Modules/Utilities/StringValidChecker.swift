//
//  StringValidChecker.swift
//  Stickie
//
//  Created by CiaoLee on 2017. 11. 10..
//  Copyright © 2017년 CiaoLee. All rights reserved.
//

import Foundation

class StringValidChecker {
    func checkEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }

    func checkNickname(nickname: String) -> Bool {
        return true
    }

    //
    func checkPassword(password: String) -> Bool {
        return true
    }
    
    func checkCertificationKey(key: String) -> Bool {
        return true
    }

}

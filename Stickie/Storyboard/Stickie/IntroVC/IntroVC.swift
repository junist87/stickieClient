//
//  IntroVC.swift
//  Stickie
//
//  Created by CiaoLee on 2017. 11. 23..
//  Copyright © 2017년 CiaoLee. All rights reserved.
//

import UIKit

class IntroVC: UIViewController {
    @IBOutlet var imgAppIcon: UIImageView!
    
    override func viewDidAppear(_ animated: Bool) {
        //accountService.deleteUserInfo()   // 로그인 정보를 삭제하고 싶을때.. 테스트용. 실제로는 주석처리 해놔야 한다.
        let vwActions = IntroVCVWAction(self)
        let clAccount = CLAccount()
        if let account = clAccount.getRecentlyAccount() {
            AccountService().login(email: account.email, password: account.password, vwActions: vwActions)
        } else {
            vwActions.moveLoginVC()
        }
    }




}

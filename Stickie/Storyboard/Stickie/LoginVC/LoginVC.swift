//
//  LoginVC.swift
//  Stickie
//
//  Created by CiaoLee on 2017. 11. 23..
//  Copyright © 2017년 CiaoLee. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    // Interface Builder
    @IBOutlet var txEmail: UITextField!
    @IBOutlet var txPassword: UITextField!
    @IBOutlet var viewCertification: CertificationUIView!
    @IBOutlet var viewJoin: JoinUIView!
    @IBOutlet var viewForgot: ForgotUIView!


    // viewer
    lazy var viewJoinBg: BgUIView! = {
        return BgUIView(rootVC: self, innerView: viewJoin, innerViewPosition: InnerViewPosition.Center)
    }()
    lazy var viewCertiBg: BgUIView! = {
        return BgUIView(rootVC: self, innerView: viewCertification, innerViewPosition: InnerViewPosition.Center)
    }()
    lazy var viewForgotBg: BgUIView! = {
        return BgUIView(rootVC: self, innerView: viewForgot, innerViewPosition: InnerViewPosition.Center)
    }()
    lazy var indicator: IndicatorUIView = {
        return IndicatorUIView(rootVC: self, message: "로그인중입니다.")
    }()


    // required functions
    let accountService = AccountService()


    /*******************
     * 뷰 컨트롤러 기능들 *
     *******************
    */
    @IBAction func btLogin(_ sender: Any) {
        // 키보드를 숨긴다
        view.endEditing(true)

        // 모든값이 제대로 입력되었다면 서버에 접속한다.
        if let properties = getProperties() {
            indicator.show()     // 인디케이터를 시작한다.
            accountService.login(email: properties.email, password: properties.password,
                    vwActions: LoginVCVWAction(indication: indicator, viewCertiBg: viewCertiBg, rootVC: self))
        }
    }

    @IBAction func btJoin(_ sender: Any) {
        viewJoinBg.show()
    }

    @IBAction func btForgot(_ sender: Any) {
        viewForgotBg.show()
    }

    func showCertificationView() {
        viewCertiBg.show()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    // 유효성 검사하는 곳
    func getProperties() -> (email: String, password: String)? {
        let email = txEmail!.text
        let pass = txPassword!.text
        if txEmail.text?.count == 0 || txPassword.text?.count == 0 {
            let alert = AlertLibrary().popAlertMessage(message: "이메일, 패스워드 모두 입력하여 주십시오")
            present(alert, animated: true)
            return nil
        }

        // 여기에 valid 체크하기

        return (email!, pass!)
    }
}


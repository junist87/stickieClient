//
//  JoinUIView.swift
//  Stickie
//
//  Created by CiaoLee on 2017. 11. 23..
//  Copyright © 2017년 CiaoLee. All rights reserved.
//

import UIKit

class JoinUIView: InnerUIView, UITextFieldDelegate {
    @IBOutlet var txEmail: UITextField!
    @IBOutlet var txPassword: UITextField!
    @IBOutlet var txNickname: UITextField!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setDefaultLayer()
 
    }

    // 뷰가 화면에 등장할 때
    override func whenInnerViewShow() {
        txNickname?.text = ""
        txPassword?.text = ""
        txEmail?.text = ""
        
        txNickname?.delegate = self
        txPassword?.delegate = self
        txEmail?.delegate = self
    }

    // 기본설정
    private func setDefaultLayer() {
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 0.5
    }
    
    // 배경을 클릭했을때
    override func askExit() -> Bool{
        if txEmail.text?.count != 0 || txNickname.text?.count != 0 || txPassword.text?.count != 0 {
            return true
        }
        return false
    }
    
    // 가입버튼을 눌렀을때
    @IBAction func btJoin(_ sender: Any) {
        endEditing(true)
        guard let properties = getProperties() else {
            return
        }
        // 인디케이터 시작
        indicator.show()

        // 서버 연결
        let vwActions = JoinVWAction(indicator: indicator, hide: hide, rootVC: rootVC)
        AccountService().join(email: properties.email, password: properties.password, nickname: properties.nickname, vwActions: vwActions)
    }
    
    // 뷰의 값을 가져오는 메소드
    func getProperties() -> (email: String, password: String, nickname: String)? {
        // 모든 텍스트 체크가 끝나면 정상값을 리턴한다.
        let validChecker = StringValidChecker()
        if validChecker.checkEmail(email: txEmail.text!) &&
            validChecker.checkNickname(nickname: txNickname.text!) &&
            validChecker.checkPassword(password: txPassword.text!) {
            return (txEmail.text!, txPassword.text!, txNickname.text!)
        } else {
            return nil
        }
    }
    

}

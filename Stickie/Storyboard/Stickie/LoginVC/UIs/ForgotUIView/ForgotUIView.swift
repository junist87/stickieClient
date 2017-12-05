//
//  ForgotUIView.swift
//  Stickie
//
//  Created by CiaoLee on 2017. 11. 23..
//  Copyright © 2017년 CiaoLee. All rights reserved.
//

import UIKit

class ForgotUIView: InnerUIView, UITextFieldDelegate {
    @IBOutlet var txEamil: UITextField!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setDefaultLayer()
        
    }
    
    override func whenInnerViewShow() {
        txEamil?.delegate = self
        txEamil?.text = ""
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
        if txEamil.text?.count != 0 {
            return true
        }
        return false
    }
    
    @IBAction func btSend(_ sender: Any) {
        // 키보드를 숨긴다
        endEditing(true)
        
        guard let email = getProperties() else {
            let alert = AlertLibrary().popAlertMessage(message: "잘못된 이메일 입니다.")
            rootVC.present(alert, animated: true)
            return
        }
        
        // 서버접속 시작
        indicator.show()
        let vwActions = ForgotVWAction(indicator: indicator, hide: hide, rootVC: rootVC)
        AccountService().forgot(email: email, vwActions: vwActions)
    }
    
    func getProperties() -> String? {
        let validChecker = StringValidChecker()
        if validChecker.checkEmail(email: (txEamil?.text)!) {
            return (txEamil?.text)!
        }
        return nil
    }

}

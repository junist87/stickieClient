//
//  CertificationUIView.swift
//  Stickie
//
//  Created by CiaoLee on 2017. 11. 23..
//  Copyright © 2017년 CiaoLee. All rights reserved.
//

import UIKit

class CertificationUIView: InnerUIView, UITextFieldDelegate {

    @IBOutlet var txKey: UITextField!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setDefaultLayer()
    }

    // 화면에 등록되었을때
    override func whenInnerViewShow() {
        txKey?.delegate = self
        txKey?.text = ""
    }

    // 기본설정
    private func setDefaultLayer() {
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 0.5
    }

    // 배경을 클릭했을때
    override func askExit() -> Bool {
        if txKey.text?.count != 0 {
            return true
        }
        return false
    }

    @IBAction func btCheck(_ sender: Any) {
        guard let properties = getProperties() else {
            AlertLibrary().popAlertMessage(message: "잘못된 인증키 입니다", rootVC: rootVC)
            return
        }

        // 서버접속 시작
        indicator.show()
        let vwActions = CertificationUIViewVWAction(indicator: indicator, hide: hide, rootVC: rootVC)
        AccountService().certification(email: properties.email, password: properties.password, key: properties.key, vwActions: vwActions)
    }

    func getProperties() -> (email: String, password: String, key: String)? {
        
        // 룰 체크
        let validChecker = StringValidChecker()
        
        // 임시 저장소에서 데이터 가져오기
        let appStrage = DataBank().getAppStorage()
        let properties = (email: appStrage.email, password: appStrage.password)
        
        // 키 유효성 검사
        if validChecker.checkCertificationKey(key: (txKey?.text)!)
                   && validChecker.checkEmail(email: properties.email)
                   && validChecker.checkPassword(password: properties.password) {
            return (properties.email, properties.password, (txKey?.text)!)
        }
        // 유효하지 않으면 nil
        return nil
    }

}

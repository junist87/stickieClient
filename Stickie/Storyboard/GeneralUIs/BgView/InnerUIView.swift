//
//  InnerView.swift
//  Stickie
//
//  Created by CiaoLee on 2017. 11. 25..
//  Copyright © 2017년 CiaoLee. All rights reserved.
//

import UIKit

class InnerUIView: UIView {
    var rootVC: UIViewController!
    var hide: (()->Void)!
    lazy var indicator: IndicatorUIView = {
        return IndicatorUIView(rootVC: rootVC, message: "서버에 접속중입니다")
    }()
    private var swtUIMoved = false
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: NSNotification.Name.UIKeyboardWillShow,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardHide),
            name: NSNotification.Name.UIKeyboardWillHide,
            object: nil
        )
    }
    
    // 키보드가 나올때
    @objc func keyboardWillShow(_ notification: Notification) {
        var moveHeight: CGFloat!
        let wholeViewHeight = UIScreen.main.bounds.height
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            moveHeight = (wholeViewHeight - keyboardHeight)/4
            
        }
        
        if swtUIMoved == false {
            UIView.animate(withDuration: TimeInterval(0.2)) {
                self.center.y -= moveHeight
            }
            swtUIMoved = true
        }
    }
    
    // 키보드가 사라질때
    @objc func keyboardHide(_ notification: Notification) {
        var moveHeight: CGFloat!
        let wholeViewHeight = UIScreen.main.bounds.height
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            moveHeight = (wholeViewHeight - keyboardHeight)/4
            
        }
        
        if swtUIMoved == true {
            UIView.animate(withDuration: TimeInterval(0.2)) {
                self.center.y += moveHeight
            }
            swtUIMoved = false
        }
    }
    
    // 아무대나 클릭했을 때
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        endEditing(true)
    }
    
    func askExit() -> Bool {
        return false
    }
    
    func whenInnerViewShow() {
        
    }

    func whenInnerViewHide() {

    }
}

//
//  WriterUIView.swift
//  Stickie
//
//  Created by CiaoLee on 2017. 11. 24..
//  Copyright © 2017년 CiaoLee. All rights reserved.
//

import UIKit
import CoreLocation


class WriterUIView: InnerUIView, UITextViewDelegate {
    // interface builder
    @IBOutlet var txContents: UITextView!
    @IBOutlet var imgPicker: UIImageView!
    @IBOutlet var lbCounter: UILabel!

    // textView
    var swtEdited = false

    // 위치정보
    let appStorage = DataBank().getAppStorage()

    required init?(coder aDecoder: NSCoder) {
        // 변수 초기화
        super.init(coder: aDecoder)

        // 뷰의 기본형태 지정
        setDefault()

    }

    override func whenInnerViewShow() {
        txContents.layer.borderWidth = 0.5
        txContents.layer.borderColor = UIColor.gray.cgColor
        txContents.text = "무슨생각을 하고 계신가요?"
        txContents.textColor = UIColor.gray
        txContents.delegate = self
        swtEdited = false
    }

    func setDefault() {
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 0.5
    }


    func textViewDidChange(_ textView: UITextView) {
        if swtEdited == false {
            swtEdited = true
            txContents.textColor = UIColor.black
            txContents.text = ""
        }

        // 글 카운터
        lbCounter.text = "\(textView.text.count)/100"
        lbCounter.textColor = textView.text.count >= 100 ? UIColor.red : UIColor.gray

        // 105자 이상 쓰면 입력을 취소한다.
        // 나중에 기능 만들기
    }

    // 앤터키를 눌렀을 때
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            commit()
            return false
        }
        return true
    }

    @IBAction func btCommit(_ sender: Any) {
        commit()
    }

    override func askExit() -> Bool {
        if txContents.text.count == 0 || swtEdited {
            return true
        } else {
            return false
        }
    }

    func commit() {
        guard let properties = getProperties() else {
            AlertLibrary().popAlertMessage(message: "위치정보가 없음", rootVC: rootVC)
            return
        }

        let mapBoardService = MapBoardService()
        DataBank().getAppStorage().centerLocation = nil // 중심주소를 빈값으로 바꾸면 맵이 리퀘스트 실행한다..
        let vwActions = WriterVWAction(indicator: indicator, hide: hide, rootVC: rootVC)
        mapBoardService.uploadStickie(contents: properties.contents, latitude: properties.latitude, longitude: properties.longitude, vwActions: vwActions)
    }


    private func getProperties() -> (contents: String, latitude: Double, longitude: Double)? {
        guard let location = appStorage.currentLocation else {
            NSLog("위치정보를 가져올수 없음")
            return nil
        }

        let latitude: Double = location.coordinate.latitude
        let longitude: Double = location.coordinate.longitude
        let contents = (txContents?.text)!

        return (contents, latitude, longitude)

    }
}

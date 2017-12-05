//
//  ReaderUIView.swift
//  Stickie
//
//  Created by CiaoLee on 2017. 11. 24..
//  Copyright © 2017년 CiaoLee. All rights reserved.
//

import UIKit

class ReaderUIView: InnerUIView {

    @IBOutlet var txContents: UITextView!
    @IBOutlet var lbCounter: UILabel!
    @IBOutlet var lbNickname: UILabel!
    @IBOutlet var lbCreateDate: UILabel!
    @IBOutlet var imgGood: UIImageView!

    // 시스템
    let clUserInfo = CLUserInfo()
    let clMapBoard = CLMapBoard()
    let clAccount = CLAccount()
    let clMapGood = CLMapGood()
    let mapBoardService = MapBoardService()
    var mapPk: String!
    var swtGood: Bool!


    // 뷰어에 보일 정보
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setDefault()
    }

    override func whenInnerViewShow() {
        imgGood.isUserInteractionEnabled = true
        imgGood.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickGoodButton)))
    
    }

    func setDefault() {
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 0.5
    }

    func viewMapPointDetail(mapPk pk: String) {
        self.mapPk = pk
        guard let map = clMapBoard.getMapPoint(mapPk: pk) else {
            return
        }
        let nickname = clUserInfo.getNickname(accountPk: map.accountPk)
        // 컨텐츠 표시
        txContents.text = map.contents
        // 닉네임 표시
        lbNickname.text = "Writer : \(nickname)"

        // 날짜 표시
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy.dd.MM"
        lbCreateDate.text = dateFormatter.string(from: map.createDate)

        // 좋아요 표시
        lbCounter.text = "좋아요: \(clMapGood.getGoodCount(mapPk: map.pk))개"

        // 좋아요 버튼상태
        let userAccountPk = clAccount.getRecentlyAccount()!
        self.swtGood = clMapGood.isGood(mapPk: map.pk, accountPk: userAccountPk.accountPk)
        setGoodStatus()
    }

    func setGoodStatus() {
        var imgName: String!
        if swtGood {
            imgName = "good.png"
        } else {
            imgName = "notgood.png"
        }
        imgGood.image = UIImage(named: imgName)
    }


    func refresh() {
        viewMapPointDetail(mapPk: self.mapPk)
    }

    @objc func clickGoodButton() {
        let vwActions = ReaderGoodVWAction(refresh: refresh, indicator: indicator)

        indicator.show()

        if swtGood {
            mapBoardService.downgradeGood(mapPk: self.mapPk, vwActions: vwActions)
        } else {
            mapBoardService.upgradeGood(mapPk: self.mapPk, vwActions: vwActions)
        }
    }

}

//
//  VCLoader.swift
//  Stickie
//
//  Created by CiaoLee on 2017. 11. 16..
//  Copyright © 2017년 CiaoLee. All rights reserved.
//

import Foundation
import UIKit

class VCLoader {
    let defaultModalTransitionStyle = UIModalTransitionStyle.crossDissolve

    public func getVC(vcName: String, storyboardName: String) -> UIViewController? {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let getVc = storyboard.instantiateViewController(withIdentifier: vcName)
        getVc.modalTransitionStyle = self.defaultModalTransitionStyle
        return getVc
    }

    public func getVC(vcName: String, storyboard: UIStoryboard) -> UIViewController {
        let getVc = storyboard.instantiateViewController(withIdentifier: vcName)
        getVc.modalTransitionStyle = self.defaultModalTransitionStyle
        return getVc
    }

    public func getInitialVC(storyboardName: String) -> UIViewController? {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        guard let mainVC = storyboard.instantiateInitialViewController() else {
            return nil
        }
        mainVC.modalTransitionStyle = .crossDissolve
        return mainVC
    }

}

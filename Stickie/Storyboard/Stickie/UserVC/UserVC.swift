//
// Created by CiaoLee on 2017. 12. 4..
// Copyright (c) 2017 CiaoLee. All rights reserved.
//

import Foundation
import UIKit

class UserVC: UIViewController {
    @IBOutlet var lbNickname: UILabel!
    @IBOutlet var lbEmail: UILabel!
    
    
    @IBOutlet var txRePass: UITextField!
    @IBOutlet var txNewPass: UITextField!
    @IBOutlet var txOldPass: UITextField!
    
    @IBAction func btBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBOutlet var btCommit: DefaultBorderLayerButton!
}

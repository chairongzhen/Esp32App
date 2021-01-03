//
//  ResetViewController.swift
//  ppLedc
//
//  Created by 柴荣臻 on 2021/1/1.
//  Copyright © 2021 rzchai. All rights reserved.
//

import UIKit

class ResetViewController: UIViewController {

 
    @IBOutlet weak var switchConfirm: UISwitch!
    @IBOutlet weak var btnNext: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        switchConfirm.isOn = false
        switchConfirm.thumbTintColor = UIColor(hexString: "#f79e44")
        switchConfirm.onTintColor = UIColor(hexString: "#f68717")
        btnNext.isHidden = true
    }


}

extension ResetViewController {
    @IBAction func onBtnAddClick(_ sender: Any) {
        let step3 = SelectWiFiViewController()
        self.navigationController!.pushViewController(step3, animated: true)
    }
    @IBAction func onConfirm(_ sender: Any) {
        if switchConfirm.isOn {
            btnNext.isHidden = false
        } else {
            btnNext.isHidden = true
        }
    }
}

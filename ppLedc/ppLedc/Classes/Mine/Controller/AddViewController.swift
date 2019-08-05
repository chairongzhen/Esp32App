//
//  AddViewController.swift
//  ppLedc
//
//  Created by 柴荣臻 on 2019/8/4.
//  Copyright © 2019 rzchai. All rights reserved.
//

import UIKit

class AddViewController: PPAlertBaseViewController {

    @IBOutlet weak var txtAdd: UITextField!
    @IBOutlet weak var btnAdd: UIButton!

    @IBOutlet weak var btnScan: UIButton!
    private lazy var myViewModel : MyViewModel = MyViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // 点击屏幕收起键盘
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension AddViewController {
    private func setupUI() {
        txtAdd.layer.borderColor = UIColor.orange.cgColor
        txtAdd.layer.borderWidth = 1
    }
    
    private func bindMid(mid : String) {
        let openid: String = self.getOpenid()
        if openid == "" { return }
        myViewModel.bindMid(openid: openid, mid: mid) { (message) in
            if message == "success" {
                print("machine name: \(mid) has added")
                self.autoHideAlertMessage(message: "添加成功")
                } else {
                self.autoHideAlertMessage(message: message)
                }
            }
        }
}

extension AddViewController {
    @IBAction func btnAddClicked(_ sender: Any) {
        if txtAdd.text == "" {
            self.autoHideAlertMessage(message: "设备号不能为空")
            return;
        }
        let mid = "esp_" + txtAdd.text!.uppercased()
        if !self.checkEspId(input: mid) {
                self.autoHideAlertMessage(message: "设备号格式有误,请检查后重新输入")
                txtAdd.text = ""
                return;
            } else {
                bindMid(mid: mid)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue:"binded"), object: nil, userInfo: nil)
                txtAdd.text = ""
                let pageContentView : PageContentView = self.locatePageContentView(currentView: self)
                let mainViewController : MineViewController = self.locateMainController(currentView: pageContentView) as! MineViewController
                mainViewController.changeTitleIndex(sourceIndex: 0, targetIndex: 1)
                pageContentView.setCurrentIndex(currentIndex: 1)
            }

    }
    @IBAction func btnScanClicked(_ sender: Any) {
        let pageContentView : PageContentView = self.locatePageContentView(currentView: self)
        let mainViewController : MineViewController = self.locateMainController(currentView: pageContentView) as! MineViewController
        mainViewController.changeTitleIndex(sourceIndex: 1, targetIndex: 2)
        pageContentView.setCurrentIndex(currentIndex: 2)
    }
    
}

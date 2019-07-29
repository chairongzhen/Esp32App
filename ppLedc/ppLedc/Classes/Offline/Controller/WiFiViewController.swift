//
//  WiFiViewController.swift
//  ppLedc
//
//  Created by 柴荣臻 on 2019/7/29.
//  Copyright © 2019 rzchai. All rights reserved.
//

import UIKit

class WiFiViewController: PPAlertBaseViewController {

    @IBOutlet weak var txtSsid: UITextField!
    @IBOutlet weak var txtPwd: UITextField!
    @IBOutlet weak var btnConnect: UIButton!
    
    private lazy var offlineViewModel : OfflineViewModel = OfflineViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "WiFi设置"
        getSsidInfo()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 跳转页面的导航 不隐藏 false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

}

extension WiFiViewController {
    @IBAction func btnSave(_ sender: Any) {
        if txtSsid.text == "" {
            self.autoHideAlertMessage(message:  "ssid不能为空")
            return;
        }
        
        if txtPwd.text == "" {
            self.autoHideAlertMessage(message:  "密码不能为空")
            return;
        }
        
        offlineViewModel.settingWiFi(ssid: txtSsid.text!, pwd: txtPwd.text!) { (message) in
            print("message")
        }
    }
    
    private func getSsidInfo() {
        let ssidinfo = UserDefaults.standard
        let ssid: Any? = ssidinfo.object(forKey: "ssid")
        let pwd: Any? = ssidinfo.object(forKey: "pwd")
        if ssid != nil {
            self.txtSsid.text = ssid as? String
            self.txtPwd.text = pwd as? String
        }
    }
}

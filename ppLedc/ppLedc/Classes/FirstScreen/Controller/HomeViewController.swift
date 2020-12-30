//
//  HomeViewController.swift
//  ppLedc
//
//  Created by 柴荣臻 on 2020/8/2.
//  Copyright © 2020 rzchai. All rights reserved.
//

import UIKit
private var openid : String = ""



class HomeViewController: PPAlertBaseViewController {
    
    @IBOutlet weak var lbUserName: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var btnOpen: UIButton!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var btnRepeat: UIButton!
    let nickname = UserDefaults.standard.value(forKey: "nickname")
    private lazy var settingVM: SettingViewModel = SettingViewModel()
    private lazy var fixViewModel : FixViewModel = FixViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(upDataChange(notif:)), name: NSNotification.Name(rawValue: "settingchanged"), object: nil)
        openid = self.getOpenid()
        getSettingData()
        setupUI()
    }
    
}

extension HomeViewController {
    
    
    private func setupUI() {
        lbUserName.text =  nickname as? String
    }
}

extension HomeViewController {
    @IBAction func goMain(_ sender: Any) {
//        let sb = UIStoryboard(name: "Repeat", bundle: nil)
//        let destination = sb.instantiateViewController(withIdentifier: "Repeat")
//        //跳转
//        self.navigationController?.pushViewController(destination, animated: true)
        setRepeat()
    }
    @IBAction func onOpen(_ sender: Any) {
        setFix(Type: true)
    }
    
    @IBAction func onOff(_ sender: Any) {
        setFix(Type: false)
    }
    
    @objc func upDataChange(notif: NSNotification){
        getSettingData()
    }
}


extension HomeViewController {
    private func getSettingData() {
        settingVM.getSetting(openid: openid) { (message) in
            if message == "success" {
                let myset : Setting  = self.settingVM.setting
                if myset.repeatMode == "repeat" {
                    self.btnRepeat.backgroundColor = UIColor.init(hexString: "#b34a4a")
                    self.btnOpen.setTitleColor(UIColor(hexString: "#a7a7a7"), for: .normal)
                    self.btnClose.setTitleColor(UIColor(hexString: "#a7a7a7"), for: .normal)
                } else {
                    self.btnRepeat.backgroundColor = UIColor.init(hexString: "#a7a7a7")
                    self.getFixData();
                }
            } else {
                return
            }
        }
    }
    
    private func getFixData()  {
        let openid: String = self.getOpenid()
        fixViewModel.getFixData(openid: openid) { (message) in
            if message == "success" {
                if Float(self.fixViewModel.fixData.l1) == 0 && Float(self.fixViewModel.fixData.l2) == 0 && Float(self.fixViewModel.fixData.l3) == 0 && Float(self.fixViewModel.fixData.l4) == 0 && Float(self.fixViewModel.fixData.l5) == 0 && Float(self.fixViewModel.fixData.l6) == 0 && Float(self.fixViewModel.fixData.l7) == 0 && Float(self.fixViewModel.fixData.l8) == 0 {
                    self.btnOpen.setTitleColor(UIColor(hexString: "#a7a7a7"), for: .normal)
                    self.btnClose.setTitleColor(UIColor(hexString: "#e05d5d"), for: .normal)
                } else if Float(self.fixViewModel.fixData.l1) == 100 && Float(self.fixViewModel.fixData.l2) == 100 && Float(self.fixViewModel.fixData.l3) == 100 && Float(self.fixViewModel.fixData.l4) == 100 && Float(self.fixViewModel.fixData.l5) == 100 && Float(self.fixViewModel.fixData.l6) == 100 && Float(self.fixViewModel.fixData.l7) == 100 && Float(self.fixViewModel.fixData.l8) == 100 {
                    self.btnOpen.setTitleColor(UIColor(hexString: "#e05d5d"), for: .normal)
                    self.btnClose.setTitleColor(UIColor(hexString: "#a7a7a7"), for: .normal)
                } else {
                    self.btnOpen.setTitleColor(UIColor(hexString: "#a7a7a7"), for: .normal)
                    self.btnClose.setTitleColor(UIColor(hexString: "#a7a7a7"), for: .normal)
                }
                
                
            } else {
                self.autoHideAlertMessage(message: message)
            }
        }
    }
    
    
    
    private func setFix(Type isOpen: Bool){
        let openid: String = self.getOpenid()
        if openid == "" { return }
        let value = isOpen ? "100" : "0"
        fixViewModel.updateFix(openid: openid, l1: value, l2: value, l3: value, l4: value, l5: value, l6: value, l7: value, l8: value) { (message) in
            if message == "success" {
                self.btnRepeat.backgroundColor = UIColor.init(hexString: "#a7a7a7")
                if isOpen {
                    self.btnOpen.setTitleColor(UIColor(hexString: "#e05d5d"), for: .normal)
                    self.btnClose.setTitleColor(UIColor(hexString: "#a7a7a7"), for: .normal)
                } else {
                    self.btnOpen.setTitleColor(UIColor(hexString: "#a7a7a7"), for: .normal)
                    self.btnClose.setTitleColor(UIColor(hexString: "#e05d5d"), for: .normal)
                }
                self.settingVM.updateSetting(openid: openid, repeatMode: "fix", productionMode: "production", autoUpdateMode: "none") { (message) in
                    if message == "success" {
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue:"settingchanged"), object: nil, userInfo: nil)
                    } else {
                        self.autoHideAlertMessage(message: message)
                    }
                }
                
            } else {
                self.autoHideAlertMessage(message: message)
            }
        }
    }
    
    private func setRepeat() {
        self.settingVM.updateSetting(openid: openid, repeatMode: "repeat", productionMode: "production", autoUpdateMode: "none") { (message) in
            if message == "success" {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue:"settingchanged"), object: nil, userInfo: nil)
            } else {
                self.autoHideAlertMessage(message: message)
            }
        }
    }
}

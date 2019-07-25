//
//  FixViewController.swift
//  ppLedc
//
//  Created by 柴荣臻 on 2019/7/20.
//  Copyright © 2019 rzchai. All rights reserved.
//

import UIKit

class FixViewController: PPAlertBaseViewController {
    private lazy var lightSetting : LightSettingView = {
        let settingView = LightSettingView.lightSettingView()
        settingView.frame = view.bounds
        settingView.txtOne.addTarget(self, action: #selector(txtOneChanged(_:)), for: .allEditingEvents)
        settingView.txtTwo.addTarget(self, action: #selector(txtTwoChanged(_:)), for: .allEditingEvents)
        settingView.txtThree.addTarget(self, action: #selector(txtThreeChanged(_:)), for: .allEditingEvents)
        settingView.txtFour.addTarget(self, action: #selector(txtFourChanged(_:)), for: .allEditingEvents)
        settingView.txtFive.addTarget(self, action: #selector(txtFiveChanged(_:)), for: .allEditingEvents)
        settingView.txtSix.addTarget(self, action: #selector(txtSixChanged(_:)), for: .allEditingEvents)
        settingView.txtSeven.addTarget(self, action: #selector(txtSevenChanged(_:)), for: .allEditingEvents)
        settingView.txtEight.addTarget(self, action: #selector(txtEightChanged(_:)), for: .allEditingEvents)
        
        settingView.btnOpenAll.setImage(UIImage(named: "openall")?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        settingView.btnCloseAll.setImage(UIImage(named: "closeall")?.withRenderingMode(.alwaysOriginal), for: .normal)
        getFixData()
        return settingView
    }()
    private lazy var fixViewModel : FixViewModel = FixViewModel()
    var button : UIButton = UIButton()
    var textField : UITextField = UITextField()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
}

extension FixViewController {
    private func getFixData() {
        let openid: String = self.getOpenid()
        if openid == "" { return }
        fixViewModel.getFixData(openid: openid) { (message) in
            if message == "success" {
                self.lightSetting.sliderOne.setValue(Float(self.fixViewModel.fixData.l1), animated: true)
                self.lightSetting.sliderTwo.setValue(Float(self.fixViewModel.fixData.l2), animated: true)
                self.lightSetting.sliderThree.setValue(Float(self.fixViewModel.fixData.l3), animated: true)
                self.lightSetting.sliderFour.setValue(Float(self.fixViewModel.fixData.l4), animated: true)
                self.lightSetting.sliderFive.setValue(Float(self.fixViewModel.fixData.l5), animated: true)
                self.lightSetting.sliderSix.setValue(Float(self.fixViewModel.fixData.l6), animated: true)
                self.lightSetting.sliderSeven.setValue(Float(self.fixViewModel.fixData.l7), animated: true)
                self.lightSetting.sliderEight.setValue(Float(self.fixViewModel.fixData.l8), animated: true)
                
                self.lightSetting.txtOne.text = String(self.fixViewModel.fixData.l1)
                self.lightSetting.txtTwo.text = String(self.fixViewModel.fixData.l2)
                self.lightSetting.txtThree.text = String(self.fixViewModel.fixData.l3)
                self.lightSetting.txtFour.text = String(self.fixViewModel.fixData.l4)
                self.lightSetting.txtFive.text = String(self.fixViewModel.fixData.l5)
                self.lightSetting.txtSix.text = String(self.fixViewModel.fixData.l6)
                self.lightSetting.txtSeven.text = String(self.fixViewModel.fixData.l7)
                self.lightSetting.txtEight.text = String(self.fixViewModel.fixData.l8)
            } else {
                self.autoHideAlertMessage(message: message)
            }
        }
        
    }
    
    private func updateFix() {
        let openid: String = self.getOpenid()
        if openid == "" { return }
        fixViewModel.updateFix(openid: openid, l1: self.lightSetting.txtOne.text!, l2: self.lightSetting.txtTwo.text!, l3: self.lightSetting.txtThree.text!, l4: self.lightSetting.txtFour.text!, l5: self.lightSetting.txtFive.text!, l6: self.lightSetting.txtSix.text!, l7: self.lightSetting.txtSeven.text!, l8: self.lightSetting.txtEight.text!) { (message) in
            if message == "success" {
                
            } else {
                self.autoHideAlertMessage(message: message)
            }
        }
    }
}

extension FixViewController {
    private func setupUI() {
        self.view.addSubview(lightSetting)
    }
    
    @objc func textChange(_ textField:UITextField) {
        let textField : UITextField = textField
        print(textField)
    }
    
    @objc func txtOneChanged(_ textField:UITextField) {
        guard var value = textField.text else {
            return
        }
        if(value == "") {
            return
        }
        if Int(value)! < 0 {
            value = "0"
            lightSetting.txtOne.text = "0"
        } else if Int(value)! > 100 {
            value = "100"
            lightSetting.txtOne.text = "100"
        }
        lightSetting.sliderOne.setValue(Float(value)!,animated:true)
        updateFix()
    }
    
    @objc func txtTwoChanged(_ textField:UITextField) {
        guard var value = textField.text else {
            return
        }
        if(value == "") {
            return
        }
        if Int(value)! < 0 {
            value = "0"
            lightSetting.txtTwo.text = "0"
        } else if Int(value)! > 100 {
            value = "100"
            lightSetting.txtTwo.text = "100"
        }
        lightSetting.sliderTwo.setValue(Float(value)!,animated:true)
        updateFix()
    }
    
    @objc func txtThreeChanged(_ textField:UITextField) {
        guard var value = textField.text else {
            return
        }
        if(value == "") {
            return
        }
        if Int(value)! < 0 {
            value = "0"
            lightSetting.txtThree.text = "0"
        } else if Int(value)! > 100 {
            value = "100"
            lightSetting.txtThree.text = "100"
        }
        lightSetting.sliderThree.setValue(Float(value)!,animated:true)
        updateFix()
    }
    
    @objc func txtFourChanged(_ textField:UITextField) {
        guard var value = textField.text else {
            return
        }
        if(value == "") {
            return
        }
        if Int(value)! < 0 {
            value = "0"
            lightSetting.txtFour.text = "0"
        } else if Int(value)! > 100 {
            value = "100"
            lightSetting.txtFour.text = "100"
        }
        lightSetting.sliderFour.setValue(Float(value)!,animated:true)
        updateFix()
    }
    
    @objc func txtFiveChanged(_ textField:UITextField) {
        guard var value = textField.text else {
            return
        }
        if(value == "") {
            return
        }
        if Int(value)! < 0 {
            value = "0"
            lightSetting.txtFive.text = "0"
        } else if Int(value)! > 100 {
            value = "100"
            lightSetting.txtFive.text = "100"
        }
        lightSetting.sliderFive.setValue(Float(value)!,animated:true)
        updateFix()
    }
    
    @objc func txtSixChanged(_ textField:UITextField) {
        guard var value = textField.text else {
            return
        }
        if(value == "") {
            return
        }
        if Int(value)! < 0 {
            value = "0"
            lightSetting.txtSix.text = "0"
        } else if Int(value)! > 100 {
            value = "100"
            lightSetting.txtSix.text = "100"
        }
        lightSetting.sliderSix.setValue(Float(value)!,animated:true)
        updateFix()
    }
    
    @objc func txtSevenChanged(_ textField:UITextField) {
        guard var value = textField.text else {
            return
        }
        if(value == "") {
            return
        }
        if Int(value)! < 0 {
            value = "0"
            lightSetting.txtSeven.text = "0"
        } else if Int(value)! > 100 {
            value = "100"
            lightSetting.txtSeven.text = "100"
        }
        lightSetting.sliderSeven.setValue(Float(value)!,animated:true)
        updateFix()
    }
    
    @objc func txtEightChanged(_ textField:UITextField) {
        guard var value = textField.text else {
            return
        }
        if(value == "") {
            return
        }
        if Int(value)! < 0 {
            value = "0"
            lightSetting.txtEight.text = "0"
        } else if Int(value)! > 100 {
            value = "100"
            lightSetting.txtEight.text = "100"
        }
        lightSetting.sliderEight.setValue(Float(value)!,animated:true)
        updateFix()
    }
}

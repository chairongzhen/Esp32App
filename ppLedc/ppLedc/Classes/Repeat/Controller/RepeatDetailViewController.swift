//
//  RepeatDetailViewController.swift
//  ppLedc
//
//  Created by 柴荣臻 on 2019/7/26.
//  Copyright © 2019 rzchai. All rights reserved.
//

import UIKit

class RepeatDetailViewController: PPAlertBaseViewController {
    private lazy var detailSettingView : DetailSettingView = {
        let settingView : DetailSettingView = DetailSettingView.detailSettingView()
        settingView.frame = CGRect(x: 0, y: 50, width: kScreenW, height: kScreenH)
        settingView.txtOne.addTarget(self, action: #selector(txtOneChanged(_:)), for: .allEditingEvents)
        settingView.txtTwo.addTarget(self, action: #selector(txtTwoChanged(_:)), for: .allEditingEvents)
        settingView.txtThree.addTarget(self, action: #selector(txtThreeChanged(_:)), for: .allEditingEvents)
        settingView.txtFour.addTarget(self, action: #selector(txtFourChanged(_:)), for: .allEditingEvents)
        settingView.txtFive.addTarget(self, action: #selector(txtFiveChanged(_:)), for: .allEditingEvents)
        settingView.txtSix.addTarget(self, action: #selector(txtSixChanged(_:)), for: .allEditingEvents)
        settingView.txtSeven.addTarget(self, action: #selector(txtSevenChanged(_:)), for: .allEditingEvents)
        settingView.txtEight.addTarget(self, action: #selector(txtEightChanged(_:)), for: .allEditingEvents)
        settingView.btnSave.layer.masksToBounds = true
        settingView.btnSave.layer.cornerRadius = 5.0
        settingView.btnSave.layer.borderWidth = 1.5
        settingView.btnSave.layer.borderColor = UIColor.orange.cgColor
        settingView.btnSave.addTarget(self, action: #selector(btnSaveClicked), for: .touchUpInside)
        return settingView
    }()
    private lazy var txtTime : UITextField = UITextField()
    private lazy var imgTime : UIImageView = UIImageView()
    private lazy var timeStepper : UIStepper = UIStepper()
    private lazy var repeatViewModel : RepeatViewModel = RepeatViewModel()
    private lazy var currentSelectedIndex : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentSelectedIndex =  UserDefaults.standard.object(forKey: "currentTimeIndex") as! Int
        NotificationCenter.default.addObserver(self, selector: #selector(upDataChange(notif:)), name: NSNotification.Name(rawValue: "s"), object: nil)
        setupUI()
    }
}

// view logic
extension RepeatDetailViewController {
    private func bindTagValues() {
        repeatViewModel.getTagValues(openid: self.getOpenid(), tag: String(currentSelectedIndex)) { (message) in
            if message == "success" {
                self.detailSettingView.txtOne.text = self.repeatViewModel.l1
                self.detailSettingView.txtTwo.text = self.repeatViewModel.l2
                self.detailSettingView.txtThree.text = self.repeatViewModel.l3
                self.detailSettingView.txtFour.text = self.repeatViewModel.l4
                self.detailSettingView.txtFive.text = self.repeatViewModel.l5
                self.detailSettingView.txtSix.text = self.repeatViewModel.l6
                self.detailSettingView.txtSeven.text = self.repeatViewModel.l7
                self.detailSettingView.txtEight.text = self.repeatViewModel.l8
                self.detailSettingView.sliderOne.value = Float(self.repeatViewModel.l1)!
                self.detailSettingView.sliderTwo.value = Float(self.repeatViewModel.l2)!
                self.detailSettingView.sliderThree.value = Float(self.repeatViewModel.l3)!
                self.detailSettingView.sliderFour.value = Float(self.repeatViewModel.l4)!
                self.detailSettingView.sliderFive.value = Float(self.repeatViewModel.l5)!
                self.detailSettingView.sliderSix.value = Float(self.repeatViewModel.l6)!
                self.detailSettingView.sliderSeven.value = Float(self.repeatViewModel.l7)!
                self.detailSettingView.sliderEight.value = Float(self.repeatViewModel.l8)!
            } else {
                self.autoHideAlertMessage(message: "数据异常,请联系商家")
            }
        }
    }
    
    
    private func updateTagVals() {
        var lights : String = ""
        lights = lights + String(Int(self.detailSettingView.sliderOne.value))
        lights = lights + ","
        lights = lights + String(Int(self.detailSettingView.sliderTwo.value))
        lights = lights + ","
        lights = lights + String(Int(self.detailSettingView.sliderThree.value))
        lights = lights + ","
        lights = lights + String(Int(self.detailSettingView.sliderFour.value))
        lights = lights + ","
        lights = lights + String(Int(self.detailSettingView.sliderFive.value))
        lights = lights + ","
        lights = lights + String(Int(self.detailSettingView.sliderSix.value))
        lights = lights + ","
        lights = lights + String(Int(self.detailSettingView.sliderSeven.value))
        lights = lights + ","
        lights = lights + String(Int(self.detailSettingView.sliderEight.value))
        
        repeatViewModel.updateTagVals(openid: self.getOpenid(),tag: String(currentSelectedIndex), lights: lights) { (message) in
            if message == "success" {
                self.autoHideAlertMessage(message: "保存成功")
                NotificationCenter.default.post(name: NSNotification.Name(rawValue:"cdchanged"), object: nil, userInfo: nil)
            } else {
                self.autoHideAlertMessage(message: "数据异常,请联系商家")
            }
        }
    }
}


// draw view's controller
extension RepeatDetailViewController {
    private func setupUI() {
        self.view.backgroundColor = .white
        self.view.addSubview(detailSettingView)
        drawTimeTextField()
        drawTimeStepper()
        bindTagValues()
    }
    
    private func drawTimeTextField() {
        imgTime.frame = CGRect(x: kScreenW / 2  - 45, y: 13, width: 18, height: 18)
        imgTime.image = UIImage(named: "clock")
        self.view.addSubview(imgTime)
        txtTime.frame = CGRect(x: kScreenW / 2 - 45 , y: 10, width: 90, height: 25)

        //txtTime.text = self.getCurrentTimeLine()
        txtTime.text = self.getSelectedtimeLine(value: currentSelectedIndex)
        txtTime.textColor = .orange
        txtTime.textAlignment = .center
        txtTime.borderStyle = .none
        txtTime.isEnabled = false
        let currentIndex = currentSelectedIndex
        timeStepper.value = Double(currentIndex)
        self.view.addSubview(txtTime)
    }
    
    private func drawTimeStepper() {
        timeStepper.frame = CGRect(x: kScreenW / 2 - 50, y: 40, width: 50, height: 30)
        timeStepper.maximumValue = 143
        timeStepper.minimumValue = 0
        timeStepper.stepValue = 1
        timeStepper.isContinuous = true
        timeStepper.wraps = true
        timeStepper.tintColor = .orange
        timeStepper.addTarget(self, action: #selector(timeStepperChanged(sender:)), for: .valueChanged)
        timeStepper.value = Double(getCurrentTimeIndex())
        self.view.addSubview(timeStepper)
    }
}

// events
extension RepeatDetailViewController {
    @objc func btnSaveClicked() {
        //print("save button clicked")
        updateTagVals()
    }
    
    @objc func upDataChange(notif: NSNotification){
        currentSelectedIndex = (notif.userInfo!["currentTimeIndex"] as? Int)!
        txtTime.text = self.getSelectedtimeLine(value: currentSelectedIndex)
        let currentIndex = currentSelectedIndex
        timeStepper.value = Double(currentIndex)
        bindTagValues()
    }
    
    @objc private func timeStepperChanged(sender: UIStepper) {
        let currentval : Int  = Int(sender.value)
        txtTime.text = kXAxises[currentval]
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
            detailSettingView.txtOne.text = "0"
        } else if Int(value)! > 100 {
            value = "100"
            detailSettingView.txtOne.text = "100"
        }
        detailSettingView.sliderOne.setValue(Float(value)!,animated:true)
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
            detailSettingView.txtTwo.text = "0"
        } else if Int(value)! > 100 {
            value = "100"
            detailSettingView.txtTwo.text = "100"
        }
        detailSettingView.sliderTwo.setValue(Float(value)!,animated:true)
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
            detailSettingView.txtThree.text = "0"
        } else if Int(value)! > 100 {
            value = "100"
            detailSettingView.txtThree.text = "100"
        }
        detailSettingView.sliderThree.setValue(Float(value)!,animated:true)
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
            detailSettingView.txtFour.text = "0"
        } else if Int(value)! > 100 {
            value = "100"
            detailSettingView.txtFour.text = "100"
        }
        detailSettingView.sliderFour.setValue(Float(value)!,animated:true)
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
            detailSettingView.txtFive.text = "0"
        } else if Int(value)! > 100 {
            value = "100"
            detailSettingView.txtFive.text = "100"
        }
        detailSettingView.sliderFive.setValue(Float(value)!,animated:true)
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
            detailSettingView.txtSix.text = "0"
        } else if Int(value)! > 100 {
            value = "100"
            detailSettingView.txtSix.text = "100"
        }
        detailSettingView.sliderSix.setValue(Float(value)!,animated:true)
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
            detailSettingView.txtSeven.text = "0"
        } else if Int(value)! > 100 {
            value = "100"
            detailSettingView.txtSeven.text = "100"
        }
        detailSettingView.sliderSeven.setValue(Float(value)!,animated:true)
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
            detailSettingView.txtEight.text = "0"
        } else if Int(value)! > 100 {
            value = "100"
            detailSettingView.txtEight.text = "100"
        }
        detailSettingView.sliderEight.setValue(Float(value)!,animated:true)
    }
}

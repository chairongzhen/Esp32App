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
        return settingView
    }()
    private lazy var txtTime : UITextField = UITextField()
    private lazy var imgTime : UIImageView = UIImageView()
    private lazy var timeStepper : UIStepper = UIStepper()
    
    private lazy var currentSelectedIndex : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentSelectedIndex =  UserDefaults.standard.object(forKey: "currentTimeIndex") as! Int
        NotificationCenter.default.addObserver(self, selector: #selector(upDataChange(notif:)), name: NSNotification.Name(rawValue: "s"), object: nil)
        setupUI()
    }
}

extension RepeatDetailViewController {
    private func setupUI() {
        self.view.backgroundColor = .white
        self.view.addSubview(detailSettingView)
        drawTimeTextField()
        drawTimeStepper()
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

extension RepeatDetailViewController {
    @objc func upDataChange(notif: NSNotification){
        currentSelectedIndex = (notif.userInfo!["currentTimeIndex"] as? Int)!
        txtTime.text = self.getSelectedtimeLine(value: currentSelectedIndex)
        let currentIndex = currentSelectedIndex
        timeStepper.value = Double(currentIndex)
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
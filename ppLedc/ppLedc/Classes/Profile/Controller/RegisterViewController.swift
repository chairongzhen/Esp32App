//
//  RegisterViewController.swift
//  ppLedc
//
//  Created by 柴荣臻 on 2019/7/15.
//  Copyright © 2019 rzchai. All rights reserved.
//

import UIKit

var passwordTextField:UITextField?
var offsetLeftHand : CGFloat = 60

var imgLeftHand : UIImageView!
var imgRightHand : UIImageView!

var imgLeftHandGone : UIImageView!
var imgRightHandGone : UIImageView!

var txtUser : UITextField!
var txtPwd : UITextField!
var txtConfirmPwd : UITextField!
var nickName: UITextField!
let registButton = UIButton(type: .custom)

class RegisterViewController: PPAlertBaseViewController {
    private lazy var profileVM : ProfileViewModel = ProfileViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "用户注册"
        view.backgroundColor = UIColor.white
        setupUI()
    }
    
}

extension RegisterViewController {
    private func setupUI() {
        // owl header
        let imgLogin = UIImageView(frame: CGRect(x: kScreenW / 2 - 211 / 2, y: 100, width: 211, height: 109))
        imgLogin.image =  UIImage(named: "login_n")
        imgLogin.layer.masksToBounds = true
        self.view.addSubview(imgLogin)
        
        // owl left hand
        let rectLeftHand = CGRect(x: 61 - offsetLeftHand, y: 90, width: 40, height: 65)
        imgLeftHand = UIImageView(frame: rectLeftHand)
        imgLeftHand.image = UIImage(named: "login_l")
        imgLogin.addSubview(imgLeftHand)
        
        // owl right hand
        let rectRightHand = CGRect(x: imgLogin.frame.size.width / 2 + 60, y: 90, width: 40, height: 65)
        imgRightHand = UIImageView(frame: rectRightHand)
        imgRightHand.image = UIImage(named: "login_r")
        imgLogin.addSubview(imgRightHand)
        
        let vLogin = UIView(frame: CGRect(x: 15, y: 200, width: kScreenW - 30, height: 330))
        vLogin.layer.borderWidth = 0.5
        vLogin.layer.borderColor = UIColor.lightGray.cgColor
        vLogin.backgroundColor = UIColor.white
        self.view.addSubview(vLogin)
        
        txtUser = UITextField(frame: CGRect(x: 30, y: 30, width: vLogin.frame.size.width - 60, height: 44))
        txtUser.layer.cornerRadius = 5
        txtUser.layer.borderColor = UIColor.lightGray.cgColor
        txtUser.layer.borderWidth = 0.5
        txtUser.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        txtUser.leftViewMode = UITextField.ViewMode.always
        txtUser.placeholder = "请输入用户名"
        txtUser.autocorrectionType = UITextAutocorrectionType.no
        txtUser.autocapitalizationType = UITextAutocapitalizationType.none
        let imgUser = UIImageView(frame: CGRect(x: 11, y: 11, width: 22, height: 22))
        imgUser.image = UIImage(named: "user")
        txtUser.leftView!.addSubview(imgUser)
        vLogin.addSubview(txtUser)
        
        // password
        txtPwd = UITextField(frame: CGRect(x: 30, y: 90, width: vLogin.frame.size.width - 60, height: 44))
        txtPwd.layer.cornerRadius = 5
        txtPwd.layer.borderColor = UIColor.lightGray.cgColor
        txtPwd.layer.borderWidth = 0.5
        txtPwd.isSecureTextEntry = true
        txtPwd.leftView  = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        txtPwd.leftViewMode = UITextField.ViewMode.always
        txtPwd.placeholder = "请输入密码"
        
        // password left icon
        let imgPwd = UIImageView(frame: CGRect(x: 11, y: 11, width: 22, height: 22))
        imgPwd.image = UIImage(named: "password")
        txtPwd.leftView!.addSubview(imgPwd)
        vLogin.addSubview(txtPwd)
        
        
        // password
        txtConfirmPwd = UITextField(frame: CGRect(x: 30, y: 150, width: vLogin.frame.size.width - 60, height: 44))
        txtConfirmPwd.layer.cornerRadius = 5
        txtConfirmPwd.layer.borderColor = UIColor.lightGray.cgColor
        txtConfirmPwd.layer.borderWidth = 0.5
        txtConfirmPwd.isSecureTextEntry = true
        txtConfirmPwd.leftView  = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        txtConfirmPwd.leftViewMode = UITextField.ViewMode.always
        txtConfirmPwd.placeholder = "确认密码"
        
        // password left icon
        let imgPwd2 = UIImageView(frame: CGRect(x: 11, y: 11, width: 22, height: 22))
        imgPwd2.image = UIImage(named: "password")
        txtConfirmPwd.leftView!.addSubview(imgPwd2)
        vLogin.addSubview(txtConfirmPwd)
        
        // nickname
        nickName = UITextField(frame: CGRect(x: 30, y: 210, width: vLogin.frame.size.width - 60, height: 44))
        nickName.layer.cornerRadius = 5
        nickName.layer.borderColor = UIColor.lightGray.cgColor
        nickName.layer.borderWidth = 0.5
        nickName.leftView  = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        nickName.leftViewMode = UITextField.ViewMode.always
        nickName.placeholder = "请输入昵称(可为空)"
        nickName.autocorrectionType = UITextAutocorrectionType.no
        nickName.autocapitalizationType = UITextAutocapitalizationType.none
        
        // password left icon
        let imgPwd3 = UIImageView(frame: CGRect(x: 11, y: 11, width: 22, height: 22))
        imgPwd3.image = UIImage(named: "password")
        nickName.leftView!.addSubview(imgPwd3)
        vLogin.addSubview(nickName)
        
        
        registButton.frame = CGRect(x: 30, y: 270, width: vLogin.frame.size.width - 60, height: 40)
        registButton.setTitle("注册", for: .normal)
        //registButton.addTarget(self, action: nil, for: .touchUpInside)
        registButton.backgroundColor = UIColor.orange
        registButton.addTarget(self, action: #selector(registerButtonClick), for: .touchUpInside)
        vLogin.addSubview(registButton)        
    }
    
    @objc private func registerButtonClick() {
        if txtUser.text == "" {
            self.autoHideAlertMessage(message: "用户名不能为空")
            return
        }
        
        if txtPwd.text == "" {
            self.autoHideAlertMessage(message: "密码不能为空")
            return
        }
        
        if txtConfirmPwd.text == "" {
            self.autoHideAlertMessage(message: "确定密码不能为空")
            return
        }
        
        if txtPwd.text != txtConfirmPwd.text {
            self.autoHideAlertMessage(message: "两次输入的密码不一致")
            return
        }
        
        profileVM.userRegister(username: txtUser.text!, pwd: txtPwd.text!, nickname: nickName.text!) { (message) in
            if message == "success" {
                self.present(LoginViewController(), animated: true, completion: nil)
            } else {
                self.autoHideAlertMessage(message: message)
                return
            }
        }
    }
}


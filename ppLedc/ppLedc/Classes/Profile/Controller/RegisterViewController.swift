//
//  RegisterViewController.swift
//  ppLedc
//
//  Created by 柴荣臻 on 2019/7/15.
//  Copyright © 2019 rzchai. All rights reserved.
//

import UIKit

var mobileTextField:UITextField?
var passwordTextField:UITextField?

class RegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
}

extension RegisterViewController {
    private func setupUI() {
        let cancelBtn = PPUtil.createButtonWith(Type: .custom, Title: "", Frame: CGRect(x:20, y:Int(kStatusBarH) + 5, width:30, height:30), TitleColor: nil, Font: nil, BackgroundColor: UIColor.clear, Target: self, Action: nil, TextAligtment: nil)
        cancelBtn.setImage(UIImage(named:""), for: .normal)
        self.view.addSubview(cancelBtn)
        
        let headImageView = PPUtil.createImageViewWith(Frame: CGRect(x:(kScreenW-160)/2, y:100, width:160, height:54), ImageName: "矢量智能对象", CornarRadius: 0.0)
        self.view.addSubview(headImageView)
        
        let mobileImageView = PPUtil.createImageViewWith(Frame: CGRect(x:30, y:headImageView.frame.maxY + 50, width:26, height:26), ImageName: "shouji", CornarRadius: 0.0)
        self.view.addSubview(mobileImageView)
        
        mobileTextField = PPUtil.createTextFieldWith(Frame: CGRect(x:mobileImageView.frame.maxX + 20, y:headImageView.frame.maxY + 42, width:kScreenW - 114, height:45), BoardStyle: .none, PlaceHolder: " 请输入手机号", BackgroundColor: UIColor.clear, TintColor: UIColor.orange, IsPWD: false)
        //mobileTextField?.delegate = self
        self.view.addSubview(mobileTextField!)
        
        let line_view_one = PPUtil.createViewWith(Frame: CGRect(x:10, y:(mobileTextField?.frame.maxY)! + 5, width:kScreenW - 20, height:1), BackgroundColor: UIColor.white)
        self.view.addSubview(line_view_one)
        
        let passImageView = PPUtil.createImageViewWith(Frame: CGRect(x:30, y:line_view_one.frame.maxY + 15, width:26, height:26), ImageName: "mimatu", CornarRadius: 0.0)
        self.view.addSubview(passImageView)
        
        passwordTextField = PPUtil.createTextFieldWith(Frame: CGRect(x:passImageView.frame.maxX + 20, y:line_view_one.frame.maxY + 7, width:kScreenW - 114, height:45), BoardStyle: .none, PlaceHolder: " 请输入登录密码", BackgroundColor: UIColor.clear, TintColor: UIColor.orange, IsPWD: true)
        //passwordTextField?.delegate = self
        self.view.addSubview(passwordTextField!)
        
        let line_view_two = PPUtil.createViewWith(Frame: CGRect(x:10, y:(passwordTextField?.frame.maxY)! + 5, width:kScreenW - 20, height:1), BackgroundColor: UIColor.white)
        self.view.addSubview(line_view_two)
        
        let loginBtn = PPUtil.createButtonWith(Type: .custom, Title: "登录", Frame: CGRect(x:15, y:line_view_two.frame.maxY + 40, width:kScreenW - 30, height:50), TitleColor: UIColor.white, Font: 20.0, BackgroundColor: UIColor.orange, Target: self, Action: nil, TextAligtment: .center)
        loginBtn.layer.cornerRadius = 5
        loginBtn.layer.shadowOffset = CGSize(width:0, height:5)
        loginBtn.layer.shadowOpacity = 0.5
        loginBtn.layer.shadowColor = UIColor.gray.cgColor
        self.view.addSubview(loginBtn)
        
        let registerBtn = PPUtil.createButtonWith(Type: .custom, Title: "注册", Frame: CGRect(x:15, y:loginBtn.frame.maxY + 20, width:50, height:30), TitleColor: UIColor.orange, Font: 15, BackgroundColor: UIColor.clear, Target: self, Action: nil, TextAligtment: .left)
        self.view.addSubview(registerBtn)
        
        let forgetPasswordBtn = PPUtil.createButtonWith(Type: .custom, Title: "忘记密码?", Frame: CGRect(x:kScreenW-115, y:loginBtn.frame.maxY + 20, width:100, height:30), TitleColor: UIColor.orange, Font: 15, BackgroundColor: UIColor.clear, Target: self, Action: nil, TextAligtment: .right)
        self.view.addSubview(forgetPasswordBtn)
        self.view.backgroundColor = UIColor.white
    }
}

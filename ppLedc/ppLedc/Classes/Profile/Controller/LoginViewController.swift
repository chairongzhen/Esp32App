//
//  LoginViewController.swift
//  ppLedc
//
//  Created by 柴荣臻 on 2019/7/15.
//  Copyright © 2019 rzchai. All rights reserved.
//


import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    // user intput
    var txtUser : UITextField!
    var txtPwd : UITextField!
    
    var offsetLeftHand : CGFloat = 60
    
    var imgLeftHand : UIImageView!
    var imgRightHand : UIImageView!
    
    var imgLeftHandGone : UIImageView!
    var imgRightHandGone : UIImageView!
    
    var showType : LoginShowType = LoginShowType.NONE
    let loginButton = UIButton(type: .custom)
    let registButton = UIButton(type: .custom)
    
    
    private lazy var profileVM : ProfileViewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "用户登陆"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "用户注册", style: .plain, target: self, action: #selector(gotoRegisterView))
        NotificationCenter.default.addObserver(self, selector: #selector(upDataChange(notif:)), name: NSNotification.Name(rawValue: "wlogin"), object: nil)
        setupUI()
    }
    

}

extension LoginViewController {
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
        
        
        // login background
        let vLogin = UIView(frame: CGRect(x: 15, y: 200, width: kScreenW - 30, height: 190))
        vLogin.layer.borderWidth = 0.5
        vLogin.layer.borderColor = UIColor.lightGray.cgColor
        vLogin.backgroundColor = UIColor.white
        self.view.addSubview(vLogin)
        
        
        // owl left gone
        let rectLeftHandGone = CGRect(x: kScreenW / 2 - 100, y: vLogin.frame.origin.y - 22, width: 40, height: 40)
        imgLeftHandGone = UIImageView(frame: rectLeftHandGone)
        imgLeftHandGone.image = UIImage(named: "hand")
        self.view.addSubview(imgLeftHandGone)

        // owl right gone
        let rectRightHandGone = CGRect(x: kScreenW / 2 + 62, y: vLogin.frame.origin.y - 22, width: 40, height: 40)
        imgRightHandGone = UIImageView(frame: rectRightHandGone)
        imgRightHandGone.image = UIImage(named: "hand")
        self.view.addSubview(imgRightHandGone)

        // user input
        txtUser = UITextField(frame: CGRect(x: 30, y: 30, width: vLogin.frame.size.width - 60, height: 44))
        txtUser.delegate = self
        txtUser.layer.cornerRadius = 5
        txtUser.layer.borderColor = UIColor.lightGray.cgColor
        txtUser.layer.borderWidth = 0.5
        txtUser.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        txtUser.leftViewMode = UITextField.ViewMode.always
        //txtUser.placeholder = "请输入用户名"
        txtUser.textColor = .darkText
        txtUser.autocorrectionType = UITextAutocorrectionType.no
        txtUser.autocapitalizationType = UITextAutocapitalizationType.none
        let userPAttr = NSAttributedString(string: "请输入用户名", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        txtUser.attributedPlaceholder = userPAttr

        // username left icon
        let imgUser = UIImageView(frame: CGRect(x: 11, y: 11, width: 22, height: 22))
        imgUser.image = UIImage(named: "user")
        txtUser.leftView!.addSubview(imgUser)
        vLogin.addSubview(txtUser)

        // password
        txtPwd = UITextField(frame: CGRect(x: 30, y: 90, width: vLogin.frame.size.width - 60, height: 44))
        txtPwd.delegate = self
        txtPwd.layer.cornerRadius = 5
        txtPwd.layer.borderColor = UIColor.lightGray.cgColor
        txtPwd.layer.borderWidth = 0.5
        txtPwd.isSecureTextEntry = true
        txtPwd.leftView  = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        txtPwd.leftViewMode = UITextField.ViewMode.always
        //txtPwd.placeholder = "请输入密码"
        txtPwd.textColor = .darkText
        let pwdPAttr = NSAttributedString(string: "请输入密码", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        txtPwd.attributedPlaceholder = pwdPAttr

        // password left icon
        let imgPwd = UIImageView(frame: CGRect(x: 11, y: 11, width: 22, height: 22))
        imgPwd.image = UIImage(named: "password")
        txtPwd.leftView!.addSubview(imgPwd)
        vLogin.addSubview(txtPwd)
        
        
        loginButton.frame = CGRect(x: kScreenW / 2 - 40, y: vLogin.frame.size.height - 40, width: 80, height: 30)
        loginButton.setTitle("登陆", for: .normal)
        loginButton.addTarget(self, action: #selector(loginButtonClick), for: .touchUpInside)
        loginButton.backgroundColor = UIColor.orange
        vLogin.addSubview(loginButton)
        
        
        registButton.frame = CGRect(x: kScreenW / 2 - 40 + 90, y: vLogin.frame.size.height - 40, width: 80, height: 30)
        registButton.setTitle("注册", for: .normal)
        registButton.addTarget(self, action: #selector(gotoRegisterView), for: .touchUpInside)
        registButton.backgroundColor = UIColor.orange
        vLogin.addSubview(registButton)
        
        if WXApi.isWXAppInstalled() {
            let btnWeChat: UIButton = UIButton();
            btnWeChat.setImage(UIImage(named: "wechat"), for: .normal);
            btnWeChat.frame = CGRect(x: kScreenW / 2 - 100, y: vLogin.frame.size.height - 55, width: 60, height: 60)
            btnWeChat.addTarget(self, action: #selector(btnWeChatClicked), for: .touchUpInside)
            vLogin.addSubview(btnWeChat)
        }

        self.view.backgroundColor = UIColor.white

    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.isEqual(txtUser) {
            if( showType != LoginShowType.PASS) {
                showType = LoginShowType.USER
                return
            }
            showType = LoginShowType.USER
            
            UIView.animate(withDuration: 0.5, animations: {
                self.imgLeftHand.frame = CGRect(x: self.imgLeftHand.frame.origin.x - self.offsetLeftHand, y: self.imgLeftHand.frame.origin.y + 30, width: self.imgLeftHand.frame.width, height: self.imgLeftHand.frame.size.height)
                self.imgRightHand.frame = CGRect(x: self.imgRightHand.frame.origin.x + 48, y: self.imgRightHand.frame.origin.y + 30, width: self.imgRightHand.frame.size.width, height: self.imgRightHand.frame.size.height)
                self.imgLeftHandGone.frame = CGRect(x: self.imgLeftHandGone.frame.origin.x - 70, y: self.imgLeftHandGone.frame.origin.y, width: 40, height: 40)
                self.imgRightHandGone.frame = CGRect(x: self.imgRightHandGone.frame.origin.x + 30, y: self.imgRightHandGone.frame.origin.y, width: 40, height: 40)
            })
        } else if textField.isEqual(txtPwd) {
            if showType == LoginShowType.PASS {
                showType = LoginShowType.PASS
                return
            }
            showType = LoginShowType.PASS
            
            UIView.animate(withDuration: 0.5, animations: {
                self.imgLeftHand.frame = CGRect(x: self.imgLeftHand.frame.origin.x + self.offsetLeftHand, y: self.imgLeftHand.frame.origin.y - 30, width: self.imgLeftHand.frame.width, height: self.imgLeftHand.frame.size.height)
                self.imgRightHand.frame = CGRect(x: self.imgRightHand.frame.origin.x - 48, y: self.imgRightHand.frame.origin.y - 30, width: self.imgRightHand.frame.size.width, height: self.imgRightHand.frame.size.height)
                self.imgLeftHandGone.frame = CGRect(x: self.imgLeftHandGone.frame.origin.x + 70, y: self.imgLeftHandGone.frame.origin.y, width: 0, height: 0)
                self.imgRightHandGone.frame = CGRect(x: self.imgRightHandGone.frame.origin.x - 30, y: self.imgRightHandGone.frame.origin.y, width: 0, height: 0)
            })
            
        }
        
        
    }
    
    private func userLogin(username: String, pwd: String) {
        profileVM.userLogin(username: username, pwd: pwd) { (message) in
            if message == "success" {
                let userinfo = UserDefaults.standard
                userinfo.set(self.profileVM.userInfo.username, forKey: "username")
                userinfo.set(self.profileVM.userInfo.nickname, forKey: "nickname")
                userinfo.set(self.profileVM.userInfo.openid, forKey: "openid")
                
                self.present(MainViewController(), animated: true, completion: nil)
            } else {
                let alertController = UIAlertController(title: message,
                                                        message: nil, preferredStyle: .alert)
                self.present(alertController, animated: true, completion: nil)
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                    self.presentedViewController?.dismiss(animated: false, completion: nil)
                    
                }
            }
        }        
    }
    
    @objc func loginButtonClick() {
        if txtUser.text == "" {
            
            return
        }
        
        if txtPwd.text == "" {
            print("密码为空")
            return
        }
        
        userLogin(username: txtUser.text!, pwd: txtPwd.text!)
        loginButton.isEnabled = false
        self.perform(#selector(changeButtonStatus), with: nil, afterDelay: 7.0)
    }
    
    @objc func gotoRegisterView() {
        self.present(RegisterViewController(), animated: true, completion: nil)
    }
    
    @objc func changeButtonStatus(){
        loginButton.isEnabled = true
    }
    
    @objc func btnWeChatClicked() {
        let req = SendAuthReq()
        req.scope = "snsapi_userinfo"
        req.state = "App"
        if !WXApi.send(req) {
            print("weixin sendreq failed")
        }
    }
    
    @objc func upDataChange(notif: NSNotification){
        self.present(MainViewController(), animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

enum LoginShowType {
    case NONE
    case USER
    case PASS
}

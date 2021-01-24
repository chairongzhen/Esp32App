//
//  NewLoginViewController.swift
//  ppLedc
//
//  Created by 柴荣臻 on 2020/8/3.
//  Copyright © 2020 rzchai. All rights reserved.
//

import UIKit

class NewLoginViewController: UIViewController,UITextFieldDelegate {
    private lazy var profileVM : ProfileViewModel = ProfileViewModel()
    @IBOutlet weak var txtPwd: UITextField!
    @IBOutlet weak var txtUser: UITextField!
    
    @IBOutlet weak var btnWechat: UIButton!
    
    @IBOutlet weak var btnLogin: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "用户登陆"
        NotificationCenter.default.addObserver(self, selector: #selector(upDataChange(notif:)), name: NSNotification.Name(rawValue: "wlogin"), object: nil)
        self.hideKeyboardWhenTappedAround()
        btnWechat.isHidden = true;
        if WXApi.isWXAppInstalled() {
            btnWechat.isHidden = false;
        }
        // Do any additional setup after loading the view.
    }


    
}

extension NewLoginViewController {
    @IBAction func onLogin(_ sender: Any) {
        if txtUser.text == "" {
                   return
               }
               
               if txtPwd.text == "" {
                   print("密码为空")
                   return
               }
               
               userLogin(username: txtUser.text!, pwd: txtPwd.text!)
               btnLogin.isEnabled = false
               self.perform(#selector(changeButtonStatus), with: nil, afterDelay: 7.0)
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
    
    @IBAction func onSignup(_ sender: Any) {
                self.present(RegisterViewController(), animated: true, completion: nil)
    }
    
    @objc func changeButtonStatus(){
        btnLogin.isEnabled = true
    }
    
    
    @IBAction func onWechat(_ sender: Any) {
        let req = SendAuthReq()
        req.scope = "snsapi_userinfo"
        req.state = "App"
        WXApi.send(req)
    }
    
       
       @objc func upDataChange(notif: NSNotification){
           self.present(MainViewController(), animated: true, completion: nil)
       }
       
       override func didReceiveMemoryWarning() {
           super.didReceiveMemoryWarning()
       }
}



//
//  AppDelegate.swift
//  ppLedc
//
//  Created by 柴荣臻 on 2019/7/12.
//  Copyright © 2019 rzchai. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,WXApiDelegate {

    var window: UIWindow?
    private lazy var profileViewModel : ProfileViewModel = ProfileViewModel()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        WXApi.registerApp(wechat_appId)
        // Override point for customization after application launch.
        UITabBar.appearance().tintColor = 	UIColor.orange
//        self.window?.rootViewController = UINavigationController(rootViewController: OfflineViewController    ())
        let userinfo = UserDefaults.standard
        let username: Any? = userinfo.object(forKey: "username")
        if username != nil {
            print(userinfo.object(forKey: "openid") as Any)
        } else {
            self.window?.rootViewController = UINavigationController(rootViewController: LoginViewController())
        }
        return true
    }
    
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let urlKey: String = options[UIApplication.OpenURLOptionsKey.sourceApplication] as! String
        
        if urlKey == "com.tencent.xin" {
            // 微信 的回调
            return  WXApi.handleOpen(url, delegate: self)
        }
        
        return true
    }
    
    func onResp(_ resp: BaseResp) {
        let sendRes: SendAuthResp? = resp as? SendAuthResp
        let queue = DispatchQueue(label: "wechatLoginQueue")
        queue.async {
            if let sd = sendRes {
                if sd.errCode == 0 {
                    guard let code = (sd.code)  else {
                        return
                    }
                    self.profileViewModel.requestAccessToken(code, finished: { (result) in
                        if result == "success" {
                            print(self.profileViewModel.wechatUser.unionid)
                            let userinfo = UserDefaults.standard
                            userinfo.set(self.profileViewModel.wechatUser.openid, forKey: "username")
                            userinfo.set(self.profileViewModel.wechatUser.nickname, forKey: "nickname")
                            userinfo.set(self.profileViewModel.wechatUser.unionid, forKey: "openid")
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue:"wlogin"), object: nil, userInfo: nil)
                        } else {
                            print("fetch union id failed")
                        }
                    })
                    
                } else {
                    DispatchQueue.main.async {
                        print("auth failed")
                    }
                }
            } else {
                DispatchQueue.main.async {
                    print("login failed")
                }
            }
        }
    }
    


}




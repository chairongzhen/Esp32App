//
//  ProfileViewModel.swift
//  ppLedc
//
//  Created by 柴荣臻 on 2019/7/16.
//  Copyright © 2019 rzchai. All rights reserved.
//

import UIKit

class ProfileViewModel {
    lazy var userInfo : UserInfo = UserInfo()
    lazy var wechatUser : WechatUser = WechatUser()
    
}

extension ProfileViewModel {
    func userRegister(username: String, pwd: String, nickname: String, finished: @escaping (_ message: String) ->()) {
        let params: [String: String] = ["username": username, "pwd": pwd, "nickname": nickname]
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        NetworkTools.postRequest(URLString: apiRegister, parameters: params as [String : NSString]) { (result) in
            guard let resultDict = result as? [String: NSObject] else {
                return
            }
            guard let isSuccess  = resultDict["isSuccess"] as? Bool else {
                return
            }
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if(isSuccess) {
                finished("success")
            } else {
                let message = resultDict["message"] as? String
                finished(message!)
            }
            
        }
    }
    
    func userLogin(username: String, pwd: String,finished: @escaping (_ mesaage: String) -> ()) {
        let params: [String : String] = ["username": username, "pwd": pwd]
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        NetworkTools.postRequest(URLString: apiLogin, parameters: params as [String : NSString]) { (result) in
            guard let resultDict = result as? [String: NSObject] else {
                return
            }
            guard let isSuccess  = resultDict["isSuccess"] as? Bool else {
                return
            }
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if(isSuccess) {
                let content = resultDict["content"] as! [String: NSObject]
                self.userInfo = UserInfo(dict: content)
                finished("success")
            } else {
                let message = resultDict["message"] as? String
                finished(message!)
            }

        }
    }
    
    func requestAccessToken(_ code: String,finished: @escaping (_ message: String) ->()) {
        // 第二步: 请求accessToken
        let urlStr = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=\(wechat_appId)&secret=\(wwechat_appSecret)&code=\(code)&grant_type=authorization_code"
        
        NetworkTools.getRequest(URLString: urlStr) { (result) in
            guard let resultDict = result as? [String: NSObject] else {
                return
            }
            self.wechatUser = WechatUser(dict: resultDict)
            let getUser = "https://api.weixin.qq.com/sns/userinfo?access_token=\(self.wechatUser.access_token)&openid=\(self.wechatUser.openid)"
            NetworkTools.getRequest(URLString: getUser, finishedCallback: { (result) in
                guard let resultDict = result as? [String: NSObject] else {
                    return
                }
                self.wechatUser.headimgurl = resultDict["headimgurl"] as! String
                let nickname = resultDict["nickname"] as! String
                self.wechatUser.nickname = nickname
                if self.wechatUser.unionid == "" {
                    finished("failed")
                } else {
                     let params: [String : String] = ["openid": self.wechatUser.unionid, "nickname": self.wechatUser.nickname]
                    NetworkTools.postRequest(URLString: apiWxLogin, parameters: params as [String : NSString], finishedCallback: { (result) in
                        finished("success")
                    })
                    
                    finished("success")
                }
            })
        }
    }
}

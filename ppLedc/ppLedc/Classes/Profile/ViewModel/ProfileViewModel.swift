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
    
    
}

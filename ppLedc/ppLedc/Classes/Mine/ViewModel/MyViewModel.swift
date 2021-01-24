//
//  MyViewModel.swift
//  ppLedc
//
//  Created by 柴荣臻 on 2019/7/18.
//  Copyright © 2019 rzchai. All rights reserved.
//

import UIKit

class MyViewModel {
    lazy var machines : [Machine] = [Machine]()
}

extension MyViewModel {
    func getBinds(openid : String, finished: @escaping (_ message: String) ->()) {
        let params : [String: String] = ["openid": openid]
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        NetworkTools.postRequest(URLString: apiGetBinds, parameters: params as [String : NSString]) { (result) in
            guard let resultDict = result as? [String: NSObject] else {
                return
            }
            guard let isSuccess  = resultDict["isSuccess"] as? Bool else {
                return
            }
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if(isSuccess) {
                guard let contentarr = resultDict["content"] as? [[String: NSObject]] else { return }
                self.machines = [Machine]()
                for dict in contentarr {
                    let machine = Machine(dict: dict)
                    self.machines.append(machine)
                }
                
                finished("success")
            } else {
                let message = resultDict["message"] as! String
                //finished(message)
                finished("success")
            }
        }
    }
    
    func unBind(openid: String, mid: String, finished: @escaping (_ message: String) ->()) {
        let params : [String: String] = ["openid": openid,"mid": mid]
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        NetworkTools.postRequest(URLString: apiUnBind, parameters: params as [String : NSString]) { (result) in
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
                let message = resultDict["message"] as! String
                finished(message)
            }
        }
    }
    
    func bindMid(openid: String, mid: String, finished: @escaping (_ message: String) ->()) {
        let params : [String: String] = ["openid": openid,"mid": mid]
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        NetworkTools.postRequest(URLString: apiBindMid, parameters: params as [String : NSString]) { (result) in
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
                let message = resultDict["message"] as! String
                finished(message)
            }
        }
    }
}

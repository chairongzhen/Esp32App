//
//  FixViewModel.swift
//  ppLedc
//
//  Created by 柴荣臻 on 2019/7/22.
//  Copyright © 2019 rzchai. All rights reserved.
//

import UIKit

class FixViewModel {
    lazy var fixData : FixData = FixData()
}

extension FixViewModel {
    
    func getOpenid() -> String {
        guard let openid : String =  UserDefaults.standard.object(forKey: "openid") as? String else {
            return ""
        }
        return openid
    }
    
    func getFixData(openid : String, finished: @escaping (_ message: String) ->()) {
        let params : [String: String] = ["openid": openid]
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        NetworkTools.postRequest(URLString: apiGetFix, parameters: params as [String : NSString]) { (result) in
            guard let resultDict = result as? [String: NSObject] else {
                return
            }
            guard let isSuccess  = resultDict["isSuccess"] as? Bool else {
                return
            }
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if(isSuccess) {
                let content = resultDict["content"] as! [String: NSObject]
                let data: Dictionary = content as Dictionary
                
                let datafix: FixData = FixData()
                datafix.l1 = data["l1"] as! Int
                datafix.l2 = data["l2"] as! Int
                datafix.l3 = data["l3"] as! Int
                datafix.l4 = data["l4"] as! Int
                datafix.l5 = data["l5"] as! Int
                datafix.l6 = data["l6"] as! Int
                datafix.l7 = data["l7"] as! Int
                datafix.l8 = data["l8"] as! Int
                self.fixData = datafix
                finished("success")
            } else {
                let message = resultDict["message"] as! String
                finished(message)
            }
        }
    }
    
    func updateFix(openid : String,l1: String,l2: String,l3: String,l4: String,l5: String,l6: String,l7: String,l8: String,finished: @escaping (_ message: String) ->()) {
        let params : [String: String] = ["openid": openid,"l1": l1, "l2": l2, "l3": l3, "l4": l4, "l5": l5, "l6": l6, "l7": l7, "l8": l8]
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        NetworkTools.postRequest(URLString: apiUpdateFix, parameters: params as [String : NSString]) { (result) in
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

    
}

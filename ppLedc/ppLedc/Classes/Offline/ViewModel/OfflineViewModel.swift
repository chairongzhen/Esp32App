//
//  OfflineViewModel.swift
//  ppLedc
//
//  Created by 柴荣臻 on 2019/7/29.
//  Copyright © 2019 rzchai. All rights reserved.
//

import UIKit
import SystemConfiguration.CaptiveNetwork

class OfflineViewModel {
    
}

extension OfflineViewModel {
    func allOn(finished: @escaping (_ message: String) ->()) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        NetworkTools.internatRequest(type: .GET,URLString: apiOn) { (result) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            let res = result as! String
            if(res == "success") {
                finished("success")
            } else {
                finished("failed")
            }

        }
    }
    
    func allOff(finished: @escaping (_ message: String) ->()) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        NetworkTools.internatRequest(type: .GET,URLString: apiOff) { (result) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            let res = result as! String
            if(res == "success") {
                finished("success")
            } else {
                finished("failed")
            }
        }
    }
    
    func settingWiFi(ssid: String, pwd: String, finished: @escaping (_ message: String) ->()) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let onlineUrl : String  = apiOnline + "?ssid=\(ssid)&pwd=\(pwd)"
        let ssidinfo = UserDefaults.standard
        ssidinfo.set(ssid, forKey: "ssid")
        ssidinfo.set(pwd, forKey: "pwd")
        NetworkTools.internatRequest(type: .GET,URLString: onlineUrl) { (result) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            let res = result as! String
            if(res == "success") {
                finished("success")

            } else {
                finished("failed")
            }
        }
    }
    
     func updateTime(timestamp: Int,  finished: @escaping (_ message: String) ->()) {
           UIApplication.shared.isNetworkActivityIndicatorVisible = true
           let updateTimeUrl : String  = apiUpdateTime + "?timestamp=\(timestamp)"
           NetworkTools.internatRequest(type: .GET,URLString: updateTimeUrl) { (result) in
               UIApplication.shared.isNetworkActivityIndicatorVisible = false
               let res = result as! String
               if(res == "success") {
                   finished("success")

               } else {
                   finished("failed")
               }
           }
       }
}

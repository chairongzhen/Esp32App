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
    
    func getInterfaces() -> Bool {
        guard let unwrappedCFArrayInterfaces = CNCopySupportedInterfaces() else {
            print("this must be a simulator, no interfaces found")
            return false
        }
        guard let swiftInterfaces = (unwrappedCFArrayInterfaces as NSArray) as? [String] else {
            print("System error: did not come back as array of Strings")
            return false
        }
        for interface in swiftInterfaces {
            print("Looking up SSID info for \(interface)") // en0
            guard let unwrappedCFDictionaryForInterface = CNCopyCurrentNetworkInfo(interface as CFString) else {
                print("System error: \(interface) has no information")
                return false
            }
            guard let SSIDDict = (unwrappedCFDictionaryForInterface as NSDictionary) as? [String: AnyObject] else {
                print("System error: interface information is not a string-keyed dictionary")
                return false
            }
            for d in SSIDDict.keys {
                print("\(d): \(SSIDDict[d]!)")
            }
        }
        return true
    }
    
}

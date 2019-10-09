//
//  RepeatViewModel.swift
//  ppLedc
//
//  Created by 柴荣臻 on 2019/7/25.
//  Copyright © 2019 rzchai. All rights reserved.
//

import UIKit

class RepeatViewModel {
    lazy var tags : [Int] = []
    lazy var l1val : [Int] = []
    lazy var l2val : [Int] = []
    lazy var l3val : [Int] = []
    lazy var l4val : [Int] = []
    lazy var l5val : [Int] = []
    lazy var l6val : [Int] = []
    lazy var l7val : [Int] = []
    lazy var l8val : [Int] = []
    
    lazy var l1 : String = "0"
    lazy var l2 : String = "0"
    lazy var l3 : String = "0"
    lazy var l4 : String = "0"
    lazy var l5 : String = "0"
    lazy var l6 : String = "0"
    lazy var l7 : String = "0"
    lazy var l8 : String = "0"
}

extension RepeatViewModel {
    func getRepeatData(openid : String, finished: @escaping (_ message: String) ->()) {
        let params : [String: String] = ["openid": openid]
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        NetworkTools.postRequest(URLString: apiGetRepeats, parameters: params as [String : NSString]) { (result) in
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
                self.tags = data["tags"] as! [Int]
                self.l1val = data["l1"] as! [Int]
                self.l2val = data["l2"] as! [Int]
                self.l3val = data["l3"] as! [Int]
                self.l4val = data["l4"] as! [Int]
                self.l5val = data["l5"] as! [Int]
                self.l6val = data["l6"] as! [Int]
                self.l7val = data["l7"] as! [Int]
                self.l8val = data["l8"] as! [Int]
                finished("success")
            } else {
                let message = resultDict["message"] as! String
                finished(message)
            }
        }
    }
    
    func delTag(openid: String, tag: String, finished: @escaping (_ message: String) ->()) {
        let params : [String: String] = ["openid": openid,"tag": tag]
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        NetworkTools.postRequest(URLString: apiDelTag, parameters: params as [String : NSString]) { (result) in
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
    
    func emptyTags(openid: String, finished: @escaping (_ message: String) ->()) {
        let params : [String: String] = ["openid": openid]
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        NetworkTools.postRequest(URLString: apiEmpty, parameters: params as [String : NSString]) { (result) in
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
    
    func getTagValues(openid: String, tag: String, finished: @escaping (_ message: String) ->()) {
        let params : [String: String] = ["openid": openid,"tag": tag]
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        NetworkTools.postRequest(URLString: apiGetTagVal, parameters: params as [String : NSString]) { (result) in
            guard let resultDict = result as? [String: NSObject] else {
                return
            }
            guard let isSuccess  = resultDict["isSuccess"] as? Bool else {
                return
            }
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if(isSuccess) {
                let content = resultDict["content"] as! [String: NSObject]
                self.l1 = (content["l1"] as? NSNumber)!.stringValue
                self.l2 = (content["l2"] as? NSNumber)!.stringValue
                self.l3 = (content["l3"] as? NSNumber)!.stringValue
                self.l4 = (content["l4"] as? NSNumber)!.stringValue
                self.l5 = (content["l5"] as? NSNumber)!.stringValue
                self.l6 = (content["l6"] as? NSNumber)!.stringValue
                self.l7 = (content["l7"] as? NSNumber)!.stringValue
                self.l8 = (content["l8"] as? NSNumber)!.stringValue
                finished("success")
            } else {
                let message = resultDict["message"] as? String
                finished(message!)
            }
        }
    }
    
    func updateTagVals(openid: String,tag: String ,lights: String, finished: @escaping (_ message: String) ->()) {
        let params : [String: String] = ["openid": openid,"tag": tag,"lights": lights]
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        NetworkTools.postRequest(URLString: apiUpdateTagVal, parameters: params as [String : NSString]) { (result) in
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


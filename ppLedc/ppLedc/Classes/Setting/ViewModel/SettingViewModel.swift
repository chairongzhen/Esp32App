
import UIKit

class SettingViewModel {
    lazy var setting : Setting = Setting()
}

extension SettingViewModel {
    func getSetting(openid: String, finished: @escaping (_ message: String) ->()) {
        let params : [String: String] = ["openid": openid]
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        NetworkTools.postRequest(URLString: apiGetSet, parameters: params as [String : NSString]) { (result) in
            guard let resultDict = result as? [String: NSObject] else {
                return
            }
            guard let isSuccess  = resultDict["isSuccess"] as? Bool else {
                return
            }
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if(isSuccess) {
                let content = resultDict["content"] as! [String: NSObject]
                self.setting = Setting(dict: content as! [String : String])                
                finished("success")
            } else {
                let message = resultDict["message"] as? String
                finished(message!)
            }
        }
    }
    
    func updateSetting(openid: String, repeatMode: String,productionMode: String,finished: @escaping (_ message: String) ->()) {
        let params : [String: String] = ["openid": openid,"repeatmode": repeatMode, "productionmode": productionMode]
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        NetworkTools.postRequest(URLString: apiUpdateSet, parameters: params as [String : NSString]) { (result) in
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

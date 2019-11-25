//
//  AppDelegate.swift
//  ppLedc
//
//  Created by 柴荣臻 on 2019/7/12.
//  Copyright © 2019 rzchai. All rights reserved.
//

import UIKit
import CheckVersion_Swift
import SystemConfiguration.CaptiveNetwork
import CoreLocation



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,WXApiDelegate {
    var locationManager = CLLocationManager()
    var window: UIWindow?
    private lazy var profileViewModel : ProfileViewModel = ProfileViewModel()
    var manager:CLLocationManager?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //CheckVersion.checkVersion(kBundleId, nil)
        
        WXApi.registerApp(wechat_appId)
        // Override point for customization after application launch.
        UITabBar.appearance().tintColor = 	UIColor.orange

        self.manager = CLLocationManager.init()
        manager?.requestWhenInUseAuthorization()
        manager?.requestAlwaysAuthorization()
        manager?.startUpdatingLocation()
        var isAP : Bool = false
        if(CLLocationManager.authorizationStatus() != .denied) {
            let currentSSID = getUsedSSID()
            //esp_3C71BF6D32E4
            let apPattern = "^esp_[\\da-zA-Z]{12}$"
            let regex = try? NSRegularExpression(pattern: apPattern, options: [])
            if let results = regex?.matches(in: currentSSID, options: [], range: NSRange(location: 0, length: currentSSID.count)), results.count != 0 {
                
                isAP = true
            }

        } else {
            print("请打开位置信息,以便获取当前wifi")
        }
        
        if(isAP) {
            self.window?.rootViewController = UINavigationController(rootViewController: OfflineViewController    ())
        } else {
            let userinfo = UserDefaults.standard
            let username: Any? = userinfo.object(forKey: "username")
            if username != nil {
                print(userinfo.object(forKey: "openid") as Any)
            } else {
                self.window?.rootViewController = UINavigationController(rootViewController: LoginViewController())
            }
        }

    

        return true 
    }
    
    
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return  WXApi.handleOpen(url, delegate: self)
    }
    
    func fetchNetInfo() -> [String : AnyObject]{
            let interfaceNames = CNCopySupportedInterfaces()
            var SSIDInfo = [String : AnyObject]()
            guard interfaceNames != nil else {
                return SSIDInfo
            }
            for interface in interfaceNames as! [CFString] {
                print("Looking up SSID info for \(interface)") // en0
                if let info = CNCopyCurrentNetworkInfo(interface as CFString){
                    SSIDInfo = info as! [String : AnyObject]
                }
                for d in SSIDInfo.keys {
                    print("\(d): \(SSIDInfo[d]!)")
                }
                if SSIDInfo.count > 0{
                    break
                }
            }
            return SSIDInfo
    
    }
    
    func getUsedSSID() -> String {
        let interfaces = CNCopySupportedInterfaces()
        var ssid = ""
        if interfaces != nil {
            let interfacesArray = CFBridgingRetain(interfaces) as! Array<AnyObject>
            if interfacesArray.count > 0 {
                let interfaceName = interfacesArray[0] as! CFString
                let ussafeInterfaceData = CNCopyCurrentNetworkInfo(interfaceName)
                if (ussafeInterfaceData != nil) {
                    let interfaceData = ussafeInterfaceData as! Dictionary<String, Any>
                    ssid = interfaceData["SSID"]! as! String
                }
            }
        }
        return ssid
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




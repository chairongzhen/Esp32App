//
//  SelectWiFiViewController.swift
//  ppLedc
//
//  Created by 柴荣臻 on 2021/1/2.
//  Copyright © 2021 rzchai. All rights reserved.
//

import UIKit
import SystemConfiguration.CaptiveNetwork
class SelectWiFiViewController: UIViewController {

    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var switchConfirm: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switchConfirm.isOn = false
        switchConfirm.thumbTintColor = UIColor(hexString: "#f79e44")
        switchConfirm.onTintColor = UIColor(hexString: "#f68717")
        btnNext.isHidden = true
        let ssidinfo = UserDefaults.standard
        ssidinfo.set(getUsedSSID(), forKey: "ssid")
    }

   
    

}

extension SelectWiFiViewController {
    @IBAction func onConfirm(_ sender: Any) {
        if switchConfirm.isOn {
            btnNext.isHidden = false
        } else {
            btnNext.isHidden = true
        }
    }
    @IBAction func onNext(_ sender: Any) {
        let step4 = WiFiViewController()
        self.navigationController!.pushViewController(step4, animated: true)
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
    
}

//
//  OfflineViewController.swift
//  ppLedc
//
//  Created by 柴荣臻 on 2019/7/29.
//  Copyright © 2019 rzchai. All rights reserved.
//

import UIKit
import SystemConfiguration.CaptiveNetwork

class OfflineViewController: PPAlertBaseViewController {

    @IBOutlet weak var btnOpen: UIButton!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var btnMain: UIButton!
    private lazy var offlineViewModel : OfflineViewModel = OfflineViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "离线操作"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "WiFi设置", style: .plain, target: self, action: #selector(gotoWiFi))
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    
}

extension OfflineViewController {
    @objc private func gotoWiFi() {
         self.navigationController?.pushViewController(WiFiViewController(), animated: true)
    }
    
    @IBAction func btnMainClicked(_ sender: Any) {
        self.present(MainViewController(), animated: true, completion: nil)
    }
    
    @IBAction func btnOnClicked(_ sender: Any) {
        offlineViewModel.allOn { (message) in

        }
    }
    
    @IBAction func btnOffClicked(_ sender: Any) {
        offlineViewModel.allOff { (message) in
        }
    }
    
    
//    func getInterfaces() -> Bool {
//        guard let unwrappedCFArrayInterfaces = CNCopySupportedInterfaces() else {
//            print("this must be a simulator, no interfaces found")
//            return false
//        }
//        guard let swiftInterfaces = (unwrappedCFArrayInterfaces as NSArray) as? [String] else {
//            print("System error: did not come back as array of Strings")
//            return false
//        }
//        for interface in swiftInterfaces {
//            print("Looking up SSID info for \(interface)") // en0
//            guard let unwrappedCFDictionaryForInterface = CNCopyCurrentNetworkInfo(interface as CFString) else {
//                print("System error: \(interface) has no information")
//                return false
//            }
//            guard let SSIDDict = (unwrappedCFDictionaryForInterface as NSDictionary) as? [String: AnyObject] else {
//                print("System error: interface information is not a string-keyed dictionary")
//                return false
//            }
//            for d in SSIDDict.keys {
//                print("\(d): \(SSIDDict[d]!)")
//            }
//        }
//        return true
//    }
}

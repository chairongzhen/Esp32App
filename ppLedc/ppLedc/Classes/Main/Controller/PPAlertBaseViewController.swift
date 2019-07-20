//
//  PPAlertBaseViewController.swift
//  ppLedc
//
//  Created by 柴荣臻 on 2019/7/17.
//  Copyright © 2019 rzchai. All rights reserved.
//

import UIKit

class PPAlertBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension PPAlertBaseViewController {
    func autoHideAlertMessage(message: String) {
        let alertController = UIAlertController(title: message,
                                                message: nil, preferredStyle: .alert)
        self.present(alertController, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.presentedViewController?.dismiss(animated: false, completion: nil)
            
        }
    }    
    func getOpenid() -> String {
        guard let openid : String =  UserDefaults.standard.object(forKey: "openid") as? String else {
            return ""
        }
        return openid
    }
    
    func alertMessage(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func alertMessage(title: String, message: String, target: UIViewController) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        present(MainViewController(), animated: true, completion: nil)
    }
}

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
}

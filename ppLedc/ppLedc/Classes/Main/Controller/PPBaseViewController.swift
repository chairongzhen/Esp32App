//
//  PPBaseViewController.swift
//  ppLedc
//
//  Created by 柴荣臻 on 2019/7/15.
//  Copyright © 2019 rzchai. All rights reserved.
//

import UIKit

class PPBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
    }

}


extension PPBaseViewController {
    private func setupNavigationBar() {
        // 设置左侧item
        let btn = UIButton()
        btn.setImage(UIImage(named: "logo"), for: .normal)
        btn.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        // 设置右侧item
        let qrcodeItem = UIBarButtonItem(image: UIImage(named: "add"), style: UIBarButtonItem.Style.plain, target: self, action: Selector(("quit")))
        let addItem = UIBarButtonItem(image: UIImage(named: "scan"), style: UIBarButtonItem.Style.plain, target: self, action: Selector(("quit")))
        let profile = UIBarButtonItem(image: UIImage(named: "quit"), style: UIBarButtonItem.Style.plain, target: self, action: Selector(("quit")))
        navigationItem.rightBarButtonItems = [profile,addItem,qrcodeItem]
    }
    
    @objc private func quit() {
        UserDefaults.standard.removeObject(forKey: "username")
        UserDefaults.standard.removeObject(forKey: "nickname")
        UserDefaults.standard.removeObject(forKey: "openid")
        self.present(LoginViewController(), animated: true, completion: nil)
    }
}

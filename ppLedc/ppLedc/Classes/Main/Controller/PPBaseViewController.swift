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
        let size = CGSize(width: 40, height: 40)
        let addItem = UIBarButtonItem(imageName: "add", highImageName: "add_h", size: size)
        let qrcodeItem = UIBarButtonItem(imageName: "scan", highImageName: "scan_h", size: size)
        let profile = UIBarButtonItem(imageName: "profile", highImageName: "profile_h", size: size)
        navigationItem.rightBarButtonItems = [profile,addItem,qrcodeItem]
        
    }
}

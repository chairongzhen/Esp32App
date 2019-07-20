//
//  FixViewController.swift
//  ppLedc
//
//  Created by 柴荣臻 on 2019/7/20.
//  Copyright © 2019 rzchai. All rights reserved.
//

import UIKit

class FixViewController: UIViewController {
    private lazy var lightSetting : LightSettingView = {
        let settingView = LightSettingView.lightSettingView()
        settingView.frame = view.bounds
        return settingView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
}


extension FixViewController {
    private func setupUI() {
        self.view.addSubview(lightSetting)
    }
}

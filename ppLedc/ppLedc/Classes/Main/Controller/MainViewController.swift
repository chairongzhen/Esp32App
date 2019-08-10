//
//  MainViewController.swift
//  ppLedc
//
//  Created by 柴荣臻 on 2019/7/12.
//  Copyright © 2019 rzchai. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        addChildVc(storyName: "Basic")
        addChildVc(storyName: "Repeat")
        addChildVc(storyName: "Mine")
        addChildVc(storyName: "Setting")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    private func addChildVc(storyName: String) {
        let childVc = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()!
        addChild(childVc)
    }
}

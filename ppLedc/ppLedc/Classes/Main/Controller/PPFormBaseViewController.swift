//
//  PPFormBaseViewController.swift
//  ppLedc
//
//  Created by rzchai on 2020/12/30.
//  Copyright © 2020 rzchai. All rights reserved.
//

import UIKit
import SwiftyFORM

class PPFormBaseViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    


}


extension PPFormBaseViewController {
    private func setupNavigationBar() {
        // 设置左侧item
        let btn = UIButton()
        btn.setImage(UIImage(named: "logo"), for: .normal)
        btn.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        // 设置右侧item
        let checkout = UIBarButtonItem(image: UIImage(named: "quit"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.quit))
        let offline = UIBarButtonItem(image: UIImage(named: "offline"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.offline))
        let addNew = UIBarButtonItem(image: UIImage(named: "add"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.addNew))
        navigationItem.rightBarButtonItems = [checkout,addNew,offline]
    }
    
    @objc private func quit() {
        UserDefaults.standard.removeObject(forKey: "username")
        UserDefaults.standard.removeObject(forKey: "nickname")
        UserDefaults.standard.removeObject(forKey: "openid")
        self.present(NewLoginViewController(), animated: true, completion: nil)
    }
    
    @objc private func offline() {
        //self.present(WiFiViewController(), animated: true, completion: nil)
        self.navigationController?.pushViewController(OfflineViewController(), animated: true)
    }
    
    @objc private func addNew() {
        self.tabBarController?.selectedIndex = 2
    }
}

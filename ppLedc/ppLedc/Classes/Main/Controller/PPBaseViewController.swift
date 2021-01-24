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
    func getOpenid() -> String {
        guard let openid : String =  UserDefaults.standard.object(forKey: "openid") as? String else {
            return ""
        }
        return openid
    }
    func autoHideAlertMessage(message: String) {
        let alertController = UIAlertController(title: message,
                                                message: nil, preferredStyle: .alert)
        self.present(alertController, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.presentedViewController?.dismiss(animated: false, completion: nil)
            
        }
    }   
    private func setupNavigationBar() {
        // 设置左侧item
//        let btn = UIButton()
//        btn.setImage(UIImage(named: "logo"), for: .normal)
//        btn.sizeToFit()
//        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
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
                let step1 = AddViewController()
                self.navigationController!.pushViewController(step1, animated: true)
    }
}

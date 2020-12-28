//
//  HomeViewController.swift
//  ppLedc
//
//  Created by 柴荣臻 on 2020/8/2.
//  Copyright © 2020 rzchai. All rights reserved.
//

import UIKit

class HomeViewController: PPBaseViewController {

    @IBOutlet weak var lbUserName: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    let nickname = UserDefaults.standard.value(forKey: "nickname")

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController?.isNavigationBarHidden = true
//        self.navigationController?.navigationBar.isHidden = true
//        setupUI()
    }

}

extension HomeViewController {

    private func setupUI() {
        lbUserName.text =  nickname as? String
    }
}

extension HomeViewController {
    @IBAction func goMain(_ sender: Any) {
        let sb = UIStoryboard(name: "Repeat", bundle: nil)
        let destination = sb.instantiateViewController(withIdentifier: "Repeat")
        //跳转
        self.navigationController?.pushViewController(destination, animated: true)
    }
    @IBAction func onOpen(_ sender: Any) {
        print("open")
    }
    
    @IBAction func onOff(_ sender: Any) {
        print("close")
    }
}

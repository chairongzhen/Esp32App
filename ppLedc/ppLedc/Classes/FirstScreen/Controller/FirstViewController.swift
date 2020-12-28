//
//  FirstViewController.swift
//  ppLedc
//
//  Created by 柴荣臻 on 2020/8/2.
//  Copyright © 2020 rzchai. All rights reserved.
//

import UIKit

class FirstViewController: PPAlertBaseViewController {
    @IBOutlet weak var btnOnline: UIButton!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }


    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 跳转页面的导航 不隐藏 false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

}

extension FirstViewController {
    @IBAction func btnGoMain(_ sender: Any) {
        self.present(MainViewController(), animated: true, completion: nil)
    }
    
    @IBAction func btnGoOffline(_ sender: Any) {
        self.present(OfflineViewController(), animated: true, completion: nil)
    }
}

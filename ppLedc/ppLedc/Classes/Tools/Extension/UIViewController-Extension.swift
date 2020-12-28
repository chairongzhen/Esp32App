//
//  UIViewController-Extension.swift
//  ppLedc
//
//  Created by 柴荣臻 on 2020/12/20.
//  Copyright © 2020 rzchai. All rights reserved.
//

import Foundation

extension UIViewController{
    //隐藏键盘
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

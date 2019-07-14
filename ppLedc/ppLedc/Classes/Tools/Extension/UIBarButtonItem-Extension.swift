//
//  UIBarButtonItem-Extension.swift
//  ppLedc
//
//  Created by 柴荣臻 on 2019/7/13.
//  Copyright © 2019 rzchai. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    /*
    class func createItem(imageName: String, highImageName: String, size: CGSize) -> UIBarButtonItem {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: highImageName), for: .highlighted)
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        return UIBarButtonItem(customView: btn)
    }
    */
    // convenience structor func
    convenience init(imageName: String, highImageName: String, size: CGSize) {
        // 1. create UIButton
        let btn = UIButton()
        
        // 2. setting the button image
        btn.setImage(UIImage(named: imageName), for: .normal)
        if highImageName != "" {
            btn.setImage(UIImage(named: highImageName), for: .highlighted)
        }
        
        // 3. setting the button size
        if size == CGSize.zero {
            btn.sizeToFit()
        } else {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        
        // 4. create the UIBarButtonItem
        self.init(customView: btn)
    }
}

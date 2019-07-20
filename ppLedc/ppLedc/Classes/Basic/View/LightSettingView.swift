//
//  LightSettingView.swift
//  ppLedc
//
//  Created by 柴荣臻 on 2019/7/20.
//  Copyright © 2019 rzchai. All rights reserved.
//

import UIKit

class LightSettingView: UIView {
}

extension LightSettingView {
    class func lightSettingView() -> LightSettingView {
        return UINib(nibName: "LightSettingView", bundle: .main).instantiate(withOwner: nil, options: nil).first as! LightSettingView
    }
}

//
//  Setting.swift
//  ppLedc
//
//  Created by 柴荣臻 on 2019/7/18.
//  Copyright © 2019 rzchai. All rights reserved.
//

import UIKit

class Setting: NSObject {
    @objc var repeatMode : String = ""
    @objc var productionMode : String = ""
    @objc var autoUpdate : String = ""
    
    override init() {
        super.init()
    }
    
    init(dict: [String: String]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
}

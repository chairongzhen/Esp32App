//
//  UserInfo.swift
//  ppLedc
//
//  Created by 柴荣臻 on 2019/7/16.
//  Copyright © 2019 rzchai. All rights reserved.
//

import UIKit

class UserInfo: NSObject {
    @objc var uid : String = ""
    @objc var username : String = ""
    @objc var nickname : String = ""
    @objc var openid : String = ""
    
    override init() {
        super.init()
    }
    
    init(dict : [String : NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        print(key)
    }
}

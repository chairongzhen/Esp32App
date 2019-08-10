//
//  WechatUser.swift
//  ppLedc
//
//  Created by 柴荣臻 on 2019/8/9.
//  Copyright © 2019 rzchai. All rights reserved.
//

import UIKit

class WechatUser: NSObject {
    @objc var openid : String = ""
    @objc var expire_in : Int = 0
    @objc var refresh_token : String = ""
    @objc var access_token : String = ""
    @objc var scope : String = ""
    @objc var unionid : String = ""
    var headimgurl : String = ""
    var nickname : String = ""
    
    
    override init() {
        super.init()
    }
    
    init(dict : [String : NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
}

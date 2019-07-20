//
//  Machine.swift
//  ppLedc
//
//  Created by 柴荣臻 on 2019/7/18.
//  Copyright © 2019 rzchai. All rights reserved.
//

import UIKit

class Machine: NSObject {
    @objc var mid : String = ""
    @objc var mname : String = ""
    @objc var ip : String = ""
    @objc var online : String = ""
    
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

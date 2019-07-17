//
//  NSDate-Extension.swift
//  ppLedc
//
//  Created by 柴荣臻 on 2019/7/16.
//  Copyright © 2019 rzchai. All rights reserved.
//

import Foundation

extension NSDate {
    class func getCurrentTime() -> String {
        let nowDate = NSDate()
        let interval = nowDate.timeIntervalSince1970
        return "\(interval)"
    }
}

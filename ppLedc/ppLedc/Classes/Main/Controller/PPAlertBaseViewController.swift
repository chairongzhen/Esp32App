//
//  PPAlertBaseViewController.swift
//  ppLedc
//
//  Created by 柴荣臻 on 2019/7/17.
//  Copyright © 2019 rzchai. All rights reserved.
//

import UIKit

class PPAlertBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // 点击屏幕收起键盘
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension PPAlertBaseViewController {
    func autoHideAlertMessage(message: String) {
        let alertController = UIAlertController(title: message,
                                                message: nil, preferredStyle: .alert)
        self.present(alertController, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.presentedViewController?.dismiss(animated: false, completion: nil)
            
        }
    }    
    func getOpenid() -> String {
        guard let openid : String =  UserDefaults.standard.object(forKey: "openid") as? String else {
            return ""
        }
        return openid
    }
    
    func alertMessage(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func alertMessage(title: String, message: String, target: UIViewController) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        present(MainViewController(), animated: true, completion: nil)
    }
    
    func getCurrentTimeIndex() -> Int {
        var result : Int = 0
        for (index,val) in kXAxises.enumerated() {
            if val == getCurrentTimeLine() {
                result = index
                break;
            }
        }
        return result
    }
    
    func getSelectedTimeIndex(selected : String) -> Int {
        var result : Int = 0
        for (index,val) in kXAxises.enumerated() {
            if val == selected {
                result = index
                break;
            }
        }
        return result
    }
    
    func getSelectedtimeLine(value: Int) -> String {
        return kXAxises[value]
    }
    
    func getCurrentTimeLine() -> String {
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "aaa"
        let ma = formatter.string(from: currentDate)
        formatter.dateFormat = "hh"
        var hour : Int = Int(formatter.string(from: currentDate))!
        formatter.dateFormat = "mm"
        var minute : Int  = Int(formatter.string(from: currentDate))!
        
        if(ma == "PM") {
            hour = hour + 12
        }
        
        if minute == 0 {
            minute = 0
        } else if minute >= 0 && minute < 10 {
            minute = 10
        } else if minute >= 10 && minute < 20 {
            minute  = 20
        }
        else if minute >= 20 && minute < 30 {
            minute = 30
        } else if minute >= 30 && minute < 40 {
            minute = 40
        } else if minute >= 40 && minute < 50 {
            minute = 50
        } else if minute >= 50 && minute < 60 {
            hour = hour + 1
            if hour > 23 {
                hour = 0
            }
            minute = 0
        }
        
        var hourstr : String = String(hour)
        if hourstr.count == 1 {
            hourstr.insert("0", at: hourstr.startIndex)
        }
        
        var minstr : String = String(minute)
        if minstr.count == 1 {
            minstr.insert("0", at: minstr.startIndex)
        }
        return "\(hourstr):\(minstr)"
    }
    
    func locatePageContentView(currentView:UIViewController)->PageContentView{
        var vc:UIResponder = currentView
        while vc.isKind(of: PageContentView.self) != true {
            vc = vc.next!
        }
        return vc as! PageContentView
    }
    
    func locateMainController(currentView:UIView)->UIViewController{
        var vc:UIResponder = currentView
        while vc.isKind(of: UIViewController.self) != true {
            vc = vc.next!
        }
        return vc as! UIViewController
    }
    
}

//
//  SettingViewController.swift
//  ppLedc
//
//  Created by 柴荣臻 on 2019/7/14.
//  Copyright © 2019 rzchai. All rights reserved.
//

import UIKit
import SwiftyFORM
import SystemConfiguration.CaptiveNetwork
class SettingViewController: PPFormBaseViewController {
    let nickname = UserDefaults.standard.value(forKey: "nickname")
    
    override func populate(_ builder: FormBuilder) {
        let ssid = getUsedSSID()
        print(ssid)
        builder += SectionHeaderTitleFormItem().title("网络信息")
        builder += StaticTextFormItem().title("时区").value("中国")
        builder += StaticTextFormItem().title("网络").value(getUsedSSID())
        
        builder += SectionHeaderTitleFormItem().title("设备信息")
        builder += StaticTextFormItem().title("固件版本").value("1.01")
        builder += StaticTextFormItem().title("使用时间").value("10h")
        
        builder += SectionHeaderTitleFormItem().title("用户信息")
        builder += StaticTextFormItem().title("用户").value(nickname as! String)
        builder += StaticTextFormItem().title("使用时间").value("0h")
        builder += ViewControllerFormItem().title("退出登陆").viewController(NewLoginViewController.self)
    }
}

extension SettingViewController {
    private func getUsedSSID() -> String {
        let interfaces = CNCopySupportedInterfaces()
        var ssid = ""
        if interfaces != nil {
            let interfacesArray = CFBridgingRetain(interfaces) as! Array<AnyObject>
            if interfacesArray.count > 0 {
                let interfaceName = interfacesArray[0] as! CFString
                let ussafeInterfaceData = CNCopyCurrentNetworkInfo(interfaceName)
                if (ussafeInterfaceData != nil) {
                    let interfaceData = ussafeInterfaceData as! Dictionary<String, Any>
                    ssid = interfaceData["SSID"]! as! String
                }
            }
        }
        return ssid
    }
    
}

//class SettingViewController: PPBaseViewController {
//    private lazy var pageTitleView : PageTitleView = { [weak self] in
//        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
//        let titles  = ["模式设置","系统信息"]
//        let titleView = PageTitleView(frame: titleFrame, titles: titles)
//        titleView.delegate = self
//        return titleView
//        }()
//
//    private lazy var pageContentView : PageContentView = {[weak self] in
//        // Setting the content frame
//        let contentH = kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH - kTabBarH
//        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: contentH)
//
//        // Setting the child controller
//        var childVcs = [UIViewController]()
//        childVcs.append(ModeSetrtingViewController())
//        childVcs.append(SystemViewController())
////        for _ in 0..<1 {
////            var vc = UIViewController()
////            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
////            childVcs.append(vc)
////        }
//        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
//        contentView.delegate = self
//        return contentView
//        }()
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupUI()
//    }
//}
//
//// setting UI
//extension SettingViewController {
//    private func setupUI() {
//        // cancel the scrollview inner margin
//        if #available(iOS 11.0, *) {
//
//        } else {
//            automaticallyAdjustsScrollViewInsets = false
//        }
//
//
//
//
//        // setting title view
//        view.addSubview(pageTitleView)
//
//        // settting content view
//        view.addSubview(pageContentView)
//        pageContentView.backgroundColor = UIColor.purple
//    }
//
//}
//
//
//
//// take the pageTitleView 's protocol
//extension SettingViewController : PageTitleViewDelegate {
//    func pageTitleView(titleView: PageTitleView, selectIndex index: Int) {
//        pageContentView.setCurrentIndex(currentIndex: index)
//    }
//}
//
//
//// take the pageContentView 's protocol
//extension SettingViewController : PageContentViewDelegate {
//    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
//        pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
//    }
//}


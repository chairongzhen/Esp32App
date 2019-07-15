//
//  SettingViewController.swift
//  ppLedc
//
//  Created by 柴荣臻 on 2019/7/14.
//  Copyright © 2019 rzchai. All rights reserved.
//

import UIKit

private let kTitleViewH : CGFloat = 40

class SettingViewController: PPBaseViewController {
    private lazy var pageTitleView : PageTitleView = { [weak self] in
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles  = ["模式设置","系统信息"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
        }()
    
    private lazy var pageContentView : PageContentView = {[weak self] in
        // Setting the content frame
        let contentH = kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: contentH)
        
        // Setting the child controller
        var childVcs = [UIViewController]()
        for _ in 0..<2 {
            var vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        contentView.delegate = self
        return contentView
        }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// setting UI
extension SettingViewController {
    private func setupUI() {
        // cancel the scrollview inner margin
        automaticallyAdjustsScrollViewInsets = false
        
        
        // setting title view
        view.addSubview(pageTitleView)
        
        // settting content view
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.purple
    }
    
}



// take the pageTitleView 's protocol
extension SettingViewController : PageTitleViewDelegate {
    func pageTitleView(titleView: PageTitleView, selectIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}


// take the pageContentView 's protocol
extension SettingViewController : PageContentViewDelegate {
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}


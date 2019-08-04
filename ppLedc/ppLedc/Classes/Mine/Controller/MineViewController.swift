//
//  MineViewController.swift
//  ppLedc
//
//  Created by 柴荣臻 on 2019/7/14.
//  Copyright © 2019 rzchai. All rights reserved.
//

import UIKit
class MineViewController: PPBaseViewController {
    private lazy var pageTitleView : PageTitleView = { [weak self] in
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles  = ["我的设备","添加设备","扫一扫"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
        }()
    
      lazy var pageContentView : PageContentView = {[weak self] in
        // Setting the content frame
        let contentH = kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH - kTabBarH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: contentH)
        
        
        // Setting the child controller
        var childVcs = [UIViewController]()
        childVcs.append(MyViewController())
        childVcs.append(AddViewController())
        childVcs.append(QRCodeViewController())
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        contentView.delegate = self
        return contentView
        }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI();
    }
    
}


// setting UI
extension MineViewController {
    private func setupUI() {
        // cancel the scrollview inner margin
        automaticallyAdjustsScrollViewInsets = false
        
        // setting title view
        view.addSubview(pageTitleView)
        
        // settting content view
        view.addSubview(pageContentView)
        
        
    }
    
    func changeTitleIndex(sourceIndex : Int, targetIndex : Int) {
        pageTitleView.setCurrentIndex(sourceIndex : sourceIndex, targetIndex : targetIndex)
    }
    
    
    func reloadBinds() {
        
    }
}



// take the pageTitleView 's protocol
extension MineViewController : PageTitleViewDelegate {
    func pageTitleView(titleView: PageTitleView, selectIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}


// take the pageContentView 's protocol
extension MineViewController : PageContentViewDelegate {
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

//
//  BasicViewController.swift
//  ppLedc
//
//  Created by 柴荣臻 on 2019/7/12.
//  Copyright © 2019 rzchai. All rights reserved.
//

import UIKit


class BasicViewController:  PPBaseViewController {
    // lazy load properties
    private lazy var pageTitleView : PageTitleView = { [weak self] in
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles  = ["亮度设置"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    
    private lazy var pageContentView : PageContentView = {[weak self] in
        // Setting the content frame
        let contentH = kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH - kTabBarH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: contentH)
        
        // Setting the child controller
        var childVcs = [UIViewController]()
        childVcs.append(FixViewController())
//        for _ in 0..<1 {
//            var vc = UIViewController()
//            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
//            childVcs.append(vc)
//        }
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        contentView.delegate = self
        return contentView
    }()
    
    // system callback func
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI();
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
}

// setting UI
extension BasicViewController {
    private func setupUI() {
//        self.navigationController?.isNavigationBarHidden = false
        // cancel the scrollview inner margin
        if #available(iOS 11.0, *) {
            
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        
        // setting title view
        view.addSubview(pageTitleView)
        
        // settting content view
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.purple
    }
    
}

// take the pageTitleView 's protocol
extension BasicViewController : PageTitleViewDelegate {
    func pageTitleView(titleView: PageTitleView, selectIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}


// take the pageContentView 's protocol
extension BasicViewController : PageContentViewDelegate {
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}



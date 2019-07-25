//
//  PageTitleView.swift
//  ppLedc
//
//  Created by 柴荣臻 on 2019/7/13.
//  Copyright © 2019 rzchai. All rights reserved.
//

import UIKit

protocol PageTitleViewDelegate : class  {
    func pageTitleView(titleView : PageTitleView, selectIndex index : Int)
}

private let kScrollLineH : CGFloat = 2
private let kNormalColor : (CGFloat,CGFloat,CGFloat) = (85,85,85)
private let kSelectedColor : (CGFloat,CGFloat,CGFloat) = (255,128,0)

class PageTitleView: UIView {
    
    // define properties
    private var currentIndex : Int = 0
    private var titles: [String]
    
    weak var delegate : PageTitleViewDelegate?
    
    // lazy load title labels
    private lazy var titleLabels : [UILabel] = [UILabel]()
    
    // lazy load properties
    private lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.isPagingEnabled = false
        scrollView.bounces = false
        return scrollView
    }()
    
    private lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    // custom the constructor func
    init(frame: CGRect, titles: [String]) {
        self.titles = titles
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// Setting the UI
extension PageTitleView {
    private func setupUI(){
        // add scrollview
        addSubview(scrollView)
        scrollView.frame = bounds
        
        // add labels
        setupTitleLabels()
        
        // add bottom line and scroll block
        setupBottomLineAndScrollLine()
    }
    
    private func setupTitleLabels() {
        // 0 setting label common value
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - kScrollLineH
        let labelY : CGFloat = 0
        
        for(index,title) in titles.enumerated(){
            // 1. create label
            let label = UILabel()
            
            // 2. setting label properties
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            label.textAlignment = .center
            
            // 3. setting label frame
            let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            // 4. add label to the scrollview controller
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            // 5. set gesture to the label
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
        }
    }
    
    private func setupBottomLineAndScrollLine() {
        // 1. add bottom line
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        // 2. add scroll line
        // 2.1 get first label
        guard let firstLabel = titleLabels.first else {
            return
        }
        firstLabel.textColor = UIColor(r: kSelectedColor.0, g: kSelectedColor.1, b: kSelectedColor.2)
          // 2.2 setting scrollline properties
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
        
    }
}


// monitor label gesture
extension PageTitleView {
    @objc private func titleLabelClick(tapGes : UITapGestureRecognizer) {
        // 1. get current label 's tag
        guard let currentLabel =  tapGes.view as? UILabel else {
            return
        }
        
        // 2. get previous label 's tag
        let oldLabel = titleLabels[currentIndex]
        
        // 3. change the text color
        currentLabel.textColor = UIColor(r: kSelectedColor.0, g: kSelectedColor.1, b: kSelectedColor.2)
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        
        // 4. save newset labels's tag
        currentIndex = currentLabel.tag
        
        // 5. scroll position change
        let scrollLineX  = CGFloat(currentLabel.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15, animations: {
            self.scrollLine.frame.origin.x = scrollLineX
        })
        
        // 6. notify the agent
        delegate?.pageTitleView(titleView: self, selectIndex: currentIndex)
    }
}


// expose func
extension PageTitleView {
    func setCurrentIndex(sourceIndex : Int, targetIndex : Int) {
        currentIndex = targetIndex
        
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        sourceLabel.textColor = UIColor.gray
        targetLabel.textColor = UIColor.orange
        
        if targetIndex == 1 {
            scrollLine.frame.origin.x = targetLabel.frame.origin.x
        } else {
            scrollLine.frame.origin.x = 0
        }
    }
    func setTitleWithProgress(progress : CGFloat, sourceIndex : Int, targetIndex : Int) {
        // 1. get source & target label
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        // 2. setting the sliding logic
        let moveTotalX =  targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        // 3. setting color gradient logic
        // 3.1 define changing scope
        let colorDelta = (kSelectedColor.0 - kNormalColor.0,kSelectedColor.1 - kNormalColor.1,kSelectedColor.2 - kNormalColor.2)
        // 3.2 changing source label
        sourceLabel.textColor = UIColor(r: kSelectedColor.0 - colorDelta.0 * progress, g: kSelectedColor.1 - colorDelta.1 * progress, b: kSelectedColor.2 - colorDelta.2 * progress)
        // 3.3 changing targe label
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        
        // 4. save the current index
        currentIndex = targetIndex
        
    }
}

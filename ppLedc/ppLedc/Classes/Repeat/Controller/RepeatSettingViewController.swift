//
//  RepeatSettingViewController.swift
//  ppLedc
//
//  Created by 柴荣臻 on 2019/7/23.
//  Copyright © 2019 rzchai. All rights reserved.
//

import UIKit
import Charts


class RepeatSettingViewController: PPAlertBaseViewController {
    private lazy var chartView: LineChartView = LineChartView()
    private lazy var timeStepper : UIStepper = UIStepper()
    private lazy var txtTime : UITextField = UITextField()
    private lazy var imgTime : UIImageView = UIImageView()
    private lazy var sliderTime : UISlider = UISlider()
    private lazy var btnAdd : UIButton = UIButton()
    private lazy var btnMinus : UIButton = UIButton()
    private lazy var btnModify : UIButton = UIButton()
    private lazy var btnNext : UIButton = UIButton()
    private lazy var btnPrevious : UIButton = UIButton()
    private lazy var btnEmpty : UIButton = UIButton()
    private lazy var repeatViewModel : RepeatViewModel = RepeatViewModel()
    
//    private lazy var buttonGroupView : ButtonGroupView = {
//       let groupView = ButtonGroupView.buttonGroupView()
//       return groupView
//    }()
    private var tags : [Int] = [0,143,144]
    private var l1val : [Int] = [0,0,0]
    private var l2val : [Int] = [0,0,0]
    private var l3val : [Int] = [0,0,0]
    private var l4val : [Int] = [0,0,0]
    private var l5val : [Int] = [0,0,0]
    private var l6val : [Int] = [0,0,0]
    private var l7val : [Int] = [0,0,0]
    private var l8val : [Int] = [0,0,0]
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
}


extension RepeatSettingViewController {
    private func setupUI() {
        self.view.backgroundColor = UIColor.white
        drawTimeTextField()
        drawTimeStepper()
        drawChart()
        drawBottomSlider()
        drawButtonGroup()
    }
    
    private func drawButtonGroup() {
//        buttonGroupView.frame = CGRect(x: 30, y: 290, width: kScreenW, height: 40)
//        self.view.addSubview(buttonGroupView)
        btnAdd.frame = CGRect(x: 30, y: 270, width: 44, height: 44)
        btnAdd.setImage(UIImage(named: "repeatadd"), for: .normal)
        btnAdd.addTarget(self, action: #selector(btnAddClicked), for: .touchUpInside)
        self.view.addSubview(btnAdd)
        
        btnMinus.frame = CGRect(x: 84, y: 270, width: 44, height: 44)
        btnMinus.setImage(UIImage(named: "minus"), for: .normal)
        btnMinus.addTarget(self, action: #selector(btnMinusClicked), for: .touchUpInside)
        btnMinus.isEnabled = false
        self.view.addSubview(btnMinus)
        
        btnModify.frame = CGRect(x: 138, y: 270, width: 44, height: 44)
        btnModify.setImage(UIImage(named: "modify"), for: .normal)
        btnModify.addTarget(self, action: #selector(btnModifyClicked), for: .touchUpInside)
        btnModify.isEnabled = false
        self.view.addSubview(btnModify)
        
        btnNext.frame = CGRect(x: 192, y: 270, width: 44, height: 44)
        btnNext.setImage(UIImage(named: "next"), for: .normal)
        btnNext.addTarget(self, action: #selector(btnNextClicked), for: .touchUpInside)
        self.view.addSubview(btnNext)
        
        btnPrevious.frame = CGRect(x: 248, y: 270, width: 44, height: 44)
        btnPrevious.setImage(UIImage(named: "previous"), for: .normal)
        btnPrevious.addTarget(self, action: #selector(btnPreviousClicked), for: .touchUpInside)
        self.view.addSubview(btnPrevious)
        
        btnEmpty.frame = CGRect(x: 302, y: 270, width: 44, height: 44)
        btnEmpty.setImage(UIImage(named: "trash"), for: .normal)
        btnEmpty.addTarget(self, action: #selector(btnEmptyClicked), for: .touchUpInside)
        self.view.addSubview(btnEmpty)
        
    }
    
    private func drawBottomSlider() {
        sliderTime.frame = CGRect(x: 20, y: 240, width: kScreenW - 50, height: 20)
        sliderTime.minimumValue = 0
        sliderTime.maximumValue = 143
        sliderTime.tintColor = UIColor.orange
        sliderTime.isContinuous = true
        let currentIndex = getCurrentTimeIndex()
        sliderTime.value = Float(currentIndex)
        sliderTime.addTarget(self, action: #selector(sliderTimeChanged(slider:)), for: UIControl.Event.valueChanged)
        
        self.view.addSubview(sliderTime)
    }

    
    private func drawTimeTextField() {
        imgTime.frame = CGRect(x: kScreenW / 2  - 45, y: 13, width: 18, height: 18)
        imgTime.image = UIImage(named: "clock")
        self.view.addSubview(imgTime)
        txtTime.frame = CGRect(x: kScreenW / 2 - 45 , y: 10, width: 90, height: 25)
        txtTime.text = self.getCurrentTimeLine()
        txtTime.textColor = .orange
        txtTime.textAlignment = .center
        txtTime.borderStyle = .none
        txtTime.isEnabled = false
        let currentIndex = getCurrentTimeIndex()
        let currentTimeLine = ChartLimitLine(limit: Double(currentIndex), label: "")
        currentTimeLine.lineColor = .green
        currentTimeLine.lineWidth = 2
        chartView.xAxis.addLimitLine(currentTimeLine)
        timeStepper.value = Double(currentIndex)
        self.view.addSubview(txtTime)
    }
    
    private func drawTimeStepper() {
        timeStepper.frame = CGRect(x: kScreenW / 2 - 50, y: 40, width: 50, height: 30)
        timeStepper.maximumValue = 143
        timeStepper.minimumValue = 0
        timeStepper.stepValue = 1
        timeStepper.isContinuous = true
        timeStepper.wraps = true
        timeStepper.tintColor = .orange
        timeStepper.addTarget(self, action: #selector(timeStepperChanged(sender:)), for: .valueChanged)
        timeStepper.value = Double(getCurrentTimeIndex())
        self.view.addSubview(timeStepper)
    }


    
    private func drawChartLine(timeline : Double) {
        for line in chartView.xAxis.limitLines {
            chartView.xAxis.removeLimitLine(line)
        }
        let currentTimeLine = ChartLimitLine(limit: timeline, label: "")
        
        if self.tags.contains(Int(timeline)) {
            btnMinus.isEnabled = true
            btnModify.isEnabled = true
        } else {
            btnMinus.isEnabled = false
            btnModify.isEnabled = false
        }
        
        currentTimeLine.lineColor = .orange
        currentTimeLine.lineWidth = 2
        chartView.xAxis.addLimitLine(currentTimeLine)
        chartView.data?.notifyDataChanged()
        chartView.notifyDataSetChanged()
    }
    
    private func drawChart() {
        self.chartView.frame = CGRect(x: 0, y: 80, width: kScreenW - 20, height:  180)
        chartView.delegate = self
        self.view.addSubview(chartView)
        getData()
        chartSetting()
    }
    
    private func chartSetting() {
        
        // bind data for eight lines
        var dataEntries1 = [ChartDataEntry]()
        var dataEntries2 = [ChartDataEntry]()
        var dataEntries3 = [ChartDataEntry]()
        var dataEntries4 = [ChartDataEntry]()
        var dataEntries5 = [ChartDataEntry]()
        var dataEntries6 = [ChartDataEntry]()
        var dataEntries7 = [ChartDataEntry]()
        var dataEntries8 = [ChartDataEntry]()
        var i = 0
        for element in tags {
            let entry1 = ChartDataEntry.init(x: Double(element), y: Double(l1val[i]))
            dataEntries1.append(entry1)
            
            let entry2 = ChartDataEntry.init(x: Double(element), y: Double(l2val[i]))
            dataEntries2.append(entry2)
            
            let entry3 = ChartDataEntry.init(x: Double(element), y: Double(l3val[i]))
            dataEntries3.append(entry3)
            
            let entry4 = ChartDataEntry.init(x: Double(element), y: Double(l4val[i]))
            dataEntries4.append(entry4)
            
            let entry5 = ChartDataEntry.init(x: Double(element), y: Double(l5val[i]))
            dataEntries5.append(entry5)
            
            let entry6 = ChartDataEntry.init(x: Double(element), y: Double(l6val[i]))
            dataEntries6.append(entry6)
            
            let entry7 = ChartDataEntry.init(x: Double(element), y: Double(l7val[i]))
            dataEntries7.append(entry7)
            
            let entry8 = ChartDataEntry.init(x: Double(element), y: Double(l8val[i]))
            dataEntries8.append(entry8)
            i = i + 1
        }
        let chartDataSet1 = LineChartDataSet(entries: dataEntries1, label: "")
        let chartDataSet2 = LineChartDataSet(entries: dataEntries2, label: "")
        let chartDataSet3 = LineChartDataSet(entries: dataEntries3, label: "")
        let chartDataSet4 = LineChartDataSet(entries: dataEntries4, label: "")
        let chartDataSet5 = LineChartDataSet(entries: dataEntries5, label: "")
        let chartDataSet6 = LineChartDataSet(entries: dataEntries6, label: "")
        let chartDataSet7 = LineChartDataSet(entries: dataEntries7, label: "")
        let chartDataSet8 = LineChartDataSet(entries: dataEntries8, label: "")
        
        let chartData = LineChartData(dataSets: [chartDataSet1,chartDataSet2,chartDataSet3,chartDataSet4,chartDataSet5,chartDataSet6,chartDataSet7,chartDataSet8])
//        let chartData = LineChartData(dataSets: [chartDataSet1])
        chartView.data = chartData
        
        
        // setting Line display style
        chartDataSet1.lineWidth = 1.5
        chartDataSet1.mode = .horizontalBezier
        chartDataSet1.circleRadius = 2
        chartDataSet1.circleHoleRadius = 2
        chartDataSet1.drawValuesEnabled = false;
        chartDataSet1.colors = [.orange]
        chartDataSet1.highlightLineWidth = 2
        chartDataSet1.drawHorizontalHighlightIndicatorEnabled = false
        chartDataSet1.circleColors = [.orange]
        
        
        chartDataSet2.lineWidth = 1.5
        chartDataSet2.mode = .horizontalBezier
        chartDataSet2.circleRadius = 2
        chartDataSet2.circleHoleRadius = 2
        chartDataSet2.drawValuesEnabled = false;
        chartDataSet2.colors = [.cyan]
        chartDataSet2.highlightLineWidth = 2
        chartDataSet2.drawHorizontalHighlightIndicatorEnabled = false
        chartDataSet2.circleColors = [.orange]
        
        chartDataSet3.lineWidth = 1.5
        chartDataSet3.mode = .horizontalBezier
        chartDataSet3.circleRadius = 2
        chartDataSet3.circleHoleRadius = 2
        chartDataSet3.drawValuesEnabled = false;
        chartDataSet3.colors = [.red]
        chartDataSet3.highlightLineWidth = 2
        chartDataSet3.drawHorizontalHighlightIndicatorEnabled = false
        chartDataSet3.circleColors = [.orange]
        
        chartDataSet4.lineWidth = 1.5
        chartDataSet4.mode = .horizontalBezier
        chartDataSet4.circleRadius = 2
        chartDataSet4.circleHoleRadius = 2
        chartDataSet4.drawValuesEnabled = false;
        chartDataSet4.colors = [.green]
        chartDataSet4.highlightLineWidth = 2
        chartDataSet4.drawHorizontalHighlightIndicatorEnabled = false
        chartDataSet4.circleColors = [.orange]
        
        chartDataSet5.lineWidth = 1.5
        chartDataSet5.mode = .horizontalBezier
        chartDataSet5.circleRadius = 2
        chartDataSet5.circleHoleRadius = 2
        chartDataSet5.drawValuesEnabled = false;
        chartDataSet5.colors = [.purple]
        chartDataSet5.highlightLineWidth = 2
        chartDataSet5.drawHorizontalHighlightIndicatorEnabled = false
        chartDataSet5.circleColors = [.orange]
        
        chartDataSet6.lineWidth = 1.5
        chartDataSet6.mode = .horizontalBezier
        chartDataSet6.circleRadius = 2
        chartDataSet6.circleHoleRadius = 2
        chartDataSet6.drawValuesEnabled = false;
        chartDataSet6.colors = [.red]
        chartDataSet6.highlightLineWidth = 2
        chartDataSet6.drawHorizontalHighlightIndicatorEnabled = false
        chartDataSet6.circleColors = [.orange]
        
        chartDataSet7.lineWidth = 1.5
        chartDataSet7.mode = .horizontalBezier
        chartDataSet7.circleRadius = 2
        chartDataSet7.circleHoleRadius = 2
        chartDataSet7.drawValuesEnabled = false;
        chartDataSet7.colors = [.darkGray]
        chartDataSet7.highlightLineWidth = 2
        chartDataSet7.drawHorizontalHighlightIndicatorEnabled = false
        chartDataSet7.circleColors = [.orange]
        
        chartDataSet8.lineWidth = 1.5
        chartDataSet8.mode = .horizontalBezier
        chartDataSet8.circleRadius = 2
        chartDataSet8.circleHoleRadius = 2
        chartDataSet8.drawValuesEnabled = false;
        chartDataSet8.colors = [.blue]
        chartDataSet8.highlightLineWidth = 2
        chartDataSet8.drawHorizontalHighlightIndicatorEnabled = false
        chartDataSet8.circleColors = [.orange]
        
        
        // setting chart style
        chartView.noDataText = "暂无数据"
        chartView.scaleYEnabled = false;
        chartView.scaleXEnabled = false;
        chartView.dragEnabled = false;
        chartView.dragDecelerationEnabled = false
        chartView.legend.form = .none
        chartView.xAxis.labelPosition = .bothSided
        chartView.xAxis.axisLineWidth = 2
        chartView.xAxis.axisMinimum = 0
        chartView.xAxis.axisMaximum = 144
        chartView.leftAxis.axisMinimum = 0
        chartView.leftAxis.axisMaximum = 120
        chartView.rightAxis.enabled = false
        chartView.xAxis.granularity = 24
        chartView.leftAxis.granularity = 25
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: kXAxises)
        
    }
    
    private func getData() {
        repeatViewModel.getRepeatData(openid: getOpenid()) { (message) in
            self.tags = self.repeatViewModel.tags
            self.l1val = self.repeatViewModel.l1val
            self.l2val = self.repeatViewModel.l2val
            self.l3val = self.repeatViewModel.l3val
            self.l4val = self.repeatViewModel.l4val
            self.l5val = self.repeatViewModel.l5val
            self.l6val = self.repeatViewModel.l6val
            self.l7val = self.repeatViewModel.l7val
            self.l8val = self.repeatViewModel.l8val

            var has0 : Bool = false
            var has143 : Bool = false
            
            for el in self.tags {
                if el == 0 {
                    has0 = true
                } else if el == 143 {
                    has143 = true
                }
            }
            
            if !has0 {
                self.tags.insert(0, at: 0)
                self.l1val.insert(0, at:0)
                self.l2val.insert(0, at: 0)
                self.l3val.insert(0, at: 0)
                self.l4val.insert(0, at: 0)
                self.l5val.insert(0, at: 0)
                self.l6val.insert(0, at: 0)
                self.l7val.insert(0, at: 0)
                self.l8val.insert(0, at: 0)
            }
            if !has143 {
                self.tags.append(143)
                self.l1val.append(0)
                self.l2val.append(0)
                self.l3val.append(0)
                self.l4val.append(0)
                self.l5val.append(0)
                self.l6val.append(0)
                self.l7val.append(0)
                self.l8val.append(0)
            }
            self.tags.append(144)
            self.l1val.append(self.l1val[0])
            self.l2val.append(self.l2val[0])
            self.l3val.append(self.l3val[0])
            self.l4val.append(self.l4val[0])
            self.l5val.append(self.l5val[0])
            self.l6val.append(self.l6val[0])
            self.l7val.append(self.l7val[0])
            self.l8val.append(self.l8val[0])
            
            self.chartSetting()
        }
    }
    
    

}

extension RepeatSettingViewController {
    @objc private func sliderTimeChanged(slider:UISlider) {
        timeStepper.value = Double(slider.value)
        txtTime.text = kXAxises[Int(slider.value)]
        drawChartLine(timeline: Double(slider.value))
        
    }
    
    @objc private func timeStepperChanged(sender: UIStepper) {
        let currentval : Int  = Int(sender.value)
        txtTime.text = kXAxises[currentval]
        drawChartLine(timeline: Double(currentval))
    }
    
    @objc private func btnAddClicked() {
        let pageContentView : PageContentView = self.locatePageContentView(currentView: self)
        let mainViewController : RepeatViewController = self.locateMainController(currentView: pageContentView) as! RepeatViewController
        mainViewController.changeTitleIndex(sourceIndex: 0, targetIndex: 1)
        pageContentView.setCurrentIndex(currentIndex: 1)
    }
    
    @objc private func btnMinusClicked() {
        let current : Int = Int(self.chartView.xAxis.limitLines[0].limit)
        repeatViewModel.delTag(openid: self.getOpenid(), tag: String(current)) { (message) in
            if message == "success" {
                self.getData()
                self.chartView.data?.notifyDataChanged()
                self.chartView.notifyDataSetChanged()
            } else {
                self.autoHideAlertMessage(message: "数据异常,请联系商家")
            }
        }
    }
    
    @objc private func btnModifyClicked() {
        let pageContentView : PageContentView = self.locatePageContentView(currentView: self)
        let mainViewController : RepeatViewController = self.locateMainController(currentView: pageContentView) as! RepeatViewController
        mainViewController.changeTitleIndex(sourceIndex: 0, targetIndex: 1)
        pageContentView.setCurrentIndex(currentIndex: 1)
    }
    
    @objc private func btnNextClicked() {
        var current : Int = 0
        if self.chartView.xAxis.limitLines.count == 0 {
            current  = self.getCurrentTimeIndex()
        } else {
            current = Int(self.chartView.xAxis.limitLines[0].limit)
        }
        
        for val in self.tags {
            if current == 143 {
                drawChartLine(timeline: Double(0))
                break;
            } else if val > current {
                drawChartLine(timeline: Double(val))
                break;
            }
        }
    }
    
    @objc private func btnPreviousClicked() {
        var current : Int = 0
        if self.chartView.xAxis.limitLines.count == 0 {
            current  = self.getCurrentTimeIndex()
        } else {
            current = Int(self.chartView.xAxis.limitLines[0].limit)
        }
        
        for val in self.tags.reversed() {
            if current == 0 {
                drawChartLine(timeline: Double(143))
                break;
            } else if val < current {
                drawChartLine(timeline: Double(val))
                break;
            }
        }
    }
    
    @objc private func btnEmptyClicked() {
        repeatViewModel.emptyTags(openid: self.getOpenid()) { (message) in
            if message == "success" {
                self.getData()
                self.chartView.data?.notifyDataChanged()
                self.chartView.notifyDataSetChanged()
            } else {
                self.autoHideAlertMessage(message: "数据异常,请联系商家")
            }
        }
    }
}

extension RepeatSettingViewController : ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print("选中了一个数据")
    }
    
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
        print("取消选中的数据")
    }
}

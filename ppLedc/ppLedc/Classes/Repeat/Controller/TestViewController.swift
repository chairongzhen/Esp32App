//
//  TestViewController.swift
//  ppLedc
//
//  Created by 柴荣臻 on 2019/7/23.
//  Copyright © 2019 rzchai. All rights reserved.
//

import UIKit
import Charts

class TestViewController: UIViewController {

    private lazy var chartView: LineChartView = LineChartView()
    var circleColors : [UIColor] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
}


extension TestViewController: ChartViewDelegate {
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print("选中了一个数据")
        var chartDataSet = LineChartDataSet()
        chartDataSet = (chartView.data?.dataSets[0] as? LineChartDataSet)!
        let values = chartDataSet.entries
        let index = values.firstIndex(where: {$0.x == highlight.x})
        chartDataSet.circleColors = circleColors
        chartDataSet.circleColors[index!] = .orange
        
        chartView.data?.notifyDataChanged()
        chartView.notifyDataSetChanged()
    }
    
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
        print("取消选中的数据")
        var chartDataSet = LineChartDataSet()
        chartDataSet = (chartView.data?.dataSets[0] as? LineChartDataSet)!
        chartDataSet.circleColors = circleColors
        
        chartView.data?.notifyDataChanged()
        chartView.notifyDataSetChanged()
    }
    
    
    private func setupUI() {
        self.view.backgroundColor = UIColor.white
        chartView.frame = CGRect(x: 20, y: 20, width: kScreenW-20, height: 300)
        getChartData()
        chartView.delegate = self
        self.view.addSubview(chartView)
    }
    
    
    
    private func getChartData() {
        
        var dataEntries1 = [ChartDataEntry]()
        for i in 0..<8 {
            let y = arc4random()%100
            let entry = ChartDataEntry.init(x: Double(i), y: Double(y))
            dataEntries1.append(entry)
        }
        let chartDataSet1 = LineChartDataSet(entries: dataEntries1, label: "李子明")
        chartDataSet1.colors = [.orange]
        chartDataSet1.lineWidth = 2
        chartDataSet1.circleColors = [.red]
        chartDataSet1.circleHoleColor = .purple
        chartDataSet1.circleRadius = 6
        chartDataSet1.circleHoleRadius = 2
        
        var dataEntries2 = [ChartDataEntry]()
        for i in 0..<8 {
            let y = arc4random()%100
            let entry = ChartDataEntry.init(x: Double(i), y: Double(y))
            dataEntries2.append(entry)
        }
        let chartDataSet2 = LineChartDataSet(entries: dataEntries2, label: "王大锤")
        chartDataSet2.colors = [.blue]
        chartDataSet2.lineWidth = 2
        chartDataSet2.drawCirclesEnabled = false
        
        var dataEntries3 = [ChartDataEntry]()
        for i in 0..<8 {
            let y = arc4random()%100
            let entry = ChartDataEntry.init(x: Double(i), y: Double(y))
            dataEntries3.append(entry)
        }
        let chartDataSet3 = LineChartDataSet(entries: dataEntries3, label: "")
        chartDataSet3.colors = [.green]
        chartDataSet3.lineWidth = 1
        chartDataSet3.drawCircleHoleEnabled = false
        
        var dataEntries4 = [ChartDataEntry]()
        let entry0 = ChartDataEntry.init(x: Double(0), y: Double(0))
        dataEntries4.append(entry0)
        circleColors.append(.yellow)
        let entry1 = ChartDataEntry.init(x: Double(35), y: Double(100))
        dataEntries4.append(entry1)
        circleColors.append(.yellow)
        let entry2 = ChartDataEntry.init(x: Double(80), y: Double(75))
        dataEntries4.append(entry2)
        circleColors.append(.yellow)
        let entry3 = ChartDataEntry.init(x: Double(120), y: Double(20))
        dataEntries4.append(entry3)
        circleColors.append(.yellow)
        let entry4 = ChartDataEntry.init(x: Double(130), y: Double(60))
        dataEntries4.append(entry4)
        circleColors.append(.yellow)
        let entry5 = ChartDataEntry.init(x: Double(143), y: Double(10))
        dataEntries4.append(entry5)
        circleColors.append(.yellow)
        let entry6 = ChartDataEntry.init(x: Double(144), y: Double(0))
        dataEntries4.append(entry6)
        circleColors.append(.yellow)
        
        let chartDataSet4 = LineChartDataSet(entries: dataEntries4, label: "")
        chartDataSet4.colors = [.green]
        chartDataSet4.lineWidth = 1
        chartDataSet4.drawCircleHoleEnabled = false
        chartDataSet4.mode = .horizontalBezier
        chartDataSet4.drawValuesEnabled = false
        chartDataSet4.drawFilledEnabled = true
        chartDataSet4.fillColor = .green
        chartDataSet4.fillAlpha = 0.1
        chartDataSet4.highlightColor = .blue
        chartDataSet4.highlightLineWidth = 2
        chartDataSet4.highlightLineDashLengths = [4,2]
        chartDataSet4.drawHorizontalHighlightIndicatorEnabled = false
        chartDataSet4.circleColors = circleColors
        
        
        
        let chartData = LineChartData(dataSets: [chartDataSet4])
        chartView.data = chartData
        
        chartView.noDataText = "暂无数据"
        chartView.scaleYEnabled = false;
        chartView.scaleXEnabled = false;
        chartView.dragEnabled = false;
        chartView.dragDecelerationEnabled = false
        chartView.dragDecelerationFrictionCoef = 0.9
        chartView.drawGridBackgroundEnabled = true
        chartView.drawBordersEnabled = true
        
        chartView.drawGridBackgroundEnabled = true
        chartView.borderLineWidth = 3
        chartView.legend.textColor = .purple
        chartView.legend.form = .none
        chartView.xAxis.labelPosition = .bothSided
        chartView.xAxis.axisLineWidth = 2
        chartView.xAxis.axisLineColor = .orange
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.xAxis.axisMinimum = 0
        chartView.xAxis.axisMaximum = 144
        chartView.leftAxis.axisMinimum = 0
        chartView.leftAxis.axisMaximum = 100
        chartView.rightAxis.axisMinimum = 0
        chartView.rightAxis.axisMaximum = 0
        
        
        chartView.xAxis.granularity = 24
        let xValues = ["0:00", "0:10", "0:20", "0:30", "0:40", "0:50",
                       "1:00", "1:10", "1:20", "1:30", "1:40", "1:50",
                       "2:00", "2:10", "2:20", "2:30", "2:40", "2:50",
                       "3:00", "3:10", "3:20", "3:30", "3:40", "3:50",
                       "4:00", "4:10", "4:20", "4:30", "4:40", "4:50",
                       "5:00", "5:10", "5:20", "5:30", "5:40", "5:50",
                       "6:00", "6:10", "6:20", "6:30", "6:40", "6:50",
                       "7:00", "7:10", "7:20", "7:30", "7:40", "7:50",
                       "8:00", "8:10", "8:20", "8:30", "8:40", "8:50",
                       "9:00", "9:10", "9:20", "9:30", "9:40", "9:50",
                       "10:00", "10:10", "10:20", "10:30", "10:40", "10:50",
                       "11:00", "11:10", "11:20", "11:30", "11:40", "11:50",
                       "12:00", "12:10", "12:20", "12:30", "12:40", "12:50",
                       "13:00", "13:10", "13:20", "13:30", "13:40", "13:50",
                       "14:00", "14:10", "14:20", "14:30", "14:40", "14:50",
                       "15:00", "15:10", "15:20", "15:30", "15:40", "15:50",
                       "16:00", "16:10", "16:20", "16:30", "16:40", "16:50",
                       "17:00", "17:10", "17:20", "17:30", "17:40", "17:50",
                       "18:00", "18:10", "18:20", "18:30", "18:40", "18:50",
                       "19:00", "19:10", "19:20", "19:30", "19:40", "19:50",
                       "20:00", "20:10", "20:20", "20:30", "20:40", "20:50",
                       "21:00", "21:10", "21:20", "21:30", "21:40", "21:50",
                       "22:00", "22:10", "22:20", "22:30", "22:40", "22:50",
                       "23:00", "23:10", "23:20", "23:30", "23:40", "23:50","00:00"
        ]
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: kXAxises)
        let limitline = ChartLimitLine(limit: 90, label: "强光")
        chartView.xAxis.addLimitLine(limitline)
    
        
        
    }
}

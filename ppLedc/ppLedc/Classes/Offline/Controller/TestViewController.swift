import UIKit

//UIPickerView 的委托协议是 UIPickerViewDelegate，数据源是 UIPickerViewDataSource。我们需要在视图控制器中声明实现 UIPiekerViewDelegate 和 UIPickerViewDataSource 协议。
class TestViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var label: UILabel!
    var pickerView: UIPickerView!
    var pickerData: [String] = ["放假","旅游","上班"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 创建视图
        let screen = UIScreen.main.bounds
        // 设置 根视图背景色
        self.view.backgroundColor = UIColor.white
        
        self.pickerView = UIPickerView(frame: CGRect(x:0, y: 0,width: kScreenW, height: 200))
        //因为该Controller中实现了UIPickerViewDataSource接口所以将dataSource设置成自己
        self.pickerView.dataSource = self
        //将delegate设置成自己
        self.pickerView.delegate = self
        self.view.addSubview(self.pickerView)
        
    
    
        // 添加标签
        let labelwidth:CGFloat = 200
        let labelheight:CGFloat = 21
        let labelTopView:CGFloat = 281
        self.label = UILabel(frame: CGRect(x:(screen.size.width - labelwidth)/2, y: labelTopView, width: labelwidth, height: labelheight))
        self.label.text = "Label"
        // 字体左右居中
        self.label.textAlignment = .center
        self.view.addSubview(self.label)
        
        
        // button 按钮
        let button = UIButton(type: .system)
        button.setTitle("Button", for: .normal)
        let buttonwidth:CGFloat = 46
        let buttonheight:CGFloat = 30
        let buttonTopView:CGFloat = 379
        button.frame = CGRect(x: (screen.size.width - buttonwidth)/2, y: buttonTopView, width: buttonwidth, height: buttonheight)
        //事件
        button.addTarget(self, action: #selector(onclick(_:)), for: .touchUpInside)
        self.view.addSubview(button)
        
    }
    //设置选择框的总列数,继承于UIPickViewDataSource协议
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //设置选择框的总行数,继承于UIPickViewDataSource协议
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickerData.count

    }
    //设置选项框各选项的内容,继承于UIPickViewDelegate协议
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return self.pickerData[row]
    }
    //选择控件的事件选择
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selected = self.pickerData[row] as String
        label.text = selected
    }
    //设置每行选项的高度
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 45.0
    }
    // 获取值
    @objc func onclick(_ sender: AnyObject) {
        //获得2列选取值的下标
        let row = self.pickerView.selectedRow(inComponent: 0)
        // 根据下标获取值
        let selected = self.pickerData[row] as String
        //拼接值
        let title = String(format: "%@", selected)
        self.label.text = title
    }
}

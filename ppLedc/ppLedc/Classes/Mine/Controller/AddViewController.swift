//
//  AddViewController.swift
//  ppLedc
//
//  Created by 柴荣臻 on 2019/8/4.
//  Copyright © 2019 rzchai. All rights reserved.
//

import UIKit
import AVFoundation
import QRCodeReader

class AddViewController: PPAlertBaseViewController,QRCodeReaderViewControllerDelegate {
    @IBOutlet weak var txtAdd: UITextField!
    @IBOutlet weak var btnAdd: UIButton!

    @IBOutlet weak var btnScan: UIButton!
    private lazy var myViewModel : MyViewModel = MyViewModel()
    lazy var readerVC: QRCodeReaderViewController = {
        let builder = QRCodeReaderViewControllerBuilder {
            $0.reader = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
            
            // Configure the view controller (optional)
            $0.showTorchButton        = true
            $0.showSwitchCameraButton = false
            $0.showCancelButton       = true
            $0.showOverlayView        = true
            $0.rectOfInterest         = CGRect(x: 0.2, y: 0.3, width: 0.6, height: 0.4)
        }
        return QRCodeReaderViewController(builder: builder)
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // 点击屏幕收起键盘
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension AddViewController {
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        reader.stopScanning()
        dismiss(animated: true, completion: nil)
        let midStr = result.value
        if(midStr.count > 0) {
            var mid : String = midStr.replacingOccurrences(of: "{", with: "").replacingOccurrences(of: "}", with: "").split(separator: ",")[0].replacingOccurrences(of: "mid:", with: "")
            var midTemp  = midStr.replacingOccurrences(of: "{", with: "").replacingOccurrences(of: "}", with: "").split(separator: ",")
            if midTemp.count > 0 {
                mid = midTemp[0].replacingOccurrences(of: "mid:", with: "")
            }
            if self.checkEspId(input: mid) {
                self.bindMid(mid: mid)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue:"binded"), object: nil, userInfo: nil)
                let pageContentView : PageContentView = self.locatePageContentView(currentView: self)
                let mainViewController : MineViewController = self.locateMainController(currentView: pageContentView) as! MineViewController
                mainViewController.changeTitleIndex(sourceIndex: 0, targetIndex: 1)
                pageContentView.setCurrentIndex(currentIndex: 1)

            } else {
                self.autoHideAlertMessage(message: "设备编号有误,请检查二维码")
            }
        }
        
    }
    
    func readerDidCancel(_ reader: QRCodeReaderViewController) {
        reader.stopScanning()
        dismiss(animated: true, completion: nil)
    }
}

extension AddViewController {
    private func setupUI() {
        txtAdd.layer.borderColor = UIColor.orange.cgColor
        txtAdd.layer.borderWidth = 1
    }
    
    private func  bindMid(mid : String) {
        let openid: String = self.getOpenid()
        if openid == "" { return }
        myViewModel.bindMid(openid: openid, mid: mid) { (message) in
            if message == "success" {
                print("machine name: \(mid) has added")
                self.autoHideAlertMessage(message: "添加成功")
                } else {
                self.autoHideAlertMessage(message: message)
                }
        }
    }
    
    private func showError() {
        self.autoHideAlertMessage(message: "失败了")
    }
}

extension AddViewController {
    @IBAction func btnAddClicked(_ sender: Any) {
        if txtAdd.text == "" {
            self.autoHideAlertMessage(message: "设备号不能为空")
            return;
        }
        let mid = "esp_" + txtAdd.text!.uppercased()
        if !self.checkEspId(input: mid) {
                self.autoHideAlertMessage(message: "设备号格式有误,请检查后重新输入")
                txtAdd.text = ""
                return;
            } else {
                bindMid(mid: mid)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue:"binded"), object: nil, userInfo: nil)
                txtAdd.text = ""
                let pageContentView : PageContentView = self.locatePageContentView(currentView: self)
                let mainViewController : MineViewController = self.locateMainController(currentView: pageContentView) as! MineViewController
                mainViewController.changeTitleIndex(sourceIndex: 0, targetIndex: 1)
                pageContentView.setCurrentIndex(currentIndex: 1)
            }

    }
    @IBAction func btnScanClicked(_ sender: Any) {
        readerVC.delegate = self
//        readerVC.completionBlock = { (result: QRCodeReaderResult?) in
//            let midStr = result?.value ?? ""
//            if(midStr.count > 0) {
//                var mid : String = midStr.replacingOccurrences(of: "{", with: "").replacingOccurrences(of: "}", with: "").split(separator: ",")[0].replacingOccurrences(of: "mid:", with: "")
//                var midTemp  = midStr.replacingOccurrences(of: "{", with: "").replacingOccurrences(of: "}", with: "").split(separator: ",")
//                if midTemp.count > 0 {
//                    mid = midTemp[0].replacingOccurrences(of: "mid:", with: "")
//                }
//                self.bindMid(mid: mid)
//                if self.checkEspId(input: mid) {
//                    NotificationCenter.default.post(name: NSNotification.Name(rawValue:"binded"), object: nil, userInfo: nil)
//                }
//            }
//        }
        readerVC.modalPresentationStyle = .formSheet
        present(readerVC, animated: true, completion: nil)
    }
    
}

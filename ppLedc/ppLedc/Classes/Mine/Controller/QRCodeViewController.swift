////
////  ModeSetrtingViewController.swift
////  ppLedc
////
////  Created by 柴荣臻 on 2019/7/18.
////  Copyright © 2019 rzchai. All rights reserved.
////
//
//import UIKit
//import AVFoundation
//
//
//class QRCodeViewController: PPAlertBaseViewController {
//    var captureSession: AVCaptureSession!
//    var previewLayer: AVCaptureVideoPreviewLayer!
//    private lazy var myViewMode : MyViewModel = MyViewModel()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        startAVCapture()
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        if (captureSession?.isRunning == false) {
//            captureSession.startRunning()
//        }
//    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        
//        if (captureSession?.isRunning == true) {
//            captureSession.stopRunning()
//        }
//    }
//}
//
//extension QRCodeViewController {
//    private func bindMid(mid : String) {
//        let openid: String = self.getOpenid()
//        if openid == "" { return }
//        myViewMode.bindMid(openid: openid, mid: mid) { (message) in
//            if message == "success" {
//                print("machine name: \(mid) has added")
//                self.autoHideAlertMessage(message: "添加成功")
//            } else {
//                self.autoHideAlertMessage(message: message)
//            }
//        }
//    }
//}
//
//extension QRCodeViewController {
//    func startAVCapture() {
//        captureSession = AVCaptureSession()
//        
//        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
//        let videoInput: AVCaptureDeviceInput
//        
//        do {
//            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
//        } catch {
//            return
//        }
//        
//        if (captureSession.canAddInput(videoInput)) {
//            captureSession.addInput(videoInput)
//        } else {
//            failed()
//            return
//        }
//        let metadataOutput = AVCaptureMetadataOutput()
//        
//        if (captureSession.canAddOutput(metadataOutput)) {
//            captureSession.addOutput(metadataOutput)
//            
//            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
//            metadataOutput.metadataObjectTypes = [.qr]
//        } else {
//            failed()
//            return
//        }
//        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
//        previewLayer.frame = view.layer.bounds
//        previewLayer.videoGravity = .resizeAspectFill
//        view.layer.addSublayer(previewLayer)
//        captureSession.startRunning()
//    }
//    
//    func failed() {
//        alertMessage(title: "权限错误", message: "您的设备未开启扫描支持")
//        captureSession = nil
//    }
//    
//    func found(code: String) {
//        let mid : String = code.replacingOccurrences(of: "{", with: "").replacingOccurrences(of: "}", with: "").split(separator: ",")[0].replacingOccurrences(of: "mid:", with: "")
//        if mid == "" {
//            return
//        }
//        //mid = "esp_\(mid)"
//        if self.checkEspId(input: mid) {
//            bindMid(mid: mid)
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue:"binded"), object: nil, userInfo: nil)
//        } else {
//            self.alertMessage(title: "二维码错误", message: "无法解析设备编号,请确认二维码是否正确")
//        }
//
//        let step2 = ResetViewController()
//        self.navigationController!.pushViewController(step2, animated: true)
//        
//    }
//    
//    override var prefersStatusBarHidden: Bool {
//        return true
//    }
//    
//    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//        return .portrait
//    }
//}
//
//extension QRCodeViewController : AVCaptureMetadataOutputObjectsDelegate {
//    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
//        captureSession.stopRunning()
//        
//        if let metadataObject = metadataObjects.first {
//            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
//            guard let stringValue = readableObject.stringValue else { return }
//            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
//            found(code: stringValue)
//        }
//        dismiss(animated: true)
//    }
//    
//}

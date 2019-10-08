//
//  LightSettingView.swift
//  ppLedc
//
//  Created by 柴荣臻 on 2019/7/20.
//  Copyright © 2019 rzchai. All rights reserved.
//

import UIKit

class LightSettingView: UIView {
    

    @IBOutlet weak var sliderOne: UISlider!
    @IBOutlet weak var txtOne: UITextField!
    
    @IBOutlet weak var sliderTwo: UISlider!
    @IBOutlet weak var txtTwo: UITextField!
    
    @IBOutlet weak var sliderThree: UISlider!
    @IBOutlet weak var txtThree: UITextField!
    
    @IBOutlet weak var sliderFour: UISlider!
    @IBOutlet weak var txtFour: UITextField!
    
    @IBOutlet weak var sliderFive: UISlider!
    @IBOutlet weak var txtFive: UITextField!
    
    @IBOutlet weak var sliderSix: UISlider!
    @IBOutlet weak var txtSix: UITextField!
    
    @IBOutlet weak var sliderSeven: UISlider!
    @IBOutlet weak var txtSeven: UITextField!
    
    @IBOutlet weak var sliderEight: UISlider!
    @IBOutlet weak var txtEight: UITextField!
    
    
    @IBOutlet weak var btnOpenAll: UIButton!
    @IBOutlet weak var btnCloseAll: UIButton!
    
    @IBOutlet weak var btnSave: UIButton!
    

    
    private lazy var fixViewModel : FixViewModel = FixViewModel()
}

extension LightSettingView {
    class func lightSettingView() -> LightSettingView {
        return UINib(nibName: "LightSettingView", bundle: .main).instantiate(withOwner: nil, options: nil).first as! LightSettingView
    }
    
    private func updateFix() {
        fixViewModel.updateFix(openid: fixViewModel.getOpenid(), l1: txtOne.text!, l2: txtTwo.text!, l3: txtThree.text!, l4: txtFour.text!, l5: txtFive.text!, l6: txtSix.text!, l7: txtSeven.text!, l8: txtEight.text!) { (message) in
            if message == "success" {
                
            } else {
                
            }
        }
    }
    
    @IBAction func sliderOneChanged(_ sender: Any) {
        let value : Int = Int(sliderOne.value)
        txtOne.text = String(value)
        //updateFix()
    }
    
    @IBAction func sliderTwoChanged(_ sender: Any) {
        let value : Int = Int(sliderTwo.value)
        txtTwo.text = String(value)
        //updateFix()
    }
    
    @IBAction func sliderThreeChanged(_ sender: Any) {
        let value : Int = Int(sliderThree.value)
        txtThree.text = String(value)
        //updateFix()
    }
    
    @IBAction func sliderFourChanged(_ sender: Any) {
        let value : Int = Int(sliderFour.value)
        txtFour.text = String(value)
        //updateFix()
    }
    @IBAction func sliderFiveChanged(_ sender: Any) {
        let value : Int = Int(sliderFive.value)
        txtFive.text = String(value)
        updateFix()
    }
    @IBAction func sliderSixChanged(_ sender: Any) {
        let value : Int = Int(sliderSix.value)
        txtSix.text = String(value)
        //updateFix()
    }
    @IBAction func sliderSevenChanged(_ sender: Any) {
        let value : Int = Int(sliderSeven.value)
        txtSeven.text = String(value)
        //updateFix()
    }
    @IBAction func sliderEightChanged(_ sender: Any) {
        let value : Int = Int(sliderEight.value)
        txtEight.text = String(value)
        //updateFix()
    }
    
    @IBAction func openAllClick(_ sender: Any) {
        sliderOne.setValue(100.0, animated:true)
        sliderTwo.setValue(100.0, animated:true)
        sliderThree.setValue(100.0, animated:true)
        sliderFour.setValue(100.0, animated:true)
        sliderFive.setValue(100.0, animated:true)
        sliderSix.setValue(100.0, animated:true)
        sliderSeven.setValue(100.0, animated:true)
        sliderEight.setValue(100.0, animated:true)
        
        txtOne.text = "100"
        txtTwo.text = "100"
        txtThree.text = "100"
        txtFour.text = "100"
        txtFive.text = "100"
        txtSix.text = "100"
        txtSeven.text = "100"
        txtEight.text = "100"
        //updateFix()
    }
    
    @IBAction func closeeAllClick(_ sender: Any) {
        sliderOne.setValue(0, animated:true)
        sliderTwo.setValue(0, animated:true)
        sliderThree.setValue(0, animated:true)
        sliderFour.setValue(0, animated:true)
        sliderFive.setValue(0, animated:true)
        sliderSix.setValue(0, animated:true)
        sliderSeven.setValue(0, animated:true)
        sliderEight.setValue(0, animated:true)
        
        txtOne.text = "0"
        txtTwo.text = "0"
        txtThree.text = "0"
        txtFour.text = "0"
        txtFive.text = "0"
        txtSix.text = "0"
        txtSeven.text = "0"
        txtEight.text = "0"
        //updateFix()
    }    
}

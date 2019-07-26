//
//  DetailSettingView.swift
//  ppLedc
//
//  Created by 柴荣臻 on 2019/7/26.
//  Copyright © 2019 rzchai. All rights reserved.
//

import UIKit

class DetailSettingView: UIView {

    @IBOutlet weak var sliderOne: UISlider!
    @IBOutlet weak var sliderTwo: UISlider!
    @IBOutlet weak var sliderThree: UISlider!
    @IBOutlet weak var sliderFour: UISlider!
    @IBOutlet weak var sliderFive: UISlider!
    @IBOutlet weak var sliderSix: UISlider!
    @IBOutlet weak var sliderSeven: UISlider!
    @IBOutlet weak var sliderEight: UISlider!
    @IBOutlet weak var txtOne: UITextField!
    @IBOutlet weak var txtTwo: UITextField!
    @IBOutlet weak var txtThree: UITextField!
    @IBOutlet weak var txtFour: UITextField!
    @IBOutlet weak var txtFive: UITextField!
    @IBOutlet weak var txtSix: UITextField!
    @IBOutlet weak var txtSeven: UITextField!
    @IBOutlet weak var txtEight: UITextField!    
}

extension DetailSettingView {
    class func detailSettingView() -> DetailSettingView {
        return UINib(nibName: "DetailSettingView", bundle: .main).instantiate(withOwner: nil, options: nil).first as! DetailSettingView
    }
}

extension DetailSettingView {
    @IBAction func sliderOneChanged(_ sender: Any) {
        txtOne.text = String(Int(sliderOne.value))
    }
    @IBAction func sliderTwoChanged(_ sender: Any) {
        txtTwo.text = String(Int(sliderTwo.value))
    }
    
    @IBAction func sliderThreeChanged(_ sender: Any) {
        txtThree.text = String(Int(sliderThree.value))
    }
    @IBAction func sliderFourChanged(_ sender: Any) {
        txtFour.text = String(Int(sliderFour.value))
    }
    @IBAction func sliderFiveChanged(_ sender: Any) {
        txtFive.text = String(Int(sliderFive.value))
    }
    @IBAction func sliderSixChanged(_ sender: Any) {
        txtSix.text = String(Int(sliderSix.value))
    }
    @IBAction func sliderSevenChanged(_ sender: Any) {
        txtSeven.text = String(Int(sliderSeven.value))
    }
    @IBAction func sliderEightChanged(_ sender: Any) {
        txtEight.text = String(Int(sliderEight.value))
    }
}

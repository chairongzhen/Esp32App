//
//  ButtonGroupView.swift
//  ppLedc
//
//  Created by 柴荣臻 on 2019/7/24.
//  Copyright © 2019 rzchai. All rights reserved.
//

import UIKit

class ButtonGroupView: UIView {

    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnMinus: UIButton!
    @IBOutlet weak var btnModify: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnPrevious: UIButton!
    @IBOutlet weak var btnEmpty: UIButton!
    

}

extension ButtonGroupView {
    @IBAction func btnAddClicked(_ sender: Any) {
        print("add")
    }
    @IBAction func btnMinusCllicked(_ sender: Any) {
    }
    
    @IBAction func btnModifyClicked(_ sender: Any) {
    }
    @IBAction func btnNextClicked(_ sender: Any) {
    }
    @IBAction func btnPreviousClicked(_ sender: Any) {
    }
    @IBAction func btnEmptyClicked(_ sender: Any) {
    }
    class func buttonGroupView() -> ButtonGroupView {
        return UINib(nibName: "ButtonGroup", bundle: .main).instantiate(withOwner: nil, options: nil).first as! ButtonGroupView
    }
    
}

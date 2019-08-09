//
//  ModeSetrtingViewController.swift
//  ppLedc
//
//  Created by 柴荣臻 on 2019/7/18.
//  Copyright © 2019 rzchai. All rights reserved.
//

import UIKit

private var repeatTypeOption = ["固定","循环"]
private var productiontOption = ["产品","测试"]
private var autoUpdateOption = ["否","是"]
var repeatMode = machineType.repeatType.fixMode
var productionMode = machineType.productionType.prductionMode
var autoUpdateMode = machineType.autoUpdate.none
private var openid : String = ""


class ModeSetrtingViewController: PPAlertBaseViewController {
    private lazy var settingVM : SettingViewModel = SettingViewModel()
    private lazy var modeTable : UITableView =  UITableView(frame: view.bounds, style: .grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad() 
        openid = self.getOpenid()
        getSettingData()
        setupUI()
    }

}

extension ModeSetrtingViewController {
    func setupUI() {
        modeTable.backgroundColor = UIColor.white
        modeTable.delegate = self
        modeTable.dataSource = self
        view.addSubview(modeTable)
    }
    
    func getSettingData() {
        settingVM.getSetting(openid: openid) { (message) in
            if message == "success" {
                let myset : Setting  = self.settingVM.setting
                if myset.repeatMode == "repeat" {
                    repeatMode = .repeatMode
                } else {
                    repeatMode = .fixMode
                }
                
                if myset.productionMode == "production" {
                    productionMode = .prductionMode
                } else {
                    productionMode = .testMode
                }
                
                if myset.autoUpdate == "auto" {
                    autoUpdateMode = .auto
                } else {
                    autoUpdateMode = .none
                }
                
                self.modeTable.reloadData()
            } else {
                return
            }
        }
    }
    
    func setSettingData() {
        var repeatModeStr: String = ""
        if repeatMode == .repeatMode {
            repeatModeStr = "repeat"
        } else {
            repeatModeStr = "fix"
        }
        
        var productionModeStr : String = ""
        if productionMode == .prductionMode {
            productionModeStr = "production"
        } else {
            productionModeStr = "test"
        }
        
        var autoUpdateModeStr : String = ""
        if autoUpdateMode == .auto {
            autoUpdateModeStr = "auto"
        } else {
            autoUpdateModeStr = "none"
        }
        
        settingVM.updateSetting(openid: openid, repeatMode: repeatModeStr, productionMode: productionModeStr, autoUpdateMode: autoUpdateModeStr) { (message) in
            if message == "success" {

            } else {
                self.autoHideAlertMessage(message: message)
            }
        }
    }
}


extension ModeSetrtingViewController : UITableViewDataSource,UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "selectCell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "selectCell")
            cell?.selectionStyle = .none
        }

        if indexPath.section == 0 {
            cell?.textLabel?.text = repeatTypeOption[indexPath.row]
            if repeatMode == .fixMode {
                if indexPath.row == 0 {
                    cell?.accessoryType = .checkmark
                } else {
                    cell?.accessoryType = .none
                }
            } else if repeatMode == .repeatMode {
                if indexPath.row == 1 {
                    cell?.accessoryType = .checkmark
                } else {
                    cell?.accessoryType = .none
                }
            }
        } else if indexPath.section == 1 {
            cell?.textLabel?.text = productiontOption[indexPath.row]
            if productionMode == .prductionMode {
                if indexPath.row == 0 {
                    cell?.accessoryType = .checkmark
                } else {
                    cell?.accessoryType = .none
                }
            } else if productionMode == .testMode {
                if indexPath.row == 1 {
                    cell?.accessoryType = .checkmark
                } else {
                    cell?.accessoryType = .none
                }
            }
            
        }  else if indexPath.section == 2 {
            cell?.textLabel?.text = autoUpdateOption[indexPath.row]
            if autoUpdateMode == .none {
                if indexPath.row == 0 {
                    cell?.accessoryType = .checkmark
                } else {
                    cell?.accessoryType = .none
                }
            } else if autoUpdateMode == .auto {
                if indexPath.row == 1 {
                    cell?.accessoryType = .checkmark
                } else {
                    cell?.accessoryType = .none
                }
            }
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 50))
        let headerLabel:UILabel = UILabel(frame: CGRect(x: 20, y: headerView.bounds.origin.y, width: headerView.bounds.width, height: headerView.bounds.height))
        headerLabel.textColor = UIColor.white
        headerLabel.backgroundColor = UIColor.clear
        headerLabel.font = UIFont.systemFont(ofSize: 16)
        if section == 0 {
            headerLabel.text = "循环模式"
        } else if section == 1 {
            headerLabel.text = "运行模式"
        } else {
            headerLabel.text = "自动更新固件"
        }
        headerView.addSubview(headerLabel)
        headerView.backgroundColor = UIColor.lightGray
        return headerView;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                repeatMode = .fixMode
            } else {
                repeatMode = .repeatMode
            }
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                productionMode = .prductionMode
            } else {
                productionMode = .testMode
            }
        } else if indexPath.section == 2 {
            if indexPath.row == 0 {
                autoUpdateMode = .none
            } else {
                autoUpdateMode = .auto
            }
        }
        
        tableView.reloadData()
        setSettingData()
    }
    
}

enum machineType {
    enum repeatType {
        case fixMode
        case repeatMode
    }
    enum productionType {
        case prductionMode
        case testMode
    }
    enum autoUpdate {
        case none
        case auto
    }
}

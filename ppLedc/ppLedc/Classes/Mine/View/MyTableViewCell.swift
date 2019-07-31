//
//  MyTableViewCell.swift
//  ppLedc
//
//  Created by 柴荣臻 on 2019/7/18.
//  Copyright © 2019 rzchai. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    var machineNameLabel: UILabel!
    var statusLabel: UILabel!
    var iconImv : UIImageView!
    
    var machine : Machine? {
        didSet {
            // 0. check the model whether has value or not
            guard let machine = machine else { return  }
            
            // 1. set manme
            machineNameLabel.text = machine.mname
            
            // 2. set pic
            iconImv.image = UIImage(named: "light")
            
            // 3. set status111
            if machine.online == "online" {
                statusLabel.text = " 内网地址:\(machine.ip)"
            } else {
                statusLabel.text = "离线"
            }
            
            
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        iconImv = UIImageView(frame: CGRect(x: 20, y: 15, width: 64, height: 44))
        iconImv.layer.masksToBounds = true
        iconImv.layer.cornerRadius = 22.0
        
        machineNameLabel = UILabel(frame: CGRect(x: 104, y: 18, width: 250, height: 15))
        machineNameLabel.textColor = UIColor.black
        machineNameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        machineNameLabel.textAlignment = .left
        
        statusLabel = UILabel(frame: CGRect(x: 104, y: 49, width: 200, height: 13))
        statusLabel.textColor = UIColor.gray
        statusLabel.font = UIFont.systemFont(ofSize: 13)
        statusLabel.textAlignment = .left
        contentView.addSubview(iconImv)
        contentView.addSubview(machineNameLabel)
        contentView.addSubview(statusLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

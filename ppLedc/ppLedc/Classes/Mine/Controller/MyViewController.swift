//
//  MyViewController.swift
//  ppLedc
//
//  Created by 柴荣臻 on 2019/7/18.
//  Copyright © 2019 rzchai. All rights reserved.
//

import UIKit


class MyViewController: PPAlertBaseViewController {
    private lazy var tableView = UITableView(frame: view.bounds, style: .grouped)
    private lazy var myViewMode : MyViewModel = MyViewModel()
    private lazy var refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadBinds()
        NotificationCenter.default.addObserver(self, selector: #selector(upDataChange(notif:)), name: NSNotification.Name(rawValue: "binded"), object: nil)
    }
}

extension MyViewController {
    private func setupUI() {
        tableView.backgroundColor = UIColor.white
        //tableView.setEditing(!tableView.isEditing, animated: true)
        

        refreshControl.addTarget(self, action: #selector(refreshDown),
                                 for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "下拉刷新数据")
        tableView.addSubview(refreshControl)
        
        tableView.addSubview(refreshControl)
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }
    
    func loadBinds() {
        let openid: String = self.getOpenid()
        if openid == "" { return }
        myViewMode.getBinds(openid: openid) { (message) in
            if message == "success" {
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            } else {
                self.autoHideAlertMessage(message: message)
            }
        }
    }
    
    private func unbind(mid: String) {
        let openid: String = self.getOpenid()
        if openid == "" { return }
        myViewMode.unBind(openid: openid, mid: mid) { (message) in
            if message == "success" {
                print("machine name: \(mid) has deleted")
            } else {
                self.autoHideAlertMessage(message: message)
            }
        }
    }
    
    @objc func refreshDown() {
        loadBinds()
    }
    
    @objc func upDataChange(notif: NSNotification){
        loadBinds()
    }

}

extension MyViewController : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myViewMode.machines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellid = "machineCellID"
        var cell:MyTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellid) as? MyTableViewCell
        if cell == nil {
            cell = MyTableViewCell(style: .subtitle, reuseIdentifier: cellid)
        }
        
        if myViewMode.machines.count != 0 {
            cell?.machine = myViewMode.machines[indexPath.row]
        }
        
        return cell!
    }
    
    // 设置cell高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 74.0
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "解绑";
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let selected = myViewMode.machines[indexPath.row]
        unbind(mid: selected.mid)
        myViewMode.machines.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath],with: .left)
        
    }
}

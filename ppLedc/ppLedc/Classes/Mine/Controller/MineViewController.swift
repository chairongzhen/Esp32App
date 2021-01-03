////
////  MineViewController.swift
////  ppLedc
////
////  Created by 柴荣臻 on 2019/7/14.
////  Copyright © 2019 rzchai. All rights reserved.
////
//
import UIKit

class MineViewController: PPBaseViewController {
    var imgLogo : UIImageView!
    var btnAdd : UIButton!
    var lbAdd: UILabel!
    
    private lazy var tableView = UITableView(frame: CGRect(x: 0, y: 90, width: kScreenW - 30, height: kScreenH - 30), style: .grouped)
    private lazy var myViewMode : MyViewModel = MyViewModel()
    private lazy var refreshControl = UIRefreshControl()
    var timer: Timer!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadBinds()
        NotificationCenter.default.addObserver(self, selector: #selector(upDataChange(notif:)), name: NSNotification.Name(rawValue: "binded"), object: nil)
        
        
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)

    }
}


extension MineViewController {
    
    
    private func setupUI() {
        btnAdd = UIButton(frame: CGRect(x: kScreenW - 110, y: 70, width: 100, height: 20))
        //btnAdd.setBackgroundImage(UIImage(named: "add_h"), for: .normal)
        btnAdd.setImage(UIImage(named: "add_h"), for: .normal)
        btnAdd.setTitle("添加设备", for: .normal)
        btnAdd.setTitleColor(UIColor(hexString: "#f68717"), for: .normal)
        btnAdd.addTarget(self, action: #selector(onBtnAddClick), for: UIControl.Event.touchUpInside)
        btnAdd.isUserInteractionEnabled = true
        btnAdd.isUserInteractionEnabled = true
        self.view.addSubview(btnAdd)
        
//        let vList = UIView(frame: CGRect(x: 0, y: 90, width: kScreenW - 30, height: kScreenH - 30))
//        self.view.addSubview(vList)
        self.view.addSubview(tableView)
        tableView.backgroundColor = UIColor.white
        refreshControl.addTarget(self, action: #selector(refreshDown),
                                 for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "下拉刷新数据")
        tableView.addSubview(refreshControl)
        
        tableView.addSubview(refreshControl)
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
    @objc func onBtnAddClick() {
        let step1 = AddViewController()
        self.navigationController!.pushViewController(step1, animated: true)
    }
    
    @objc private func timerAction() {
        print("here again")
        loadBinds()
    }
}


extension MineViewController : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myViewMode.machines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellid = "machineCellID"
        var cell:MyTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellid) as? MyTableViewCell
        if cell == nil {
            cell = MyTableViewCell(style: .subtitle, reuseIdentifier: cellid)
            cell?.backgroundColor = .white
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
//class MineViewController: PPBaseViewController {
//    private lazy var pageTitleView : PageTitleView = { [weak self] in
//        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
//        let titles  = ["添加设备","我的设备"]
//        let titleView = PageTitleView(frame: titleFrame, titles: titles)
//        titleView.delegate = self
//        return titleView
//        }()
//
//      lazy var pageContentView : PageContentView = {[weak self] in
//        // Setting the content frame
//        let contentH = kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH - kTabBarH
//        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: contentH)
//
//
//        // Setting the child controller
//        var childVcs = [UIViewController]()
//        childVcs.append(AddViewController())
//        childVcs.append(MyViewController())
//        //childVcs.append(QRCodeViewController())
//        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
//        contentView.delegate = self
//        return contentView
//        }()
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupUI();
//    }
//
//}
//
//
//// setting UI
//extension MineViewController {
//    private func setupUI() {
//        // cancel the scrollview inner margin
//        if #available(iOS 11.0, *) {
//
//        } else {
//            automaticallyAdjustsScrollViewInsets = false
//        }
//
//        // setting title view
//        view.addSubview(pageTitleView)
//
//        // settting content view
//        view.addSubview(pageContentView)
//    }
//
//    func changeTitleIndex(sourceIndex : Int, targetIndex : Int) {
//        pageTitleView.setCurrentIndex(sourceIndex : sourceIndex, targetIndex : targetIndex)
//    }
//
//
//    @objc func upDataChange(notif: NSNotification){
//        self.pageTitleView.setCurrentIndex(sourceIndex: 0, targetIndex: 1)
//        self.pageContentView.setCurrentIndex(currentIndex: 1)
//    }
//}
//
//
//
//// take the pageTitleView 's protocol
//extension MineViewController : PageTitleViewDelegate {
//    func pageTitleView(titleView: PageTitleView, selectIndex index: Int) {
//        pageContentView.setCurrentIndex(currentIndex: index)
//    }
//}
//
//
//// take the pageContentView 's protocol
//extension MineViewController : PageContentViewDelegate {
//    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
//        pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
//    }
//}

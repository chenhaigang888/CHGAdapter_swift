//
//  TBEventTransmissionViewController.swift
//  CHGAdapter_swift
//
//  Created by DNAER5 on 2019/12/19.
//  Copyright © 2019 chen haiGang. All rights reserved.
//

import UIKit


/// 使用TableView来布局登陆页面 来演示cell，header，footer中的按钮、输入框等事件传递到controller中的功能
class TBEventTransmissionViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.headerDatas = [LoginHeader.init(name: "登陆")]
        
    }
    
    func getCellData() -> [Any] {
        var data = [Any]()
        
        
        data.append(LoginHeader.init(name: "登陆"))
        return data
        
    }

}

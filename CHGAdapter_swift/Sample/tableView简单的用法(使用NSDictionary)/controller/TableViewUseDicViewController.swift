//
//  TableViewUseDicViewController.swift
//  CHGAdapter_swift
//
//  Created by 陈 海刚 on 2018/8/18.
//  Copyright © 2018 chen haiGang. All rights reserved.
//

import UIKit

class TableViewUseDicViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    lazy var adapter:FriendAdapter = {
        let adapter = FriendAdapter.init()
        return adapter
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adapter.adapterData.cellDatas = cellDatas
        adapter.adapterData.headerDatas = headerData
        tableView.tableViewAdapter = adapter
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    lazy var cellDatas:NSArray = {
        let cellDatas =
            [
                [
                    ["id":"1","name":"张三1","sigin":"签名1","icon":"img_qs_50x50"],
                    ["id":"2","name":"李四1","sigin":"签名1","icon":"img_qs_50x50"],
                    ["id":"3","name":"王五1","sigin":"签名1","icon":"img_qs_50x50"],
                    ],
                [
                    ["id":"4","name":"张三2","sigin":"签名1","icon":"img_qs_50x50"],
                    ["id":"5","name":"李四2","sigin":"签名1","icon":"img_qs_50x50"],
                    ["id":"6","name":"王五2","sigin":"签名1","icon":"img_qs_50x50"],
                ]
        ]
        return cellDatas as NSArray
    }()
    
    lazy var headerData:NSArray = {
        let headerData =
            [
                ["groupId":"1","groupName":"我的好友","count":"3"],
                ["groupId":"2","groupName":"陌生人","count":"3"]
        ]
        return headerData as NSArray
    }()

}

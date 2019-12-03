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
        adapter.keyPathOfSubData = "test"
//        adapter.rowsOfSectionKeyName = \Group.test
        adapter.adapterData.cellDatas = cellDatas
        adapter.adapterData.headerDatas = cellDatas
        tableView.tableViewAdapter = adapter
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    lazy var cellDatas:[Any] = {
//        let test1 = [Test.init(id: "1", name: "张三1", sigin: "签名", icon: "img_qs_50x50"),
//                     Test.init(id: "1", name: "李四1", sigin: "签名", icon: "img_qs_50x50"),
//                     Test.init(id: "1", name: "王五1", sigin: "签名", icon: "img_qs_50x50")]
//
//        let test2 = [Test.init(id: "1", name: "张三2", sigin: "签名", icon: "img_qs_50x50"),
//                     Test.init(id: "1", name: "李四2", sigin: "签名", icon: "img_qs_50x50"),
//                     Test.init(id: "1", name: "王五2", sigin: "签名", icon: "img_qs_50x50")]
//        let cellDatas =
//            [
//                Group.init(groupId: "1", groupName: "我的好友", count: "3", test: test1 as NSArray),
//                Group.init(groupId: "1", groupName: "我的好友", count: "3", test: test2 as NSArray)
//            ]
        
        
        let cellDatas =
            [

                [   "groupId":"1",
                    "groupName":"我的好友",
                    "count":"3",
                    "test":[
                            ["id":"1","name":"张三1","sigin":"签名1","icon":"img_qs_50x50"],
                            ["id":"2","name":"李四1","sigin":"签名1","icon":"img_qs_50x50"],
                            ["id":"3","name":"王五1","sigin":"签名1","icon":"img_qs_50x50"],
                    ]
                ],
                [  "groupId":"1",
                    "groupName":"我的好友",
                    "count":"3",
                    "test":[
                    ["id":"4","name":"张三2","sigin":"签名1","icon":"img_qs_50x50"],
                    ["id":"5","name":"李四2","sigin":"签名1","icon":"img_qs_50x50"],
                    ["id":"6","name":"王五2","sigin":"签名1","icon":"img_qs_50x50"],
                ]]
        ]
        return (cellDatas as NSArray) as! [Any]
    }()
}

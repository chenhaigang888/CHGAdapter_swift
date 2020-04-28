//
//  CollectionViewUseDicViewController.swift
//  CHGAdapter_swift
//
//  Created by 陈 海刚 on 2018/8/18.
//  Copyright © 2018 chen haiGang. All rights reserved.
//

import UIKit

class CollectionViewUseDicViewController: UIViewController {
    
    @IBOutlet weak var collectionView:UICollectionView?
    
    lazy var adapter:CHGCollectionViewAdapter = {
        let adapter = CHGCollectionViewAdapter.init()//如果只有一种cell header footer 就不需要继承 CHGCollectionViewAdapter
        adapter.cellName = CVFriendUseDicCollectionViewCell.self
        adapter.headerName = CVCollectionViewUseDicHeaderFooterView.self
        return adapter
    }()
    
    lazy var cellDatas:NSArray = {
//                let test1 = [Test.init(id: "1", name: "张三1", sigin: "签名", icon: "img_qs_50x50"),
//                             Test.init(id: "1", name: "李四1", sigin: "签名", icon: "img_qs_50x50"),
//                             Test.init(id: "1", name: "王五1", sigin: "签名", icon: "img_qs_50x50")]
//
//                let test2 = [Test.init(id: "1", name: "张三2", sigin: "签名", icon: "img_qs_50x50"),
//                             Test.init(id: "1", name: "李四2", sigin: "签名", icon: "img_qs_50x50"),
//                             Test.init(id: "1", name: "王五2", sigin: "签名", icon: "img_qs_50x50")]
//                let cellDatas =
//                    [
//                        Group.init(groupId: "1", groupName: "我的好友", count: "3", test: test1 as NSArray),
//                        Group.init(groupId: "1", groupName: "我的好友", count: "3", test: test2 as NSArray)
//                    ]
        
        
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
        return cellDatas as NSArray
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize.init(width: 150, height: 150)
        layout.headerReferenceSize = CGSize.init(width: UIScreen.main.bounds.width, height: 30)
        
//        adapter.rowsOfSectionKeyName = \Group.test
        adapter.keyPathOfSubData = "test"
        adapter.adapterData.cellDatas = cellDatas as? [Any]
        adapter.adapterData.headerDatas = cellDatas as? [Any]
        collectionView?.collectionViewAdapter = adapter
        collectionView?.collectionViewLayout = layout
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
   
}

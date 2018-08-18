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
        adapter.cellName = "CVFriendUseDicCollectionViewCell"
        adapter.headerName = "CVCollectionViewUseDicHeaderFooterView"
        return adapter
    }()
    
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
                ["groupId":"2","groupName":"陌生人","count":"3"],
                ["groupId":"3","groupName":"黑名单","count":"3"]
            ]
        return headerData as NSArray
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize.init(width: 150, height: 150)
        layout.headerReferenceSize = CGSize.init(width: UIScreen.main.bounds.width, height: 30)
        
        
        adapter.adapterData.cellDatas = cellDatas
        adapter.adapterData.headerDatas = headerData
        collectionView?.collectionViewAdapter = adapter
        collectionView?.collectionViewLayout = layout
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
   
}

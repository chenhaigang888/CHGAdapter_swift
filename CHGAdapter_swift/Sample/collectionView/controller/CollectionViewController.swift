//
//  CollectionViewController.swift
//  CHGAdapter_swift
//
//  Created by 陈 海刚 on 2018/5/16.
//  Copyright © 2018年 chen haiGang. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController {
    
    @IBOutlet var collectionView:UICollectionView?
    
    lazy var adapter:CHGCollectionViewAdapter = {
        () -> CHGCollectionViewAdapter in
        let tempAdapter = CHGCollectionViewAdapter()
        tempAdapter.cellName = "Sample1CollectionViewCell"
        tempAdapter.headerName = "Sample1CollectionReusableView"
        tempAdapter.footerName = "Sample1CollectionReusableView"
        tempAdapter.rowsOfSectionKeyName = "test"
        return tempAdapter
    }()
    
    lazy var adapterData:CHGCollectionViewAdapterData = {
        () ->CHGCollectionViewAdapterData in
        let tempAdapterData = CHGCollectionViewAdapterData()
        tempAdapterData.cellDatas =
            [
                ["test":["1","2","3","4","5","6","7","8"]],
                ["test":["1","2","3","4","5","6","7","8"]],
                ["test":["1","2","3","4","5","6","7","8"]],
                ["test":["1","2","3","4","5","6","7","8"]]
        ]
        tempAdapterData.headerDatas = ["header1","header2"]
        tempAdapterData.footerDatas = ["footer1","footer2"]
        tempAdapterData.customData = NSMutableDictionary()
        return tempAdapterData
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.headerReferenceSize = CGSize(width: self.view.frame.width, height: 30)
        layout.footerReferenceSize = CGSize(width: self.view.frame.width, height: 30)
        self.collectionView?.collectionViewLayout = layout
        self.adapter.adapterData = self.adapterData
        self.collectionView?.collectionViewAdapter = self.adapter
        self.collectionView?.setEventTransmissionBlock(eventTransmissionBlock: { (target:AnyObject, params, tag:NSInteger, callBack:CHGCallBack?) -> AnyObject? in
            callBack!("jjj" as AnyObject)
            return nil
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

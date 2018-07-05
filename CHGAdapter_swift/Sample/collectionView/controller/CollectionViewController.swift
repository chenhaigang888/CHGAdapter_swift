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
    
    
    /// adapter配置
    lazy var adapter:CHGCollectionViewAdapter = {
        () -> CHGCollectionViewAdapter in
        let tempAdapter = CHGCollectionViewAdapter()
        tempAdapter.cellName = "Sample1CollectionViewCell"      //设置cell 类
        tempAdapter.headerName = "Sample1CollectionReusableView"//设置顶部显示的ReusableView 类
        tempAdapter.footerName = "Sample1CollectionReusableView" //设置底部显示的ReusableView 类
        tempAdapter.rowsOfSectionKeyName = "test"//设置使用model或者字典中的字段作为cell的数据
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
        tempAdapterData.headerDatas = ["header1","header2","header3"]
        tempAdapterData.footerDatas = ["footer1","footer2","footer3"]
        tempAdapterData.customData = NSMutableDictionary()
        return tempAdapterData
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        //设置layout
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.headerReferenceSize = CGSize(width: self.view.frame.width, height: 30)
        layout.footerReferenceSize = CGSize(width: self.view.frame.width, height: 30)
        self.collectionView?.collectionViewLayout = layout
        
        //设置adapter
        self.adapter.adapterData = self.adapterData
        self.collectionView?.collectionViewAdapter = self.adapter
        
        //没有数据的展示
        self.collectionView?.setEmptyDataShow("暂时没有数据", imageName: "icon_dl_xsmm")
        self.collectionView?.collectionViewEmptyDataShow?.emptyDataSetShouldAllowScroll = true
        self.collectionView?.collectionViewEmptyDataShow?.emptyDataDidTapViewBlock = {(scrollView,view) in
            print("ddd点击空白处")
        }
        
        //cell、headerFooterView 中按钮、输入、滑动删除等事件传输block
        self.collectionView?.setEventTransmissionBlock(eventTransmissionBlock: {(target:AnyObject, params, tag:NSInteger, callBack:CHGCallBack?) -> AnyObject? in
            callBack!("jjj" as AnyObject)
            return nil
        })
        
        //item 被点击
        self.collectionView?.setCollectionViewDidSelectItemAtIndexPathBlock(collectionViewDidSelectItemAtIndexPathBlock: {[weak self] (collectionView, indexPath, data) in
            let tbVC = TableViewController.init(nibName: "TableViewController", bundle: nil)
            self?.navigationController?.pushViewController(tbVC, animated: true)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

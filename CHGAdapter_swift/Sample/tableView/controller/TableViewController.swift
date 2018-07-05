//
//  TableViewController.swift
//  CHGAdapter_swift
//
//  Created by chen haiGang on 2018/5/16.
//  Copyright © 2018年 chen haiGang. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {
    
    @IBOutlet var tableView:UITableView?
    
    lazy var adapter:SampleAdapter = {
        () -> SampleAdapter in
        let tempAdapter = SampleAdapter()
        tempAdapter.cellName = "Sample1TableViewCell"
        tempAdapter.headerName = "Sample1HeaderFooterView"
        tempAdapter.footerName = "Sample1HeaderFooterView"
        tempAdapter.rowsOfSectionKeyName = "test"
        return tempAdapter
    }()
    
    lazy var adapterData:CHGTableViewAdapterData = {
        () ->CHGTableViewAdapterData in
        let tempAdapterData = CHGTableViewAdapterData()
        tempAdapterData.cellDatas =
            [
                ["test":["1","2","3","4","5","6"]],
                ["test":["1","2","3","4","5","6"]],
                ["test":["1","2","3","4","5","6"]],
                ["test":["1","2","3","4","5","6"]]
            ]
        tempAdapterData.headerDatas = ["header1","header2"]
        tempAdapterData.footerDatas = ["footer1","footer2"]
        tempAdapterData.customData = NSMutableDictionary()
        return tempAdapterData
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        //设置adapter
        self.adapter.adapterData = self.adapterData
        self.tableView?.tableViewAdapter = self.adapter
        //优化显示
        self.tableView?.hiddHeadView()
        self.tableView?.hiddenFooterView()
        
        //设置没有数据时的显示
        self.tableView?.setEmptyDataShow("暂时没有数据", imageName: "icon_dl_xsmm")
        self.tableView?.tableViewEmptyDataShow?.emptyDataSetShouldAllowScroll = true
        self.tableView?.tableViewEmptyDataShow?.emptyDataDidTapViewBlock = {(scrollView,view) in
            print("点击空白处")
        }
        
        //cell、headerFooterView 中按钮、输入、滑动删除等事件传输block
        self.tableView?.setEventTransmissionBlock(eventTransmissionBlock: { (target:AnyObject, params:AnyObject, tag:NSInteger,callBack:CHGCallBack?) -> AnyObject? in
            callBack!(params)
            return nil
        })
        
        //cell 被点击
        self.tableView?.setTableViewDidSelectRowBlock(tableViewDidSelectRowBlock: { (tableView:UITableView, indexPath:IndexPath, itemData:AnyObject) in
            print("点击section:\(indexPath.section)  row:\(indexPath.row)\(itemData)")
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

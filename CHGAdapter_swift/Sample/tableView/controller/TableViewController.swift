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
        self.adapter.adapterData = self.adapterData
        self.tableView?.tableViewAdapter = self.adapter
        
        self.tableView?.setEventTransmissionBlock(eventTransmissionBlock: { (target:AnyObject, params:AnyObject, tag:NSInteger,callBack:CHGCallBack?) -> AnyObject? in
            callBack!(params)
            return nil
        })
        
        self.tableView?.setTableViewDidSelectRowBlock(tableViewDidSelectRowBlock: { (tableView:UITableView, indexPath:IndexPath, itemData:AnyObject) in
            print("点击section:\(indexPath.section)  row:\(indexPath.row)\(itemData)")
        })
    }
    
    func awake(_ eventTransmissionBlock:CHGEventTransmissionBlock) -> Void {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

//
//  SampleAdapterDemoViewController.swift
//  CHGAdapter_swift
//
//  Created by chen haiGang on 2018/7/26.
//  Copyright © 2018年 chen haiGang. All rights reserved.
//

import UIKit

class SampleAdapterDemoViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var address:[CHGAddress] =
        [
            CHGAddress.init(type: 0, address: nil, fullAddress: nil),
            CHGAddress.init(type: 1, address: "陆家嘴", fullAddress: "上海市浦东新区陆家嘴环路")
        ]
    
    var headerData =
        [
            SectionHeaderTitleModel.init(title: "地址一", headerClass: "SectionHeaderTitleHeaderFooterView"),
            SectionHeaderTitleModel.init(title: "地址二",headerClass: "SectionHeaderTitleHeaderFooterView")
        ]
    
    var footerData =
        [
            SectionFooterDescriptionModel.init(descriptionContent: "地址一描述"),
            SectionFooterDescriptionModel.init(descriptionContent: "地址二描述")
        ]

    lazy var adapterData:CHGTableViewAdapterData = {
        let adapterData = CHGTableViewAdapterData.init()
        adapterData.cellDatas = address as NSArray
        adapterData.headerDatas = headerData as NSArray
        adapterData.footerDatas = footerData as NSArray
        return adapterData
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "SampleAdapterDemo"
        tableView.adapterData = adapterData
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

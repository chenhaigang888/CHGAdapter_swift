//
//  TBVarietyDataViewController.swift
//  CHGAdapter_swift
//
//  Created by DNAER5 on 2019/12/19.
//  Copyright © 2019 chen haiGang. All rights reserved.
//

import UIKit

class TBVarietyDataViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.cellDatas = [getData()]
        
    }

    
    func getData() -> [Any] {
        var data = [Any]()
        data.append(Phone.init(brand: "三星手机"))
        data.append(Phone.init(brand: "华为手机"))
        data.append(Computer.init(brand: "联想电脑"))
        data.append(Phone.init(brand: "联想手机"))
        data.append(Computer.init(brand: "苹果电脑"))
        data.append(Phone.init(brand: "iphone"))
        
        return data
    }

}

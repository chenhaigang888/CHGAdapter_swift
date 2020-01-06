//
//  COFunctionViewController.swift
//  CHGAdapter_swift
//
//  Created by DNAER5 on 2019/12/19.
//  Copyright © 2019 chen haiGang. All rights reserved.
//

import UIKit

class COFunctionViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.cellDatas = [getFuncList()]
        
        //响应事件
        tableView.setTableViewDidSelectRowBlock { [weak self](tableView, indexPath, data) in
            let model:FuncModel = data as! FuncModel
            self?.navigationController?.pushViewController(model.viewController, animated: true)
        }
        
    }

    func getFuncList() -> [Any] {
        var funcs = [Any]()
        for item in [["title" : "一个section的列表","vc":SampleCOVViewController.init()],
                     ["title" : "多个section的列表","vc":TwoSectionCOViewController.init()],
                     ["title" : "多个section的列表带HeaderFooter 数据结构1","vc":COHeaderFooterViewController.init()],
                     ["title" : "多个section的列表带HeaderFooter 数据结构2","vc":COHeaderFooter2ViewController.init()],
                     ["title" : "cell中含有多种Model 演示1","vc":COVarietyDataViewController.init()],
                     ["title" : "cell中含有多种Model 演示2","vc":COVarietyData2ViewController.init()],
                     ["title" : "枚举类型的数据类型","vc":EnumCOViewController.init()]
                     ] {
                        funcs.append(FuncModel.init(title: item["title"] as! String, _viewController:item["vc"] as! UIViewController ))
        }
        return funcs
    }

}

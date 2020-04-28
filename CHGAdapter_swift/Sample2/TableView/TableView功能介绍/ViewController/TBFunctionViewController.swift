//
//  TBFunctionViewController.swift
//  CHGAdapter_swift
//
//  Created by DNAER5 on 2019/12/19.
//  Copyright © 2019 chen haiGang. All rights reserved.
//

import UIKit


/// TableView功能列表
class TBFunctionViewController: UIViewController {

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
        for item in [["title" : "一个section的列表","vc":SampleTBVViewController.init()],
//                     ["title" : "多个section的列表","vc":TwoSectionTBViewController.init()],
//                     ["title" : "多个section的列表带HeaderFooter 数据结构1","vc":TBHeaderFooterViewController.init()],
//                     ["title" : "多个section的列表带HeaderFooter 数据结构2","vc":TBHeaderFooter2ViewController.init()],
                     ["title" : "cell中含有多种Model 演示1","vc":TBVarietyDataViewController.init()],
                     ["title" : "cell中含有多种Model 演示2","vc":TBVarietyData2ViewController.init()],
                     ["title" : "cell、header、footer上的事件传递到controller中","vc":TableViewViewController.init()],
                     ["title" : "枚举类型的数据类型","vc":EnumViewController.init()]
                     ] {
                        funcs.append(FuncModel.init(title: item["title"] as! String, _viewController:item["vc"] as! UIViewController ))
        }
        return funcs
    }

}

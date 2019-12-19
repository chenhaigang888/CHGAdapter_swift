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
        
        tableView.setTableViewDidSelectRowBlock { [weak self](tableView, indexPath, data) in
            if indexPath.row == 0 {
                let vc = SampleTBVViewController.init()
                vc.title = (data as? FuncModel)?.title
                self?.navigationController?.pushViewController(vc, animated: true)
            } else if indexPath.row == 1 {
                let vc = TwoSectionTBViewController.init()
                vc.title = (data as? FuncModel)?.title
                self?.navigationController?.pushViewController(vc, animated: true)
            } else if indexPath.row == 2 {
                let vc = TBHeaderFooterViewController.init()
                vc.title = (data as? FuncModel)?.title
                self?.navigationController?.pushViewController(vc, animated: true)
            } else if indexPath.row == 3 {
               let vc = TBHeaderFooter2ViewController.init()
               vc.title = (data as? FuncModel)?.title
               self?.navigationController?.pushViewController(vc, animated: true)
           }
            
        }
        
    }

    func getFuncList() -> [Any] {
        var funcs = [Any]()
        
        for item in ["一个section的列表",
                     "多个section的列表",
                     "多个section的列表带HeaderFooter 方式1",
                     "多个section的列表带HeaderFooter 方式2"] {
            funcs.append(FuncModel.init(title: item))
        }
        return funcs
    }

}

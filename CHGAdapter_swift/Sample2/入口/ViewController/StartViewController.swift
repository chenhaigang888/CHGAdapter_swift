//
//  StartViewController.swift
//  CHGAdapter_swift
//
//  Created by DNAER5 on 2019/12/17.
//  Copyright © 2019 chen haiGang. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.cellDatas = [getFuncList()]
        configTableView()
        
    }
    
    
    /// 配置tableView
    func configTableView() -> Void {
        tableView.setTableViewDidSelectRowBlock { [weak self](tableView, indexPath, data) in
            if indexPath.row == 0 {
                self?.navigationController?.pushViewController(TBFunctionViewController(), animated: true)
            }
        }
    }

    
    /// 获取功能列表
    func getFuncList() -> [Any] {
        return [FuncModel.init(title: "UITableView"),
                FuncModel.init(title: "UICollectionView")]
    }


}

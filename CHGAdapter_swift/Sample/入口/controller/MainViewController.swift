//
//  MainViewController.swift
//  CHGAdapter_swift
//
//  Created by 陈 海刚 on 2018/8/18.
//  Copyright © 2018 chen haiGang. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "CHGAdapter Demo"
        self.tableView.cellDatas = cellDatas
        tableView.tableViewDidSelectRowBlock = tableViewDidSelectRowBlock
        
        let titleModel = CVTitleModel.init(name: "晨")
        let t = TestK.init()
        t.key = \CVTitleModel.aaa
        t.aa(data: titleModel)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// cell点击回调block
    lazy var tableViewDidSelectRowBlock:CHGTableViewDidSelectRowBlock = {
        {[weak self](tableView:UITableView, indexPath:IndexPath, itemData) in
            let titleModel:TitleModel = itemData as! TitleModel
            if indexPath.row == 0 {
                let vc = CollectionViewViewController()
                vc.title = titleModel.name
                self?.navigationController?.pushViewController(vc, animated: true)
            } else if indexPath.row == 1 {
                let vc = TableViewViewController()
                vc.title = titleModel.name
                self?.navigationController?.pushViewController(vc, animated: true)
            } else if indexPath.row == 2 {
                let vc = CollectionViewUseDicViewController()
                vc.title = titleModel.name
                self?.navigationController?.pushViewController(vc, animated: true)
            } else if indexPath.row == 3 {
                let vc = TableViewUseDicViewController()
                vc.title = titleModel.name
                self?.navigationController?.pushViewController(vc, animated: true)
            } else if indexPath.row == 4 {
                let vc = KeyPathViewController()
                vc.title = titleModel.name
                self?.navigationController?.pushViewController(vc, animated: true)
            } else if indexPath.row == 5 {
                let vc = KeyPathCVViewController()
                vc.title = titleModel.name
                self?.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }()
    
    /// cell的数据
    lazy var cellDatas:NSArray = {
        let cellDatas =
            [
                [
                    TitleModel.init(name: "collectionView简单的用法(使用Model)"),
                    TitleModel.init(name: "tableView简单的用法(使用Model)"),
                    TitleModel.init(name: "collectionView简单的用法(使用NSDictionary)"),
                    TitleModel.init(name: "tableView简单的用法(使用NSDictionary)"),
                    TitleModel.init(name: "keyPath的用法（tableView）"),
                    TitleModel.init(name: "keyPath的用法（collectionView）")
                ]
            ]
        return cellDatas as NSArray
    }()
}

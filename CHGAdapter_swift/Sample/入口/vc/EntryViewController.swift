//
//  EntryViewController.swift
//  CHGAdapter_swift
//
//  Created by dnaer5 on 2020/7/6.
//  Copyright © 2020 chen haiGang. All rights reserved.
//

import UIKit


/// demo入口
class EntryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Demo入口"
        tableView.cellDatas = [createData()]
        tableView.setTableViewDidSelectRowBlock { [weak self](tableView, indexPath, itemData) in
            guard let model:Entry = itemData as? Entry,let clsType = model.vc else { return }
            let vcTemp = clsType.init()
            self?.navigationController?.pushViewController(vcTemp, animated: true)
        }
    }


    func createData() -> [Any] {
        var data = [Any]()
        for item in [["基础1（显示cell）",Base1ViewController.self],
                     ["基础2（显示header和footer）",Base2ViewController.self],
                     ["基础3（cell点击处理）",Base3ViewController.self],
                     ["基础4（cell、headerFooterView中的事件传递到ViewController中）",Base4ViewController.self],
                     ["基础5（多种Model在cell中）",Base5ViewController.self],
                     ["基础6-1（cell和headerFooter为同一个Model）",Base6ViewController.self],
                     ["基础6-2（多种cell和headerFooter为同一个Model）",Base6_2ViewController.self]] {
                        data.append(Entry.init(title: item[0] as? String,vc: item[1] as? UIViewController.Type))
        }

        return data
    }
  

}

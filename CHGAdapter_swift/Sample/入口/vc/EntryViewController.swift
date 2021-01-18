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
        title = "CHGAdapter_swift Demo入口"
        tableView.headerDatas = [EntryType.init(title: "UITableView"), EntryType.init(title: "UICollectionView")]
        tableView.cellDatas = createData()
        tableView.setTableViewDidSelectRowBlock { [weak self](tableView, indexPath, itemData) in
            guard let model:Entry = itemData as? Entry,let clsType = model.vc else { return }
            let vcTemp = clsType.init()
            vcTemp.title = model.title
            self?.navigationController?.pushViewController(vcTemp, animated: true)
        }
    }


    func createData() -> [Any] {
        var data = [Any]()
        for item in [["基础0（显示cell）",Base0ViewController.self],
                     ["基础1（显示cell）",Base1ViewController.self],
                     ["基础2（显示header和footer）",Base2ViewController.self],
                     ["基础3（cell点击处理）",Base3ViewController.self],
                     ["基础4（cell、headerFooterView中的事件传递到ViewController中）",Base4ViewController.self],
                     ["基础5（多种Model在cell中）",Base5ViewController.self],
                     ["基础6-1（cell和headerFooter为同一个Model）",Base6ViewController.self],
                     ["基础6-2（多种cell和headerFooter为同一个Model）",Base6_2ViewController.self],
                     ["基础6-3",SevenViewController.self],
                     ["基础6-4（使用字典作为数据模型）",DictionaryViewController.self]] {
                        data.append(Entry.init(title: item[0] as? String,vc: item[1] as? UIViewController.Type))
        }
        
        var data2 = [Any]()
        
        for item in [["基础0（）",Base_cv0_ViewController.self],
                     ["基础1（显示cell）",BaseCV_1_ViewController.self],
                     ["基础2（显示header和footer）",BaseCV_2_ViewController.self],
                     ["基础3（cell点击处理）",BaseCV_3_ViewController.self],
                     ["基础4（cell、headerFooterView中的事件传递到ViewController中）",BaseCV_4_ViewController.self],
                     ["基础5（多种Model在cell中）",BaseCV_5_ViewController.self],
                     ["基础6-1（cell和headerFooter为同一个Model）",BaseCV_6_1_ViewController.self],
                     ["基础6-2（多种cell和headerFooter为同一个Model）",Base_6_2_ViewController.self]] {
                        data2.append(Entry.init(title: item[0] as? String,vc: item[1] as? UIViewController.Type))
        }
        return [data,data2]
    }
  

}

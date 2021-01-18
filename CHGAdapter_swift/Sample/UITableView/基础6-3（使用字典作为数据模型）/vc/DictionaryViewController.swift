//
//  DictionaryViewController.swift
//  CHGAdapter_swift
//
//  Created by dnaer5 on 2021/1/18.
//  Copyright © 2021 chen haiGang. All rights reserved.
//

import UIKit

class DictionaryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.cellDatas = [createData()]
    }

    func createData() -> [Any] {
        var list = [Any]()
        for i in 0...100 {
            var dict = Dictionary<String, Any>()
            dict[TB_cell_class_key] = DictionaryTableViewCell.self
            dict[TB_cell_height_key] = 44
            dict["text"] = "文本:\(i)"
            list.append(dict)
        }
        return list
    }
    
}

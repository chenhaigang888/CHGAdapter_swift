//
//  Base5ViewController.swift
//  CHGAdapter_swift
//
//  Created by dnaer5 on 2020/7/6.
//  Copyright © 2020 chen haiGang. All rights reserved.
//

import UIKit

class Base5ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "基础5（多种Model在cell中）"
        tableView.cellDatas = [createData()]
    }


    func createData() -> [Any] {
        var data = [Any]()
        for i in 0...100 {
            if i % 2 == 0 {
                data.append(Products.init(name: "产品：\(i)", price: "价格：\(i)", image: "pc", desc: "描述\(i)"))
            } else {
                data.append(SongsModel.init(name: "音乐\(i)", cover: ""))
            }
        }
        return data
        
    }

}

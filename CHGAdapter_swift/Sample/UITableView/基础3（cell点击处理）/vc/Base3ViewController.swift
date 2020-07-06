//
//  Base3ViewController.swift
//  CHGAdapter_swift
//
//  Created by dnaer5 on 2020/7/6.
//  Copyright © 2020 chen haiGang. All rights reserved.
//

import UIKit

class Base3ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "基础3（cell点击处理）"
        tableView.cellDatas = [getSongs()]
        
        tableView.setTableViewDidSelectRowBlock { (tableView, indexPath, itemData) in
            guard let model:SongsModel = itemData as? SongsModel else { return }
            print("当前点击：\(model.name!)")
        }
    }

    func getSongs() -> [Any] {
        var songs = [Any]()
        for item in ["七里香","青花瓷","简单爱","双截棍","夜曲","以父之名","稻香","可爱女人","红尘客栈","床边故事","跨时代"] {
            songs.append(SongsModel(name: item))
        }
        return songs
        
    }
}

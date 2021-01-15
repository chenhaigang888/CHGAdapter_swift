//
//  Base0ViewController.swift
//  CHGAdapter_swift
//
//  Created by 陈海刚 on 2021/1/15.
//  Copyright © 2021 chen haiGang. All rights reserved.
//

import UIKit

class Base0ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.cellDatas = ["😂","😊","😄","😏","😂","😊","😄","😏"]
    }
}

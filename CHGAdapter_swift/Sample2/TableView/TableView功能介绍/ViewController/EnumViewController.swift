//
//  EnumViewController.swift
//  CHGAdapter_swift
//
//  Created by DNAER5 on 2020/1/6.
//  Copyright © 2020 chen haiGang. All rights reserved.
//

import UIKit

class EnumViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.cellDatas = [getWeeks(),getPays()]
    }
    
    func getWeeks() -> [Week] {
        return [.Monday,.Tuesday,.Wednesday,.Thursday,.Friday,.Saturday,.Sunday]
    }
    
    func getPays() -> [Pay] {
        return [.aliPay,.wechatPay,.unionPay]
    }

}

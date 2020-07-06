//
//  Base5ViewController.swift
//  CHGAdapter_swift
//
//  Created by dnaer5 on 2020/7/6.
//  Copyright © 2020 chen haiGang. All rights reserved.
//

import UIKit

class Base6ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "基础5-1（cell和headerFooter为同一个Model）"
        
        tableView.headerDatas = createData()
        tableView.cellDatas = createData()
        tableView.footerDatas = createData()
        tableView.tableViewAdapter?.keyPathOfSubData = \ProductsType.productses
    }


    func createData() -> [Any] {
        var productTypes = [ProductsType]()
        let types = ["电脑","手机","耳机"]
        let pcs = ["联想","华为","惠普","戴尔","神舟","苹果"]
        
        for i in 0..<3 {
            var productses = [Products]()
            for item in pcs {
                productses.append(Products.init(name: "\(item)\(types[i])", price: "4999", image: "pc", desc: ""))
            }
            productTypes.append(ProductsType.init(name: types[i], productses: productses, desc: "这是\(types[i])类型商品的描述内容!"))
        }
        
        return productTypes
    }
    
    

}

//
//  KeyPathViewController.swift
//  CHGAdapter_swift
//
//  Created by chen haiGang on 2018/9/11.
//  Copyright © 2018年 chen haiGang. All rights reserved.
//

import UIKit

class KeyPathViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.tableViewAdapter?.rowsOfSectionKeyName = \GoodsCategory.goods
        let foods:[Goods] =
        [
            Goods.init(name: "汉堡", price: 20),
            Goods.init(name: "炸鸡", price: 30),
            Goods.init(name: "可乐", price: 32),
            Goods.init(name: "薯条", price: 35),
        ]
        
        let pc:[Goods] =
        [
            Goods.init(name: "苹果电脑", price: 20),
            Goods.init(name: "联想电脑", price: 30),
            Goods.init(name: "Dell电脑", price: 32),
            Goods.init(name: "惠普电脑", price: 35),
        ]
        //-----------------------------------------------
        let citys1:[CityModel] =
        [
            CityModel.init(name: "北京"),
            CityModel.init(name: "上海"),
            CityModel.init(name: "广州"),
            CityModel.init(name: "深圳"),
        ]
        
        let citys2:[CityModel] =
        [
            CityModel.init(name: "纽约"),
            CityModel.init(name: "华盛顿"),
            CityModel.init(name: "丹佛"),
            CityModel.init(name: "旧金山"),
        ]
        
        
        
        
        
        tableView.cellDatas =
        [
            GoodsCategory.init(name: "食品", goods: foods),
            GoodsCategory.init(name: "电脑", goods: pc),
            CountryModel.init(name: "中国", citys: citys1),
            CountryModel.init(name: "美国", citys: citys2)
        ]
        
        tableView.headerDatas = tableView.cellDatas
        tableView.indexDatas = ["A","B","C","D","E","F"]

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

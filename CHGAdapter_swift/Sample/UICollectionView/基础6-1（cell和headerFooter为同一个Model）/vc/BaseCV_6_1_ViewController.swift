//
//  BaseCV_6_1_ViewController.swift
//  CHGAdapter_swift
//
//  Created by dnaer5 on 2020/7/7.
//  Copyright © 2020 chen haiGang. All rights reserved.
//

import UIKit

class BaseCV_6_1_ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "基础6-1（cell和headerFooter为同一个Model）"
        
        collectionView.headerDatas = createData()
        collectionView.cellDatas = createData()
        collectionView.footerDatas = createData()
        collectionView.collectionViewAdapter?.keyPathOfSubData = \ProductsType.productses
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

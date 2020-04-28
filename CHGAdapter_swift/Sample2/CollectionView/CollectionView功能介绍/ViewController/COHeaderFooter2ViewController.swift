//
//  COHeaderFooter2ViewController.swift
//  CHGAdapter_swift
//
//  Created by DNAER5 on 2019/12/19.
//  Copyright © 2019 chen haiGang. All rights reserved.
//

import UIKit

class COHeaderFooter2ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        let goodsTypes = getGoodsTypes()
//        collectionView.headerDatas = goodsTypes
//        collectionView.cellDatas = goodsTypes
//        collectionView.footerDatas = goodsTypes
    }
    
//    func getGoodsTypes() -> [GoodsType] {
//        var goodsTypes = [GoodsType]()
//        var i = 0
//        for type in ["国产品牌","国外品牌"] {
//            goodsTypes.append(GoodsType.init(type: type,
//                                             computers: i==0 ? getChinaComputers() : getAmericanComputers(),
//                                             bgColor: i==0 ? .red : .yellow))
//            i += 1
//        }
//        return goodsTypes
//
//    }
    
    func getChinaComputers() -> [Computer] {
         var computers = [Computer]()
         let array = ["华为","联想","神舟","北大方正","清华同方"]
         for item in array {
             computers.append(Computer.init(brand: item))
         }
         return computers
     }
    
    func getAmericanComputers() -> [Computer] {
        var computers = [Computer]()
        let array = ["戴尔","苹果","惠普","外星人"]
        for item in array {
            computers.append(Computer.init(brand: item))
        }
        return computers
    }
}

//
//  COHeaderFooterViewController.swift
//  CHGAdapter_swift
//
//  Created by DNAER5 on 2019/12/19.
//  Copyright © 2019 chen haiGang. All rights reserved.
//

import UIKit

class COHeaderFooterViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
            super.viewDidLoad()
            
            collectionView.headerDatas = getHeaderData()
            collectionView.cellDatas = [getChinaComputers(),getAmericanComputers()]
    //        tableView.footerDatas = getHeaderData()
        }


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
        
        func getHeaderData() -> [Any] {
            let headerData = [Any]()
            
//            headerData.append(TBHeaderFooter.init(title: "国产品牌", titleColor: .red))
//            headerData.append(TBHeaderFooter.init(title: "国外品牌", titleColor: .blue))
            return headerData
        }

}

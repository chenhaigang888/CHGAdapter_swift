//
//  COVarietyData2ViewController.swift
//  CHGAdapter_swift
//
//  Created by DNAER5 on 2019/12/19.
//  Copyright © 2019 chen haiGang. All rights reserved.
//

import UIKit

class COVarietyData2ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
            super.viewDidLoad()
            let data = getData()
            
            collectionView.headerDatas = data
            collectionView.cellDatas = data
            
        }
        
        func getData() -> [Any] {
            var data = [Any]()
            for item in ["苹果","三星","华为","联想","小米"] {
                let products = [Computer.init(brand: "\(item)电脑"),
                                Phone.init(brand: "\(item)手机")] as [Any]
                
                let company = Company.init(name: item, products: products)
                data.append(company)
            }
            
            return data
        }

    

}

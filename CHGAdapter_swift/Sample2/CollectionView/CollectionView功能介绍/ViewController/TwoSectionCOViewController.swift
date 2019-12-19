//
//  TwoSectionCOViewController.swift
//  CHGAdapter_swift
//
//  Created by DNAER5 on 2019/12/19.
//  Copyright © 2019 chen haiGang. All rights reserved.
//

import UIKit

class TwoSectionCOViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let array1 = getComputers()
        let array2 = getComputers()
        collectionView.cellDatas = [array1,array2]
    }
        
    func getComputers() -> [Computer] {
        var computers = [Computer]()
        let array = ["联想","戴尔","苹果","神舟","惠普","微星","外星人"]
        for item in array {
            computers.append(Computer.init(brand: item))
        }
        return computers
    }

}

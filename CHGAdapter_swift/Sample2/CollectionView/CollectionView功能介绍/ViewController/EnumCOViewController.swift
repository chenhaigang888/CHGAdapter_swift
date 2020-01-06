//
//  EnumCOViewController.swift
//  CHGAdapter_swift
//
//  Created by DNAER5 on 2020/1/6.
//  Copyright © 2020 chen haiGang. All rights reserved.
//

import UIKit

class EnumCOViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.cellDatas = [getData()]
    }

    func getData() -> [Week] {
        return [.Monday,.Tuesday,.Wednesday,.Thursday,.Friday,.Saturday,.Sunday]
    }
    
}

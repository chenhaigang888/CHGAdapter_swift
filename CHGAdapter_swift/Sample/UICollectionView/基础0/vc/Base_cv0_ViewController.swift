//
//  Base_cv0_ViewController.swift
//  CHGAdapter_swift
//
//  Created by 陈海刚 on 2021/1/15.
//  Copyright © 2021 chen haiGang. All rights reserved.
//

import UIKit

class Base_cv0_ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.cellDatas = [["😂","😊","😄","😏"],
                                    ["😂","😊","😄","😏"],
                                    ["😂","😊","😄","😏"],
                                    ["😂","😊","😄","😏"],
                                    ["😂","😊","😄","😏"],
                                    ["😂","😊","😄","😏"]]
    }

}

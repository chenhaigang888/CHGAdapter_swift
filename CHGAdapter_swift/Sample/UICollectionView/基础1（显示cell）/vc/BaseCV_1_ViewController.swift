//
//  BaseCV_1_ViewController.swift
//  CHGAdapter_swift
//
//  Created by dnaer5 on 2020/7/6.
//  Copyright © 2020 chen haiGang. All rights reserved.
//

import UIKit

class BaseCV_1_ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "基础1（显示cell）"
        collectionView.cellDatas = [getSongs()]
    }

    func getSongs() -> [Any] {
        var songs = [Any]()
        for item in ["七里香","青花瓷","简单爱","双截棍","夜曲","以父之名","稻香","可爱女人","红尘客栈","床边故事","跨时代"] {
            songs.append(SongsModel(name: item,cover: "jay"))
        }
        return songs
        
    }
}

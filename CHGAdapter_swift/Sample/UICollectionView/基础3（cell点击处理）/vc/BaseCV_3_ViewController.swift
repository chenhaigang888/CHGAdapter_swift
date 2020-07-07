//
//  BaseCV_3_ViewController.swift
//  CHGAdapter_swift
//
//  Created by dnaer5 on 2020/7/7.
//  Copyright © 2020 chen haiGang. All rights reserved.
//

import UIKit

class BaseCV_3_ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "基础3（cell点击处理）"
        collectionView.cellDatas = [getSongs()]
        collectionView.setCollectionViewDidSelectItemAtIndexPathBlock { (collectionView, indexPath, itemData) in
            guard let model:SongsModel = itemData as? SongsModel else { return }
            print("当前点击：\(model.name!)")
        }
    }

    func getSongs() -> [Any] {
        var songs = [Any]()
        for item in ["七里香","青花瓷","简单爱","双截棍","夜曲","以父之名","稻香","可爱女人","红尘客栈","床边故事","跨时代"] {
            songs.append(SongsModel(name: item,cover: "pc"))
        }
        return songs
        
    }


 

}

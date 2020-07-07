//
//  BaseCV_2_ViewController.swift
//  CHGAdapter_swift
//
//  Created by dnaer5 on 2020/7/6.
//  Copyright © 2020 chen haiGang. All rights reserved.
//

import UIKit

class BaseCV_2_ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "展示CollectionView中存在headerFooterView和cell的用法"
        collectionView.headerDatas = getHeaderModels()
        collectionView.cellDatas = [getSongs1(),getSongs2()]
        collectionView.footerDatas = getFooterModels()
    }
    
    ///专辑1数据
    func getSongs1() -> [Any] {
        var songs = [Any]()
        for item in ["半兽人","半岛铁盒","暗号","龙拳","火车叨位去","分裂（离开）","爷爷泡的茶","回到过去","米兰的小铁匠","最后的战役"] {
            songs.append(SongsModel(name: item,cover: "jay"))
        }
        return songs
    }
    
    ///专辑2数据
    func getSongs2() -> [Any] {
        var songs = [Any]()
        for item in ["爱在西元前","爸我回来了","简单爱","忍者","开不了口","上海一九四三","对不起","威廉古堡","双截棍","安静"] {
            songs.append(SongsModel(name: item,cover: "jay"))
        }
        return songs
    }
    
    ///headerView数据
    func getHeaderModels() -> [Any]? {
        return [Album.init(name: "八度空间", createTime: "2002年7月18日"),
                Album.init(name: "范特西", createTime: "2001年9月20日")]
    }
    
    ///footerView数据
    func getFooterModels() -> [Any]? {
        return [AlbumDesc.init(desc: "《八度空间》这张专辑的创作灵感来自周杰伦平时看的一些电影和音乐录影带。"),
                AlbumDesc.init(desc: "《范特西》的专辑名称来源是英文“Fantasy”的发音，意为范特西范特西(3张)“幻想” 。")]
    }

}

//
//  Base_6_2_ViewController.swift
//  CHGAdapter_swift
//
//  Created by dnaer5 on 2020/7/7.
//  Copyright © 2020 chen haiGang. All rights reserved.
//

import UIKit

class Base_6_2_ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "基础6-2（多种cell和headerFooter为同一个Model）"
        var data = [Any]()
        data.append(contentsOf: createProducts())
        data.append(contentsOf: createSinger())
        
        collectionView.headerDatas = data
        collectionView.cellDatas = data
        collectionView.footerDatas = data
        
//        提示
//        由于列表中有多种数据类型。因此以下代码应该注释掉。应该在 HeaderFooter的Model中通过“func subDataKeyPath(_ indexPath: IndexPath, inTableView tableView: UITableView) -> Any”方法动态的指定
//        tableView.tableViewAdapter?.keyPathOfSubData = \ProductsType.productses
    }

    
    /// 创建产品类型的数据
    /// - Returns: description
    func createProducts() -> [Any] {
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
    
    /// 创建歌手类型的数据
    /// - Returns: description
    func createSinger() -> [Singer] {
        var singers = [Singer]()
        
        let types = ["周杰伦","林俊杰","王力宏"]
        let jaySongs = ["七里香","青花瓷","简单爱","双截棍","夜曲","以父之名","稻香","可爱女人","红尘客栈","床边故事","跨时代"]
        let linJunJieSongs = ["江南","一千年以后","曹操","醉赤壁","100天","她说","学不会","修炼爱情","可惜没如果","不为谁而作的歌"]
        let wangLiHongSongs = ["公转自转","唯一","你不在","心中的日月","盖世英雄","我们的歌","心跳","需要人陪","缘分一道桥"]
        
        for i in 0..<3 {
            var songs = [SongsModel]()
            if i == 0 {
                for song in jaySongs {
                    songs.append(SongsModel.init(name: song, cover: ""))
                }
            } else if i == 1 {
                for song in linJunJieSongs {
                    songs.append(SongsModel.init(name: song, cover: ""))
                }
            } else if i == 2 {
               for song in wangLiHongSongs {
                   songs.append(SongsModel.init(name: song, cover: ""))
               }
            }
            singers.append(Singer.init(name: types[i], songs: songs,desc: "这是歌手'\(types[i])'的简介"))
        }
        
        return singers
        
    }

}

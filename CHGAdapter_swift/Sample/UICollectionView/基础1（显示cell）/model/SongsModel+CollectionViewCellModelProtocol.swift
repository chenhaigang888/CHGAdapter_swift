//
//  SongsModel+CollectionViewCellModelProtocol.swift
//  CHGAdapter_swift
//
//  Created by dnaer5 on 2020/7/6.
//  Copyright © 2020 chen haiGang. All rights reserved.
//

import UIKit

//为了节约写demo的速度，这里就使用TableView的Demo中的Model。

//当SongsModel在UICollectionView中显示的时候实现以下协议
extension SongsModel : CHGCollectionViewCellModelProtocol {
    
    func cellClass(collectionView: UICollectionView, at indexPath: IndexPath) -> AnyClass? {
        return SongsModelCollectionViewCell.self
    }
    
    func cellItemSize(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width - 10) / 2.0
        return CGSize.init(width: width, height: width + 21 + 5)
    }
}

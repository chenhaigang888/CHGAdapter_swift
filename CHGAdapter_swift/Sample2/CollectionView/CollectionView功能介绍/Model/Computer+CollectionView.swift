//
//  Computer+CollectionView.swift
//  CHGAdapter_swift
//
//  Created by DNAER5 on 2019/12/19.
//  Copyright © 2019 chen haiGang. All rights reserved.
//

import UIKit

extension Computer : CHGCollectionViewCellModelProtocol {
    func cellClassName(collectionView: UICollectionView, at indexPath: IndexPath) -> String {
        return "ComputerCollectionViewCell"
    }
    
    func cellItemSize(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = (collectionView.frame.width - 30) / 3.0
        return CGSize.init(width: itemWidth, height: itemWidth)
    }
}

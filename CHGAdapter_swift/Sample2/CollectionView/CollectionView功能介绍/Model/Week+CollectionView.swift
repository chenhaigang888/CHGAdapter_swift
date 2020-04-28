//
//  Week+CollectionView.swift
//  CHGAdapter_swift
//
//  Created by DNAER5 on 2020/1/6.
//  Copyright © 2020 chen haiGang. All rights reserved.
//

import UIKit

extension Week : CHGCollectionViewCellModelProtocol {
    
    func cellClass(collectionView: UICollectionView, at indexPath: IndexPath) -> AnyClass? {
        return WeekCollectionViewCell.self
    }
    
    func cellItemSize(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = (collectionView.frame.width - 30) / 3.0
        return CGSize.init(width: itemWidth, height: itemWidth)
    }
}

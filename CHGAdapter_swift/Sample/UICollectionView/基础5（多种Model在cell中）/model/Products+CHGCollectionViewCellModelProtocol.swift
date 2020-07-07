//
//  Products+CHGCollectionViewCellModelProtocol.swift
//  CHGAdapter_swift
//
//  Created by dnaer5 on 2020/7/7.
//  Copyright © 2020 chen haiGang. All rights reserved.
//

import UIKit

extension Products : CHGCollectionViewCellModelProtocol {
    func cellClass(collectionView: UICollectionView, at indexPath: IndexPath) -> AnyClass? {
        return ProductsCollectionViewCell.self
    }
    
    func cellItemSize(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 10) / 2.0
        return CGSize.init(width: width, height: width)
    }
}

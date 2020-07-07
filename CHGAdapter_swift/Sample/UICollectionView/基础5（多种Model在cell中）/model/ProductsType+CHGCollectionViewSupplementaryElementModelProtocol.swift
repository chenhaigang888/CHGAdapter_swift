//
//  ProductsType+CHGCollectionViewSupplementaryElementModelProtocol.swift
//  CHGAdapter_swift
//
//  Created by dnaer5 on 2020/7/7.
//  Copyright © 2020 chen haiGang. All rights reserved.
//

import UIKit


extension ProductsType : CHGCollectionViewSupplementaryElementModelProtocol {
    func reusableView(collectionView: UICollectionView, supplementaryElementOfKind kind: String, atIndexPath indexPath: IndexPath) -> AnyClass? {
        if kind == UICollectionView.elementKindSectionHeader {
            return ProductsTypeCollectionReusableView.self
        } else {
            return ProductsTypeFooterCollectionReusableView.self
        }
        
    }
    
    func referenceHeaderSize(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, atSection section: Int) -> CGSize {
        return CGSize.init(width: collectionView.frame.width, height: 50)
    }
    
    func referenceFooterSize(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, atSection section: Int) -> CGSize {
        return CGSize.init(width: collectionView.frame.width, height: 60)
    }
    
    func subDataKeyPath(_ indexPath: IndexPath, inCollectionView collectionView: UICollectionView) -> Any {
        return \ProductsType.productses
    }
}

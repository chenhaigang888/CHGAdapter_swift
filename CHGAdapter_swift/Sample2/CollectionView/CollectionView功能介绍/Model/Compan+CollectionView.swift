//
//  Compan+CollectionView.swift
//  CHGAdapter_swift
//
//  Created by DNAER5 on 2019/12/19.
//  Copyright © 2019 chen haiGang. All rights reserved.
//

import UIKit

extension Company : CHGCollectionViewSupplementaryElementModelProtocol {
    func reusableView(collectionView: UICollectionView, supplementaryElementOfKind kind: String, atIndexPath indexPath: IndexPath) -> AnyClass? {
        return CompanyCollectionReusableView.self
    }
    
    func referenceHeaderSize(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, atSection section: Int) -> CGSize {
        return CGSize.init(width: collectionView.frame.width, height: 40)
    }
    
    func subDataKeyPath(_ indexPath: IndexPath, inCollectionView collectionView: UICollectionView) -> Any {
        return \Company.products
    }
}

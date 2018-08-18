//
//  CVInputTextModel.swift
//  CHGAdapter_swift
//
//  Created by 陈 海刚 on 2018/8/18.
//  Copyright © 2018 chen haiGang. All rights reserved.
//

import UIKit

class CVInputTextModel: NSObject {
    
}

extension CVInputTextModel: CHGCollectionViewCellModelProtocol {
    func cellClassNameInCollectionView(collectionView: UICollectionView, atIndexPath: IndexPath) -> String {
        return "CVInputTextCollectionViewCell"
    }
    
    
}

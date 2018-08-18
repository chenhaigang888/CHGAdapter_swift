//
//  CVSimulationDownModel.swift
//  CHGAdapter_swift
//
//  Created by 陈 海刚 on 2018/8/18.
//  Copyright © 2018 chen haiGang. All rights reserved.
//

import UIKit


/// 模拟下载
class CVSimulationDownModel: NSObject {
    var url:String?
    
    init(url:String) {
        super.init()
        self.url = url
    }
}

extension CVSimulationDownModel: CHGCollectionViewCellModelProtocol {
    func cellClassNameInCollectionView(collectionView: UICollectionView, atIndexPath: IndexPath) -> String {
        return "CVSimulationDownCollectionViewCell"
    }
    
    
}

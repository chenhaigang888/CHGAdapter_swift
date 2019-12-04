//
//  GoodsCategoryCollectionReusableView.swift
//  CHGAdapter_swift
//
//  Created by chen haiGang on 2018/9/12.
//  Copyright © 2018年 chen haiGang. All rights reserved.
//

import UIKit

class GoodsCategoryCollectionReusableView: CHGCollectionReusableView {

    @IBOutlet weak var title:UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func reusableViewFor(collectionView: UICollectionView, indexPath: IndexPath, kind: NSString, reusableViewData: Any?) {
        super.reusableViewFor(collectionView: collectionView, indexPath: indexPath, kind: kind, reusableViewData: reusableViewData)
        let model:GoodsCategory = reusableViewData as! GoodsCategory
        title?.text = model.name
    }
}

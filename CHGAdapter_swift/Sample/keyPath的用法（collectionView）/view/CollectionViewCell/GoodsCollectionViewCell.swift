//
//  GoodsCollectionViewCell.swift
//  CHGAdapter_swift
//
//  Created by chen haiGang on 2018/9/12.
//  Copyright © 2018年 chen haiGang. All rights reserved.
//

import UIKit

class GoodsCollectionViewCell: CHGCollectionViewCell {
    
    @IBOutlet weak var title:UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func cellForRow(atIndexPath indexPath: IndexPath, collectionView: UICollectionView?, data: AnyObject?) {
        super.cellForRow(atIndexPath: indexPath, collectionView: collectionView, data: data)
        let model:Goods = data as! Goods
        title?.text = model.name
    }
}

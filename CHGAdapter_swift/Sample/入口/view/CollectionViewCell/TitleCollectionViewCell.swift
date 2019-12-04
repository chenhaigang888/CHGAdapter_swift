//
//  TitleCollectionViewCell.swift
//  CHGAdapter_swift
//
//  Created by chen haiGang on 2018/8/20.
//  Copyright © 2018年 chen haiGang. All rights reserved.
//

import UIKit

class TitleCollectionViewCell: CHGCollectionViewCell {
    
    @IBOutlet weak var name:UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func cellForRow(atIndexPath indexPath: IndexPath, collectionView: UICollectionView?, data: Any?) {
        super.cellForRow(atIndexPath: indexPath, collectionView: collectionView, data: data)
        let titleModel:TitleModel = data as! TitleModel
        name?.text = titleModel.name
    }

}

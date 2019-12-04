//
//  CityCollectionViewCell.swift
//  CHGAdapter_swift
//
//  Created by chen haiGang on 2018/9/12.
//  Copyright © 2018年 chen haiGang. All rights reserved.
//

import UIKit

class CityCollectionViewCell: CHGCollectionViewCell {
    
    @IBOutlet weak var title:UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func cellForRow(atIndexPath indexPath: IndexPath, collectionView: UICollectionView?, data: Any?) {
        super.cellForRow(atIndexPath: indexPath, collectionView: collectionView, data: data)
        let model:CityModel = data as! CityModel
        title?.text = model.name
    }

}

//
//  CVTitleCollectionViewCell.swift
//  CHGAdapter_swift
//
//  Created by 陈 海刚 on 2018/8/18.
//  Copyright © 2018 chen haiGang. All rights reserved.
//

import UIKit

class CVTitleCollectionViewCell: CHGCollectionViewCell {
    
    @IBOutlet weak var name:UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func cellForRow(atIndexPath indexPath: IndexPath, collectionView: UICollectionView?, data: Any?,eventTransmissionBlock:CHGEventTransmissionBlock?) {
        super.cellForRow(atIndexPath: indexPath, collectionView: collectionView, data: data,eventTransmissionBlock: eventTransmissionBlock)
        let titleModel:CVTitleModel = data as! CVTitleModel
        self.name?.text = titleModel.name
        
    }
}

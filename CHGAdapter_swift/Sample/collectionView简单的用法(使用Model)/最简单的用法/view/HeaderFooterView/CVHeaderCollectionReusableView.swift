//
//  CVHeaderCollectionReusableView.swift
//  CHGAdapter_swift
//
//  Created by 陈 海刚 on 2018/8/18.
//  Copyright © 2018 chen haiGang. All rights reserved.
//

import UIKit

class CVHeaderCollectionReusableView: CHGCollectionReusableView {
    
    @IBOutlet weak var name:UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
//    override func reusableViewFor(collectionView: UICollectionView, indexPath: IndexPath, kind: NSString, reusableViewData: Any?,eventTransmissionBlock:CHGEventTransmissionBlock?) {
//    super.reusableViewFor(collectionView: collectionView, indexPath: indexPath, kind: kind, reusableViewData: reusableViewData,eventTransmissionBlock: eventTransmissionBlock)
//        let headerModel:CVHeaderModel = reusableViewData as! CVHeaderModel
//        self.name?.text = headerModel.name
//        self.name?.backgroundColor = headerModel.bgColor
//    }
    
    override func reusableViewWillAppear() {
        super.reusableViewWillAppear()
        let headerModel:CVHeaderModel = self.model as! CVHeaderModel
        self.name?.text = headerModel.name
        self.name?.backgroundColor = headerModel.bgColor
    }
    
}

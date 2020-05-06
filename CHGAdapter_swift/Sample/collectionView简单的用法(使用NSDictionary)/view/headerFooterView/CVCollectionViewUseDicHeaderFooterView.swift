//
//  CVCollectionViewUseDicHeaderFooterView.swift
//  CHGAdapter_swift
//
//  Created by 陈 海刚 on 2018/8/18.
//  Copyright © 2018 chen haiGang. All rights reserved.
//

import UIKit

class CVCollectionViewUseDicHeaderFooterView: CHGCollectionReusableView {
    
    @IBOutlet weak var title:UILabel?

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
//    override func reusableViewFor(collectionView: UICollectionView, indexPath: IndexPath, kind: NSString, reusableViewData: Any?,eventTransmissionBlock:CHGEventTransmissionBlock?) {
//    super.reusableViewFor(collectionView: collectionView, indexPath: indexPath, kind: kind, reusableViewData: reusableViewData,eventTransmissionBlock: eventTransmissionBlock)
//        if reusableViewData is NSDictionary {
//            let dic:NSDictionary = reusableViewData as! NSDictionary
//            title?.text = dic["groupName"] as? String
//        } else {
//            let group:Group = reusableViewData as! Group
//            title?.text = "Model:\(group.groupName!)"
//        }
//    }
    
    override func reusableViewWillAppear() {
        super.reusableViewWillAppear()
        if self.model is NSDictionary {
            let dic:NSDictionary = self.model as! NSDictionary
            title?.text = dic["groupName"] as? String
        } else {
            let group:Group = self.model as! Group
            title?.text = "Model:\(group.groupName!)"
        }
    }
}

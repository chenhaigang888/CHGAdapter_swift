//
//  TBHeaderFooterCollectionReusableView.swift
//  CHGAdapter_swift
//
//  Created by DNAER5 on 2019/12/19.
//  Copyright © 2019 chen haiGang. All rights reserved.
//

import UIKit

class TBHeaderFooterCollectionReusableView: CHGCollectionReusableView {

    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func reusableViewFor(collectionView: UICollectionView, indexPath: IndexPath, kind: NSString, reusableViewData: Any?) {
        super.reusableViewFor(collectionView: collectionView, indexPath: indexPath, kind: kind, reusableViewData: reusableViewData)
//        let model:TBHeaderFooter = self.reusableViewData as! TBHeaderFooter
//        title.text = model.title
    }
    
    
}

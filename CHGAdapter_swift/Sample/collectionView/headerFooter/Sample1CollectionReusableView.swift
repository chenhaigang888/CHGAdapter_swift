//
//  Sample1CollectionReusableView.swift
//  CHGAdapter_swift
//
//  Created by 陈 海刚 on 2018/5/17.
//  Copyright © 2018年 chen haiGang. All rights reserved.
//

import UIKit

class Sample1CollectionReusableView: CHGCollectionReusableView {
    
    @IBOutlet var title:UILabel?
    
    @IBAction func valueChanged(_ sender:AnyObject) ->Void {
        self.eventTransmissionBlock!(self,self.reusableViewData!,1,{(data:AnyObject?)->Void in
            print("返回结果：\(data!)")
        })
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func reusableViewFor(collectionView: UICollectionView, indexPath: IndexPath, kind: NSString, reusableViewData: AnyObject?) {
        super .reusableViewFor(collectionView: collectionView, indexPath: indexPath, kind: kind, reusableViewData: reusableViewData)
        self.title?.text = reusableViewData! as? String
    }
    
}

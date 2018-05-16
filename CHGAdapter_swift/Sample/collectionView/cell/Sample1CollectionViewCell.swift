//
//  Sample1CollectionViewCell.swift
//  CHGAdapter_swift
//
//  Created by 陈 海刚 on 2018/5/17.
//  Copyright © 2018年 chen haiGang. All rights reserved.
//

import UIKit

class Sample1CollectionViewCell: CHGCollectionViewCell {
    
    @IBOutlet var btn:UIButton?
    
    @IBAction func btnTap(_ sender:AnyObject)->Void {
        self.eventTransmissionBlock!(self,self.cellData!,1,{(data:AnyObject?)->Void in
            (self.btn?.setTitle(data! as? String, for: UIControlState.normal))!
        })
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func cellForRow(atIndexPath indexPath: IndexPath, collectionView: UICollectionView?, data: AnyObject?) {
        super.cellForRow(atIndexPath: indexPath, collectionView: collectionView, data: data)
        (btn?.setTitle(data! as? String, for: UIControlState.normal))!
    }

}

//
//  CVInputTextCollectionViewCell.swift
//  CHGAdapter_swift
//
//  Created by 陈 海刚 on 2018/8/18.
//  Copyright © 2018 chen haiGang. All rights reserved.
//

import UIKit


class CVInputTextCollectionViewCell: CHGCollectionViewCell {
    
    @IBOutlet weak var textField:UITextField?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func cellForRow(atIndexPath indexPath: IndexPath, collectionView: UICollectionView?, data: AnyObject?) {
        super.cellForRow(atIndexPath: indexPath, collectionView: collectionView, data: data)
        
    }
    
    
    @IBAction func textViewChanged(sender:AnyObject) -> Void{
        //使用此block 向外传递数据
        _ = self.eventTransmissionBlock!(self,textField?.text as AnyObject,0,{(data) in
                //外部可以通过这个闭包异步的返回数据
            });
    }
}

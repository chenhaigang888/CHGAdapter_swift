//
//  CVSimulationDownCollectionViewCell.swift
//  CHGAdapter_swift
//
//  Created by 陈 海刚 on 2018/8/18.
//  Copyright © 2018 chen haiGang. All rights reserved.
//

import UIKit

class CVSimulationDownCollectionViewCell: CHGCollectionViewCell {
    
    @IBOutlet weak var downloadBtn:UIButton?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func cellForRow(atIndexPath indexPath: IndexPath, collectionView: UICollectionView?, data: Any?) {
        super .cellForRow(atIndexPath: indexPath, collectionView: collectionView, data: data)
    }

    @IBAction func downloadBtnTap(sender:AnyObject)->Void {
        _ = self.eventTransmissionBlock!(self,self.cellData!,0,{[weak self](data) in
                //外部传回的下载进度 将下载进度设置为downloadBtn 的title
            self?.downloadBtn?.setTitle(data as? String, for: UIControl.State.normal)
            })
    }
    
}

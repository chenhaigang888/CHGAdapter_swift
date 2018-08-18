//
//  CVFriendUseDicCollectionViewCell.swift
//  CHGAdapter_swift
//
//  Created by 陈 海刚 on 2018/8/18.
//  Copyright © 2018 chen haiGang. All rights reserved.
//

import UIKit

class CVFriendUseDicCollectionViewCell: CHGCollectionViewCell {
    
    @IBOutlet weak var icon:UIImageView?
    @IBOutlet weak var title:UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func cellForRow(atIndexPath indexPath: IndexPath, collectionView: UICollectionView?, data: AnyObject?) {
        super.cellForRow(atIndexPath: indexPath, collectionView: collectionView, data: data)
        let dic:NSDictionary = data as! NSDictionary
        icon?.image = UIImage.init(named: dic["icon"] as! String)
        title?.text = dic["name"] as? String
    }
    
}

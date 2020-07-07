//
//  SongsModelCollectionViewCell.swift
//  CHGAdapter_swift
//
//  Created by dnaer5 on 2020/7/6.
//  Copyright © 2020 chen haiGang. All rights reserved.
//

import UIKit

class SongsModelCollectionViewCell: CHGCollectionViewCell {
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func cellWillAppear() {
        super.cellWillAppear()
        guard let model:SongsModel = self.model as? SongsModel else { return }
        nameLabel.text = model.name
        icon.image = UIImage.init(named: model.cover!)
    }

}

//
//  StringCollectionReusableView.swift
//  CHGAdapter_swift
//
//  Created by dnaer5 on 2021/1/18.
//  Copyright © 2021 chen haiGang. All rights reserved.
//

import UIKit
import Pods_CHGAdapter_swift

class StringCollectionReusableView: CHGCollectionReusableView {
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func reusableViewWillAppear() {
        super.reusableViewWillAppear()
        nameLabel.text = model as? String
    }
}

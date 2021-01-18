//
//  StringTableViewHeaderFooterView.swift
//  CHGAdapter_swift
//
//  Created by dnaer5 on 2021/1/18.
//  Copyright © 2021 chen haiGang. All rights reserved.
//

import UIKit
import Pods_CHGAdapter_swift

class StringTableViewHeaderFooterView: CHGTableViewHeaderFooterView {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func headerFooterViewWillAppear(with type: CHGAdapterViewType) {
        super.headerFooterViewWillAppear(with: type)
        nameLabel.text = model as? String
    }

}

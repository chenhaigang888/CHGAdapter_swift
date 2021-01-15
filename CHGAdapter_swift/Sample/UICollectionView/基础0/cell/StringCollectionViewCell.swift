//
//  StringCollectionViewCell.swift
//  CHGAdapter_swift
//
//  Created by 陈海刚 on 2021/1/15.
//  Copyright © 2021 chen haiGang. All rights reserved.
//

import UIKit

class StringCollectionViewCell: CHGCollectionViewCell {
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func cellWillAppear() {
        super.cellWillAppear()
        guard let str:String = model as? String else { return }
        label.text = str
    }
}

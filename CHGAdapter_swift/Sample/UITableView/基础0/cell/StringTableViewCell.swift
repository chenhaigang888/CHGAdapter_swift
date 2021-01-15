//
//  StringTableViewCell.swift
//  CHGAdapter_swift
//
//  Created by 陈海刚 on 2021/1/15.
//  Copyright © 2021 chen haiGang. All rights reserved.
//

import UIKit

class StringTableViewCell: CHGTableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func cellWillAppear() {
        super.cellWillAppear()
        guard let model:String = model as? String else { return }
        textLabel?.text = model
    }
    
}

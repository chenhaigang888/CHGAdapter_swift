//
//  PhoneCollectionViewCell.swift
//  CHGAdapter_swift
//
//  Created by DNAER5 on 2019/12/19.
//  Copyright © 2019 chen haiGang. All rights reserved.
//

import UIKit

class PhoneCollectionViewCell: CHGCollectionViewCell {

    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func cellWillAppear() {
        super.cellWillAppear()
        let phone:Phone = self.model as! Phone
        title.text = phone.brand
    }
}

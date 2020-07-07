//
//  SingerCollectionReusableView.swift
//  CHGAdapter_swift
//
//  Created by dnaer5 on 2020/7/7.
//  Copyright © 2020 chen haiGang. All rights reserved.
//

import UIKit

class SingerCollectionReusableView: CHGCollectionReusableView {

    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func reusableViewWillAppear() {
        super.reusableViewWillAppear()
        guard let model:Singer = self.model as? Singer else { return }
        nameLabel.text = model.name
    }
    
}

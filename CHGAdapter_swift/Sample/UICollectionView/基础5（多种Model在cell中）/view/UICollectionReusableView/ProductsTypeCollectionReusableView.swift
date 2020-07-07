//
//  ProductsTypeCollectionReusableView.swift
//  CHGAdapter_swift
//
//  Created by dnaer5 on 2020/7/7.
//  Copyright © 2020 chen haiGang. All rights reserved.
//

import UIKit

class ProductsTypeCollectionReusableView: CHGCollectionReusableView {

    @IBOutlet weak var nameLabel: UILabel!
    
    override func reusableViewWillAppear() {
        super.reusableViewWillAppear()
        guard let model:ProductsType = self.model as? ProductsType else { return }
        nameLabel.text = model.name
    }
}

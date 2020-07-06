//
//  ProductsTypeHeaderFooterView.swift
//  CHGAdapter_swift
//
//  Created by dnaer5 on 2020/7/6.
//  Copyright © 2020 chen haiGang. All rights reserved.
//

import UIKit

class ProductsTypeHeaderFooterView: CHGTableViewHeaderFooterView {

    @IBOutlet weak var nameLabel: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func headerFooterViewWillAppear(with type: CHGAdapterViewType) {
        super.headerFooterViewWillAppear(with: type)
        guard let model:ProductsType = self.model as? ProductsType else { return }
        nameLabel.text = model.name
    }
}

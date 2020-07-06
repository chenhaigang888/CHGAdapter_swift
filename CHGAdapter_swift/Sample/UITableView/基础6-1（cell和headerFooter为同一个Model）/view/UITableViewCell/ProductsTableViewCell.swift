//
//  ProductsTableViewCell.swift
//  CHGAdapter_swift
//
//  Created by dnaer5 on 2020/7/6.
//  Copyright © 2020 chen haiGang. All rights reserved.
//

import UIKit

class ProductsTableViewCell: CHGTableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var price: UILabel!
    
    override func cellWillAppear() {
        super.cellWillAppear()
        guard let model:Products = self.model as? Products else { return }
        name.text = model.name
        price.text = model.price
        icon.image = UIImage(named:model.image!)
    }
    
}

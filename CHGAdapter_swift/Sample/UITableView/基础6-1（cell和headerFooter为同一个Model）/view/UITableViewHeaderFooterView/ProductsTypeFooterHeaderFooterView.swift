//
//  ProductsTypeFooterHeaderFooterView.swift
//  CHGAdapter_swift
//
//  Created by dnaer5 on 2020/7/6.
//  Copyright © 2020 chen haiGang. All rights reserved.
//

import UIKit

class ProductsTypeFooterHeaderFooterView: CHGTableViewHeaderFooterView {

    @IBOutlet weak var textView: UITextView!
    
    override func headerFooterViewWillAppear(with type: CHGAdapterViewType) {
        super.headerFooterViewWillAppear(with: type)
        
        guard let model:ProductsType = self.model as? ProductsType else { return }
        textView.text = model.desc
    }

}

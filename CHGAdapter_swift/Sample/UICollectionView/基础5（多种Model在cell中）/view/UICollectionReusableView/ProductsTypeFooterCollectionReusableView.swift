//
//  ProductsTypeFooterCollectionReusableView.swift
//  CHGAdapter_swift
//
//  Created by dnaer5 on 2020/7/7.
//  Copyright © 2020 chen haiGang. All rights reserved.
//

import UIKit

class ProductsTypeFooterCollectionReusableView: CHGCollectionReusableView {

    @IBOutlet weak var textView: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func reusableViewWillAppear() {
        super.reusableViewWillAppear()
        guard let model:ProductsType = self.model as? ProductsType else { return }
        textView.text = model.desc
    }
}

//
//  SingerDescHeaderFooterView.swift
//  CHGAdapter_swift
//
//  Created by dnaer5 on 2020/7/6.
//  Copyright © 2020 chen haiGang. All rights reserved.
//

import UIKit

class SingerDescHeaderFooterView: CHGTableViewHeaderFooterView {

    
    
    @IBOutlet weak var desc: UITextView!
    override func headerFooterViewWillAppear(with type: CHGAdapterViewType) {
        super.headerFooterViewWillAppear(with: type)
        guard let model:Singer = self.model as? Singer else { return }
        desc.text = model.desc
    }

}

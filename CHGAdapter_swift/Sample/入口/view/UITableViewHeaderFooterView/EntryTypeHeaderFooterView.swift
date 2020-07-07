//
//  EntryTypeHeaderFooterView.swift
//  CHGAdapter_swift
//
//  Created by dnaer5 on 2020/7/7.
//  Copyright © 2020 chen haiGang. All rights reserved.
//

import UIKit

class EntryTypeHeaderFooterView: CHGTableViewHeaderFooterView {

    @IBOutlet weak var titleLabel: UILabel!
   
    override func headerFooterViewWillAppear(with type: CHGAdapterViewType) {
        super.headerFooterViewWillAppear(with: type)
        guard let model:EntryType = self.model as? EntryType else { return }
        titleLabel.text = model.title
    }

}

//
//  OrderGroupHeaderFooterView.swift
//  CHGAdapter_swift
//
//  Created by dnaer5 on 2020/7/6.
//  Copyright © 2020 chen haiGang. All rights reserved.
//

import UIKit

class OrderGroupHeaderFooterView: CHGTableViewHeaderFooterView {

    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var delBtn: UIButton!
    
    override func headerFooterViewWillAppear(with type: CHGAdapterViewType) {
        super.headerFooterViewWillAppear(with: type)
        guard let model:OrderGroup = self.model as? OrderGroup else { return }
        descLabel.text = model.desc
    }
    
    @IBAction func delBtnTap(_ sender: Any) {
        _ = self.eventTransmissionBlock?(self, self.model, 0, {(data:Any?)->Any? in
            return nil
        })
    }
}

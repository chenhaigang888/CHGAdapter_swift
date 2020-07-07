//
//  OrderGroupCollectionReusableView.swift
//  CHGAdapter_swift
//
//  Created by dnaer5 on 2020/7/7.
//  Copyright © 2020 chen haiGang. All rights reserved.
//

import UIKit

class OrderGroupCollectionReusableView: CHGCollectionReusableView {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func reusableViewWillAppear() {
        super.reusableViewWillAppear()
        guard let model:OrderGroup = self.model as? OrderGroup else { return }
        titleLabel.text = model.desc
    }
    
    @IBAction func delBtnTap(_ sender: Any) {
        _ = self.eventTransmissionBlock?(self, self.model, 0, {(data:Any?)->Any? in
            return nil
        })
    }
}


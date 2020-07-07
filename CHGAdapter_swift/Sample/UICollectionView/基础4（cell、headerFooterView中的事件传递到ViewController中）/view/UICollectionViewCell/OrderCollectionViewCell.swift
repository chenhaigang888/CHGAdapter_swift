//
//  OrderCollectionViewCell.swift
//  CHGAdapter_swift
//
//  Created by dnaer5 on 2020/7/7.
//  Copyright © 2020 chen haiGang. All rights reserved.
//

import UIKit

class OrderCollectionViewCell: CHGCollectionViewCell {

    @IBOutlet weak var orderNO: UILabel!
    @IBOutlet weak var orderAmount: UILabel!
    @IBOutlet weak var createTime: UILabel!
    
    override func cellWillAppear() {
        super.cellWillAppear()
        guard let model:Order = self.model as? Order else { return }
        self.orderNO.text = "订单编号：\(model.orderNO)"
        self.orderAmount.text = "订单金额：\(model.amount)"
        self.createTime.text = "下单时间：\(model.createTime)"
    }
    
    @IBAction func refund(_ sender: Any) {
        _ = self.eventTransmissionBlock?(self, self.model, OrderAction.refund.rawValue, nil)
    }
    
    @IBAction func conform(_ sender: Any) {
        _ = self.eventTransmissionBlock?(self, self.model, OrderAction.conform.rawValue, { (data) -> Any? in
            guard let conformBtn:UIButton = sender as? UIButton, let succ:Bool = data as? Bool else {return nil}
            conformBtn.isHidden = succ
            return nil
        })
    }
}

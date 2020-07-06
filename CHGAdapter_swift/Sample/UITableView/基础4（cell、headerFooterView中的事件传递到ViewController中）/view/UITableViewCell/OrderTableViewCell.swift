//
//  OrderTableViewCell.swift
//  CHGAdapter_swift
//
//  Created by dnaer5 on 2020/7/6.
//  Copyright © 2020 chen haiGang. All rights reserved.
//

import UIKit


/// 订单操作
enum OrderAction:Int {
    case refund = 0//退货动作
    case conform = 1//确认收货动作
}

class OrderTableViewCell: CHGTableViewCell {
    @IBOutlet weak var orderNO: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var createTime: UILabel!
    
    
    override func cellWillAppear() {
        super.cellWillAppear()
        guard let model:Order = self.model as? Order else { return }
        self.orderNO.text = "订单编号：\(model.orderNO)"
        self.amount.text = "订单金额：\(model.amount)"
        self.createTime.text = "下单时间：\(model.createTime)"
    }
    
    /// 退货按钮点击
    /// - Parameter sender: sender description
    @IBAction func refund(_ sender: Any) {
        _ = self.eventTransmissionBlock?(self, self.model, OrderAction.refund.rawValue, nil)
    }
    
    /// 确认收货按钮点击
    /// - Parameter sender: sender description
    @IBAction func conform(_ sender: Any) {
        _ = self.eventTransmissionBlock?(self, self.model, OrderAction.conform.rawValue, { (data) -> Any? in
            guard let conformBtn:UIButton = sender as? UIButton, let succ:Bool = data as? Bool else {return nil}
            conformBtn.isHidden = succ
            return nil
        })
    }
}

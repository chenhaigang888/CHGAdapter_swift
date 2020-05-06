//
//  TVSubmitHeaderFooterView.swift
//  CHGAdapter_swift
//
//  Created by 陈 海刚 on 2018/8/18.
//  Copyright © 2018 chen haiGang. All rights reserved.
//

import UIKit

class TVSubmitHeaderFooterView: CHGTableViewHeaderFooterView {
    
    @IBOutlet weak var leftBtn:UIButton?
    @IBOutlet weak var rightBtn:UIButton?
    
//    override func headerFooter(section: NSInteger, tableView: UITableView, data: Any, type: CHGTableViewHeaderFooterViewType,eventTransmissionBlock:CHGEventTransmissionBlock?) {
//        super.headerFooter(section: section, tableView: tableView, data: data, type: type,eventTransmissionBlock: eventTransmissionBlock)
//        let submitModel:TVSubmitModel = data as! TVSubmitModel
//        leftBtn?.setTitle(submitModel.leftBtnText, for: UIControl.State.normal)
//        rightBtn?.setTitle(submitModel.rightBtnText, for: UIControl.State.normal)
//    }
    
    override func headerFooterViewWillAppear(with type: CHGTableViewHeaderFooterViewType) {
        super.headerFooterViewWillAppear(with: type)
        let submitModel:TVSubmitModel = self.model as! TVSubmitModel
        leftBtn?.setTitle(submitModel.leftBtnText, for: UIControl.State.normal)
        rightBtn?.setTitle(submitModel.rightBtnText, for: UIControl.State.normal)
    }
    
    @IBAction func leftBtnTap(sender:AnyObject)->Void {
        _ = self.eventTransmissionBlock!(self,self.model!,0,nil)
    }

    @IBAction func rightBtnTap(sender:AnyObject)->Void {
        _ = self.eventTransmissionBlock!(self,self.model!,1,nil)
    }
}

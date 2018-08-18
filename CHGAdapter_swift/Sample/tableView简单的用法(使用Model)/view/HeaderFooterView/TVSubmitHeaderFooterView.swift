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
    
    override func headerFooter(headerFooterForSection section: NSInteger, tableView: UITableView, data: AnyObject, type: CHGTableViewHeaderFooterViewType) {
        super.headerFooter(headerFooterForSection: section, tableView: tableView, data: data, type: type)
        let submitModel:TVSubmitModel = data as! TVSubmitModel
        leftBtn?.setTitle(submitModel.leftBtnText, for: UIControlState.normal)
        rightBtn?.setTitle(submitModel.rightBtnText, for: UIControlState.normal)
    }
    
    @IBAction func leftBtnTap(sender:AnyObject)->Void {
        _ = self.eventTransmissionBlock!(self,self.headerFooterData!,0,nil)
    }

    @IBAction func rightBtnTap(sender:AnyObject)->Void {
        _ = self.eventTransmissionBlock!(self,self.headerFooterData!,1,nil)
    }
}

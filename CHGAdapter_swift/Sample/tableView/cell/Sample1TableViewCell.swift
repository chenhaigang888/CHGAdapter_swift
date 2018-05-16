//
//  Sample1TableViewCell.swift
//  CHGAdapter_swift
//
//  Created by chen haiGang on 2018/5/16.
//  Copyright © 2018年 chen haiGang. All rights reserved.
//

import UIKit

class Sample1TableViewCell: CHGTableViewCell {
    
    @IBOutlet var btn:UIButton?
    
    @IBAction func btnTap(_ sender:AnyObject) {
        self.eventTransmissionBlock!(self,self.cellData!,1,{(data:AnyObject?)->Void in
            print("返回结果：\(data!)")
        })
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func cellForRow(atIndexPath indexPath: IndexPath, tableView: UITableView?, data: AnyObject?) {
        super .cellForRow(atIndexPath: indexPath, tableView: tableView, data: data)
        self.btn?.setTitle(data as? String, for: UIControlState.normal)
    }
    
}

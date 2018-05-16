//
//  Sample1TableViewCell.swift
//  CHGAdapter_swift
//
//  Created by chen haiGang on 2018/5/16.
//  Copyright © 2018年 chen haiGang. All rights reserved.
//

import UIKit

class Sample1TableViewCell: CHGTableViewCell {
    
    
    @IBOutlet var title:UILabel?
    @IBOutlet var switch_:UISwitch?
    
    @objc func switchValueChange(_ sender:AnyObject)->Void {
        ((self.tableView?.tableViewAdapter?.adapterData?.customData) as! NSMutableDictionary).setObject(self.switch_?.isOn ?? false, forKey: self.indexPath! as NSCopying)
        self.eventTransmissionBlock!(self,self.switch_?.isOn as AnyObject,1,{(data:AnyObject?)->Void in
            print("\(data!.boolValue ? "true":"false")")
        })
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.switch_?.addTarget(self, action:#selector(Sample1TableViewCell.switchValueChange), for: UIControlEvents.valueChanged)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func cellForRow(atIndexPath indexPath: IndexPath, tableView: UITableView?, data: AnyObject?) {
        super .cellForRow(atIndexPath: indexPath, tableView: tableView, data: data)
        self.switch_?.isOn = (((self.tableView?.tableViewAdapter?.adapterData?.customData) as! NSMutableDictionary) .object(forKey: self.indexPath ?? false) != nil)
        self.title?.text = data as? String;
    }
    
    
    
}

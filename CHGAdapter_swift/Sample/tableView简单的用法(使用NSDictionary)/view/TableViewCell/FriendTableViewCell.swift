//
//  FriendTableViewCell.swift
//  CHGAdapter_swift
//
//  Created by 陈 海刚 on 2018/8/18.
//  Copyright © 2018 chen haiGang. All rights reserved.
//

import UIKit

class FriendTableViewCell: CHGTableViewCell {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var sigin: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func cellForRow(atIndexPath indexPath: IndexPath, tableView: UITableView?, data: Any?,eventTransmissionBlock:CHGEventTransmissionBlock?) {
        super.cellForRow(atIndexPath: indexPath, tableView: tableView, data: data,eventTransmissionBlock: eventTransmissionBlock)
        if data is NSDictionary {
            let dic:NSDictionary = data as! NSDictionary
            self.icon.image = UIImage.init(named: dic["icon"] as! String)
            self.name.text = dic["name"] as? String
            self.sigin.text = dic["sigin"] as? String
        } else {
            let test:Test = data as! Test
            self.icon.image = UIImage.init(named: test.icon!)
            self.name.text = test.name
            self.sigin.text = test.sigin
        }
    }
    
}

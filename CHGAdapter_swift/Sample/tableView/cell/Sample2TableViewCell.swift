//
//  Sample2TableViewCell.swift
//  CHGAdapter_swift
//
//  Created by chen haiGang on 2018/5/16.
//  Copyright © 2018年 chen haiGang. All rights reserved.
//

import UIKit

class Sample2TableViewCell: CHGTableViewCell {
    
    var title:UILabel = UILabel()
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(self.title)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var frame: CGRect {
        didSet {
            super.frame = frame
            self.title.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        }
    }
    
    override func cellForRow(atIndexPath indexPath: IndexPath, tableView: UITableView?, data: AnyObject?) {
        super .cellForRow(atIndexPath: indexPath, tableView: tableView, data: data)
        self.title.text = data as? String
    }
    
}

//
//  FriendAdapter.swift
//  CHGAdapter_swift
//
//  Created by 陈 海刚 on 2018/8/18.
//  Copyright © 2018 chen haiGang. All rights reserved.
//

import UIKit

class FriendAdapter: CHGTableViewAdapter {

    //通过这个方法返回cell
    override func obtainCellNameWithCell(_ data: AnyObject, tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> NSString {
        return "FriendTableViewCell"
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func obtainHeaderNameWithHeader(_ data: AnyObject, tableView: UITableView, viewForHeaderInSection section: NSInteger) -> NSString {
        return "TVTitleDicHeaderFooterView"
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}

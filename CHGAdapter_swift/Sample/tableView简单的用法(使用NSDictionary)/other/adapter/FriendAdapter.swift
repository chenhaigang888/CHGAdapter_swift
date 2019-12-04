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
    override func obtainCellNameWithCell(_ data: Any, tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> String {
        return "FriendTableViewCell"
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func obtainHeaderNameWithHeader(_ data: Any, tableView: UITableView, viewForHeaderInSection section: NSInteger) -> String {
        return "TVTitleDicHeaderFooterView"
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}

//
//  Week.swift
//  CHGAdapter_swift
//
//  Created by DNAER5 on 2020/1/6.
//  Copyright © 2020 chen haiGang. All rights reserved.
//

import UIKit

enum Week {
    case Monday ,Tuesday ,Wednesday ,Thursday ,Friday ,Saturday ,Sunday
    
    func weekDesc() -> String {
        var desc = ""
        switch self {
        case .Monday:
            desc = "星期一"
            break
        case .Tuesday:
            desc = "星期二"
            break
        case .Wednesday:
            desc = "星期三"
            break
        case .Thursday:
            desc = "星期四"
            break
        case .Friday:
            desc = "星期五"
            break
        case .Saturday:
            desc = "星期六"
            break
        case .Sunday:
            desc = "星期日"
            break
        }
        return desc
    }
}

extension Week : CHGTableViewCellModelProtocol {
    func cellClass(_ tableView: UITableView, indexPath: IndexPath) -> AnyClass? {
        return WeekTableViewCell.self
    }
    
    func cellHeigh(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
}

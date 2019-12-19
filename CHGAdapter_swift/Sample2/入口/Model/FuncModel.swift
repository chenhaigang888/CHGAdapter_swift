//
//  FuncModel.swift
//  CHGAdapter_swift
//
//  Created by DNAER5 on 2019/12/17.
//  Copyright © 2019 chen haiGang. All rights reserved.
//

import UIKit


///// 功能列表的模型
//
//class FuncModel:NSObject, CHGTableViewCellModelProtocol {
//    var title:String?
//
//    init(title:String?) {
//        super.init()
//        self.title = title
//    }
//
//    func cellClassName(_ tableView: UITableView, indexPath: IndexPath) -> String {
//        return "FuncModelTableViewCell"
//    }
//
//    func cellHeigh(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat {
//        return 44
//    }
//}

struct FuncModel : CHGTableViewCellModelProtocol{
    var title:String

    func cellClassName(_ tableView: UITableView, indexPath: IndexPath) -> String {
        return "FuncModelTableViewCell"
    }

    func cellHeigh(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat {
        return 44
    }
}



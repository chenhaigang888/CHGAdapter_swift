//
//  FuncModel.swift
//  CHGAdapter_swift
//
//  Created by DNAER5 on 2019/12/17.
//  Copyright © 2019 chen haiGang. All rights reserved.
//

import UIKit

struct FuncModel : CHGTableViewCellModelProtocol{
    var title:String
    var _viewController:UIViewController
    
    var viewController:UIViewController {
        get {
            _viewController.title = title
            return _viewController
        }
        set {
            _viewController = newValue
            
        }
    }
    
    func cellClassName(_ tableView: UITableView, indexPath: IndexPath) -> String {
        return "FuncModelTableViewCell"
    }

    func cellHeigh(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat {
        return 44
    }
}



//
//  CHGSimpleTableViewAdapter.swift
//  CHGAdapter_swift
//
//  Created by chen haiGang on 2018/7/26.
//  Copyright © 2018年 chen haiGang. All rights reserved.
//

import UIKit

///cell的Model需要实现的协议
public protocol CHGTableViewCellModelProtocol {
    
    /// 返回类名或者identifier,如果已经使用tableView注册过cell则返回identifier，如果没有注册则在这里返回cell的类名，将使用此类名作为identifier header footer雷同
    ///
    /// - Parameters:
    ///   - tableView: 当前model所在的tableView
    ///   - indexPath: 当前model所在的indexPath
    /// - Returns: 返回类名或者identifier
    func cellClass(_ tableView:UITableView, indexPath:IndexPath) -> AnyClass?
    
    /// 返回当前cell的高度
    ///
    /// - Parameters:
    ///   - tableView: 当前model所在的tableView
    ///   - indexPath: 当前model所在的indexPath
    /// - Returns: cell、headerFooter的高度
    func cellHeigh(_ tableView: UITableView, indexPath:IndexPath) -> CGFloat
    
    /// 是否可以编辑
    /// - Parameters:
    ///   - tableView: tableView description
    ///   - indexPath: indexPath description
    func cellCanEdit(_ tableView: UITableView, indexPath: IndexPath) -> Bool
    
    
    /// 按钮文字
    /// - Parameters:
    ///   - tableView: tableView description
    ///   - indexPath: indexPath description
    func titleForDeleteConfirmationButton(_ tableView: UITableView, indexPath: IndexPath) -> String?
    
    func editingStyle(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell.EditingStyle
    
    func editActions(tableView: UITableView, indexPath:IndexPath) -> [UITableViewRowAction]?
    
    func shouldIndentWhileEditing(tableView: UITableView, indexPath:IndexPath) -> Bool
    
}


public extension CHGTableViewCellModelProtocol {
    /// 是否可以编辑
    /// - Parameters:
    ///   - tableView: tableView description
    ///   - indexPath: indexPath description
    func cellCanEdit(_ tableView: UITableView, indexPath: IndexPath) -> Bool {
        false
    }
    
    /// 按钮文字
    /// - Parameters:
    ///   - tableView: tableView description
    ///   - indexPath: indexPath description
    func titleForDeleteConfirmationButton(_ tableView: UITableView, indexPath: IndexPath) -> String? {
        nil
    }

    func editingStyle(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .none
    }
    
    func editActions(tableView: UITableView, indexPath:IndexPath) -> [UITableViewRowAction]? {
        nil
    }
    
    func shouldIndentWhileEditing(tableView: UITableView, indexPath:IndexPath) -> Bool {
        false
    }
}

///header footer的model需要实现的协议
public protocol CHGTableViewHeaderFooterModelProtocol {
    
    /// 绑定一个cell、headerFooter 类
    ///
    /// - Returns: 返回类名
    
    
    /// 绑定一个headerFooter 类
    ///
    /// - Parameters:
    ///   - tableView: 当前model所在的tableView
    ///   - section: section
    ///   - type: 表示当前model在header或者footer view中
    /// - Returns: 返回headerFooter类名或者identifier
    func headerFooterClass(_ tableView: UITableView, section: NSInteger,type:CHGAdapterViewType) -> AnyClass?
    
    /// 返回当前cell、headerFooter的高度
    ///
    /// - Returns: cell、headerFooter的高度
    
    
    /// 返回当前headerFooter的高度
    ///
    /// - Parameters:
    ///   - tableView: 当前model所在的tableView
    ///   - section: section
    ///   - type: 表示当前model在header或者footer view中
    /// - Returns: 返回header footer的高度
    func headerFooterHeigh(_ tableView: UITableView, section: NSInteger,type:CHGAdapterViewType) -> CGFloat
    
    /// 如果你的cell的数据是Model中的某一个字段（比如好友列表 外层Model是Group，Group中有一个字段friends为数组，你想使用Group中的friends字段的元素作为cell，则可以通过这个方法返回:\Group.friends）
    ///
    /// - Parameters:
    ///   - indexPath: 当前的位置
    ///   - tableView: 当前内容所在的tableView
    /// - Returns: 返回keyPath
    func subDataKeyPath(_ indexPath:IndexPath,inTableView tableView: UITableView) -> Any
}

public extension CHGTableViewHeaderFooterModelProtocol {
    
    func subDataKeyPath(_ indexPath:IndexPath,inTableView tableView: UITableView) -> Any {
        return ""
    }
}

/// 简单的adapter，此adapter为使用TableView进行页面布局而使用，使用此adapter 需要cellData实现CHGTableViewCellModelProtocol协议，headerData和footerData需要实现CHGTableViewHeaderFooterModelProtocol协议
open class CHGSimpleTableViewAdapter: CHGTableViewAdapter {
    
    override open func obtainCellClassWithCell(_ data: Any, tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> AnyClass? {
        if let tableViewCellModelProtocol = data as? CHGTableViewCellModelProtocol {
            return tableViewCellModelProtocol.cellClass(tableView,indexPath: indexPath)
        } else if let tableViewCellModelProtocol = (data as AnyObject) as? CHGTableViewCellModelProtocol {
            return tableViewCellModelProtocol.cellClass(tableView,indexPath: indexPath)
        }
        return super.obtainCellClassWithCell(data, tableView: tableView, cellForRowAtIndexPath: indexPath)
    }
    
    override open func obtainHeaderClassWithHeader(_ data: Any, tableView: UITableView, viewForHeaderInSection section: NSInteger) -> AnyClass? {
        if let tableViewHeaderFooterModelProtocol = data as? CHGTableViewHeaderFooterModelProtocol {
            return tableViewHeaderFooterModelProtocol.headerFooterClass(tableView, section: section, type: .HeaderType)
        } else if let tableViewHeaderFooterModelProtocol = (data as AnyObject) as? CHGTableViewHeaderFooterModelProtocol {
            return tableViewHeaderFooterModelProtocol.headerFooterClass(tableView, section: section, type: .HeaderType)
        }
        return super.obtainHeaderClassWithHeader(data, tableView: tableView, viewForHeaderInSection: section)
        
    }
    
    open override func subDataKeyPath(_ indexPath: IndexPath, targetView: UIScrollView) -> Any? {
        let data = self.adapterData.cellDatas![indexPath.section]
        if let tableViewHeaderFooterModelProtocol = data as? CHGTableViewHeaderFooterModelProtocol {
            let keyPath = tableViewHeaderFooterModelProtocol.subDataKeyPath(indexPath,inTableView: targetView as! UITableView)
            if keyPath is NSString || keyPath is String {
                let keyPathStr:NSString = keyPath as! NSString
                if keyPathStr.length == 0 {
                    return super.subDataKeyPath(indexPath, targetView: targetView)
                } else {
                    return keyPathStr
                }
            }
            return keyPath
        } else if let tableViewHeaderFooterModelProtocol = (data as AnyObject) as? CHGTableViewHeaderFooterModelProtocol {
            let keyPath = tableViewHeaderFooterModelProtocol.subDataKeyPath(indexPath,inTableView: targetView as! UITableView)
            if keyPath is NSString || keyPath is String {
                let keyPathStr:NSString = keyPath as! NSString
                if keyPathStr.length == 0 {
                    return super.subDataKeyPath(indexPath, targetView: targetView)
                } else {
                    return keyPathStr
                }
            }
            return keyPath
        }
        return super.subDataKeyPath(indexPath, targetView: targetView)
    }
    
    override open func obtainFooterClassWithFooter(_ data: Any, tableView: UITableView, viewForFooterInSection section: NSInteger) -> AnyClass? {
        if let tableViewHeaderFooterModelProtocol = data as? CHGTableViewHeaderFooterModelProtocol {
            return tableViewHeaderFooterModelProtocol.headerFooterClass(tableView, section: section, type: .FooterType)
        } else if let tableViewHeaderFooterModelProtocol = (data as AnyObject) as? CHGTableViewHeaderFooterModelProtocol {
            return tableViewHeaderFooterModelProtocol.headerFooterClass(tableView, section: section, type: .FooterType)
        }
        return super.obtainFooterClassWithFooter(data, tableView: tableView, viewForFooterInSection: section)
        
    }
    
    override open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let data = cellDataWithIndexPath(indexPath,tableView: tableView)
        if let tableViewCellModelProtocol = data as? CHGTableViewCellModelProtocol {
            return tableViewCellModelProtocol.cellHeigh(tableView, indexPath: indexPath)
        } else if let tableViewCellModelProtocol = (data as AnyObject) as? CHGTableViewCellModelProtocol {
            return tableViewCellModelProtocol.cellHeigh(tableView, indexPath: indexPath)
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
    override open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let data = headerFooterDataWithType(type: .HeaderType, section: section)
        if let tableViewHeaderFooterModelProtocol = data as? CHGTableViewHeaderFooterModelProtocol {
            return tableViewHeaderFooterModelProtocol.headerFooterHeigh(tableView, section: section, type: .HeaderType)
        } else if let tableViewHeaderFooterModelProtocol = (data as AnyObject) as? CHGTableViewHeaderFooterModelProtocol {
            return tableViewHeaderFooterModelProtocol.headerFooterHeigh(tableView, section: section, type: .HeaderType)
        }
        return super.tableView(tableView, heightForHeaderInSection: section)
    }
    
    override open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let data = headerFooterDataWithType(type: .FooterType, section: section)
        if let tableViewHeaderFooterModelProtocol = data as? CHGTableViewHeaderFooterModelProtocol {
            return tableViewHeaderFooterModelProtocol.headerFooterHeigh(tableView, section: section, type: .FooterType)
        } else if let tableViewHeaderFooterModelProtocol = (data as AnyObject) as? CHGTableViewHeaderFooterModelProtocol {
            return tableViewHeaderFooterModelProtocol.headerFooterHeigh(tableView, section: section, type: .FooterType)
        }
        return super.tableView(tableView, heightForFooterInSection: section)
    }
    
    override open func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        let data = cellDataWithIndexPath(indexPath,tableView: tableView)
        if let tableViewCellModelProtocol = data as? CHGTableViewCellModelProtocol {
            return tableViewCellModelProtocol.cellCanEdit(tableView, indexPath: indexPath)
        } else if let tableViewCellModelProtocol = (data as AnyObject) as? CHGTableViewCellModelProtocol {
            return tableViewCellModelProtocol.cellCanEdit(tableView, indexPath: indexPath)
        }
        return super.tableView(tableView, canEditRowAt: indexPath)
    }
    
    open override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        let data = cellDataWithIndexPath(indexPath,tableView: tableView)
        if let tableViewCellModelProtocol = data as? CHGTableViewCellModelProtocol {
            return tableViewCellModelProtocol.editingStyle(tableView, indexPath: indexPath)
        } else if let tableViewCellModelProtocol = (data as AnyObject) as? CHGTableViewCellModelProtocol {
            return tableViewCellModelProtocol.editingStyle(tableView, indexPath: indexPath)
        }
        return super.tableView(tableView, editingStyleForRowAt: indexPath)
    }
    
    override open func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        let data = cellDataWithIndexPath(indexPath,tableView: tableView)
        if let tableViewCellModelProtocol = data as? CHGTableViewCellModelProtocol {
            return tableViewCellModelProtocol.titleForDeleteConfirmationButton(tableView, indexPath: indexPath)
        } else if let tableViewCellModelProtocol = (data as AnyObject) as? CHGTableViewCellModelProtocol {
            return tableViewCellModelProtocol.titleForDeleteConfirmationButton(tableView, indexPath: indexPath)
        }
        return super.tableView(tableView, titleForDeleteConfirmationButtonForRowAt: indexPath)
    }
    
    open override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let data = cellDataWithIndexPath(indexPath,tableView: tableView)
        if let tableViewCellModelProtocol = data as? CHGTableViewCellModelProtocol {
            return tableViewCellModelProtocol.editActions(tableView: tableView, indexPath: indexPath)
        } else if let tableViewCellModelProtocol = (data as AnyObject) as? CHGTableViewCellModelProtocol {
            return tableViewCellModelProtocol.editActions(tableView: tableView, indexPath: indexPath)
        }
        return super.tableView(tableView, editActionsForRowAt: indexPath)
    }
    
    open override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        let data = cellDataWithIndexPath(indexPath,tableView: tableView)
        if let tableViewCellModelProtocol = data as? CHGTableViewCellModelProtocol {
            return tableViewCellModelProtocol.shouldIndentWhileEditing(tableView: tableView, indexPath: indexPath)
        } else if let tableViewCellModelProtocol = (data as AnyObject) as? CHGTableViewCellModelProtocol {
            return tableViewCellModelProtocol.shouldIndentWhileEditing(tableView: tableView, indexPath: indexPath)
        }
        return super.tableView(tableView, shouldIndentWhileEditingRowAt: indexPath)
    }

}

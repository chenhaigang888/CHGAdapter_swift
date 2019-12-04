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
    func cellClassName(_ tableView:UITableView, indexPath:IndexPath) -> String
    
    /// 返回当前cell的高度
    ///
    /// - Parameters:
    ///   - tableView: 当前model所在的tableView
    ///   - indexPath: 当前model所在的indexPath
    /// - Returns: cell、headerFooter的高度
    func cellHeigh(_ tableView:UITableView, indexPath:IndexPath) -> CGFloat
    
    
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
    func headerFooterClass(_ tableView: UITableView, section: NSInteger,type:CHGTableViewHeaderFooterViewType) -> String
    
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
    func headerFooterHeigh(_ tableView: UITableView, section: NSInteger,type:CHGTableViewHeaderFooterViewType) -> CGFloat
    
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
    
    override open func obtainCellNameWithCell(_ data: Any, tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> String {
        guard let tableViewCellModelProtocol:CHGTableViewCellModelProtocol = data as? CHGTableViewCellModelProtocol else {
            return super.obtainCellNameWithCell(data, tableView: tableView, cellForRowAtIndexPath: indexPath)
        }
        return tableViewCellModelProtocol.cellClassName(tableView,indexPath: indexPath)
    }
    
    override open func obtainHeaderNameWithHeader(_ data: Any, tableView: UITableView, viewForHeaderInSection section: NSInteger) -> String {
        guard let tableViewHeaderFooterModelProtocol:CHGTableViewHeaderFooterModelProtocol = data as? CHGTableViewHeaderFooterModelProtocol else {
            return super.obtainHeaderNameWithHeader(data, tableView: tableView, viewForHeaderInSection: section)
        }
        return tableViewHeaderFooterModelProtocol.headerFooterClass(tableView, section: section, type: .HeaderType)
    }
    
    open override func subDataKeyPath(_ indexPath: IndexPath, targetView: UIScrollView) -> Any? {
        guard let tableViewHeaderFooterModelProtocol:CHGTableViewHeaderFooterModelProtocol = self.adapterData.cellDatas![indexPath.section] as? CHGTableViewHeaderFooterModelProtocol else {
            return super.subDataKeyPath(indexPath, targetView: targetView)
        }
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
    
    override open func obtainFooterNameWithFooter(_ data: Any, tableView: UITableView, viewForFooterInSection section: NSInteger) -> String {
        guard let tableViewHeaderFooterModelProtocol:CHGTableViewHeaderFooterModelProtocol = data as? CHGTableViewHeaderFooterModelProtocol else {
            return super.obtainFooterNameWithFooter(data, tableView: tableView, viewForFooterInSection: section)
        }
        return tableViewHeaderFooterModelProtocol.headerFooterClass(tableView, section: section, type: .FooterType)
    }
    
    override open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let tableViewCellModelProtocol:CHGTableViewCellModelProtocol = cellDataWithIndexPath(indexPath,tableView: tableView) as? CHGTableViewCellModelProtocol else {
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
        return tableViewCellModelProtocol.cellHeigh(tableView, indexPath: indexPath)
    }
    
    override open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let tableViewHeaderFooterModelProtocol:CHGTableViewHeaderFooterModelProtocol = headerFooterDataWithType(type: .HeaderType, section: section) as? CHGTableViewHeaderFooterModelProtocol else {
            return super.tableView(tableView, heightForHeaderInSection: section)
        }
        return tableViewHeaderFooterModelProtocol.headerFooterHeigh(tableView, section: section, type: .HeaderType)
    }
    
    override open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard let tableViewHeaderFooterModelProtocol:CHGTableViewHeaderFooterModelProtocol = headerFooterDataWithType(type: .FooterType, section: section) as? CHGTableViewHeaderFooterModelProtocol else {
            return super.tableView(tableView, heightForFooterInSection: section)
        }
        return tableViewHeaderFooterModelProtocol.headerFooterHeigh(tableView, section: section, type: .FooterType)
    }
}

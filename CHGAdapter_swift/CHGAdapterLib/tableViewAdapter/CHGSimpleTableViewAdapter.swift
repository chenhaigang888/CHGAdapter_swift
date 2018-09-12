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
    
    func subDataKeyPath(_ indexPath:IndexPath,inTableView tableView: UITableView) -> Any
}

public extension CHGTableViewHeaderFooterModelProtocol {
    
    func subDataKeyPath(_ indexPath:IndexPath,inTableView tableView: UITableView) -> Any {
        return ""
    }
}

/// 简单的adapter，此adapter为使用TableView进行页面布局而使用，使用此adapter 需要cellData实现CHGTableViewCellModelProtocol协议，headerData和footerData需要实现CHGTableViewHeaderFooterModelProtocol协议
open class CHGSimpleTableViewAdapter: CHGTableViewAdapter {
    
    override open func obtainCellNameWithCell(_ data: AnyObject, tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> NSString {
        let tableViewCellModelProtocol:CHGTableViewCellModelProtocol = data as! CHGTableViewCellModelProtocol
        return tableViewCellModelProtocol.cellClassName(tableView,indexPath: indexPath) as NSString
    }
    
    override open func obtainHeaderNameWithHeader(_ data: AnyObject, tableView: UITableView, viewForHeaderInSection section: NSInteger) -> NSString {
        let tableViewHeaderFooterModelProtocol:CHGTableViewHeaderFooterModelProtocol = data as! CHGTableViewHeaderFooterModelProtocol
        return tableViewHeaderFooterModelProtocol.headerFooterClass(tableView, section: section, type: .HeaderType) as NSString
    }
    
    open override func subDataKeyPath(_ indexPath: IndexPath, inTableView tableView: UITableView) -> Any? {
        let sectionDatas = self.adapterData.cellDatas![indexPath.section]
        if sectionDatas is NSArray {
            return ""
        }
        let tableViewHeaderFooterModelProtocol:CHGTableViewHeaderFooterModelProtocol = sectionDatas as! CHGTableViewHeaderFooterModelProtocol
        let keyPath = tableViewHeaderFooterModelProtocol.subDataKeyPath(indexPath,inTableView: tableView)
        return keyPath
    }
    
    override open func obtainFooterNameWithFooter(_ data: AnyObject, tableView: UITableView, viewForFooterInSection section: NSInteger) -> NSString {
        let tableViewHeaderFooterModelProtocol:CHGTableViewHeaderFooterModelProtocol = data as! CHGTableViewHeaderFooterModelProtocol
        return tableViewHeaderFooterModelProtocol.headerFooterClass(tableView, section: section, type: .FooterType) as NSString
    }
    
    override open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tableViewCellModelProtocol:CHGTableViewCellModelProtocol = cellDataWithIndexPath(indexPath,tableView: tableView) as! CHGTableViewCellModelProtocol
        return tableViewCellModelProtocol.cellHeigh(tableView, indexPath: indexPath)
    }
    
    override open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let headerData = headerFooterDataWithType(type: .HeaderType, section: section)
        if headerData != nil {
            let tableViewHeaderFooterModelProtocol:CHGTableViewHeaderFooterModelProtocol = headerFooterDataWithType(type: .HeaderType, section: section) as! CHGTableViewHeaderFooterModelProtocol
            return tableViewHeaderFooterModelProtocol.headerFooterHeigh(tableView, section: section, type: .HeaderType)
        }
        return super.tableView(tableView, heightForHeaderInSection: section)
    }
    
    override open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let headerData = headerFooterDataWithType(type: .FooterType, section: section)
        if headerData != nil {
            let tableViewHeaderFooterModelProtocol:CHGTableViewHeaderFooterModelProtocol = headerFooterDataWithType(type: .FooterType, section: section) as! CHGTableViewHeaderFooterModelProtocol
            return tableViewHeaderFooterModelProtocol.headerFooterHeigh(tableView, section: section, type: .FooterType)
        }
        return super.tableView(tableView, heightForFooterInSection: section)
    }
}

//
//  CHGSimpleTableViewAdapter.swift
//  CHGAdapter_swift
//
//  Created by chen haiGang on 2018/7/26.
//  Copyright © 2018年 chen haiGang. All rights reserved.
//

import UIKit

///cell的Model需要实现的协议
protocol CHGTableViewCellModelProtocol {
    
    /// 绑定一个cell、headerFooter 类
    ///
    /// - Returns: 返回类名
    func getCellClass() -> String
    
    /// 返回当前cell、headerFooter的高度
    ///
    /// - Returns: cell、headerFooter的高度
    func getCellHeigh() -> CGFloat
}

///header footer的model需要实现的协议
protocol CHGTableViewHeaderFooterModelProtocol {
    
    /// 绑定一个cell、headerFooter 类
    ///
    /// - Returns: 返回类名
    func getHeaderFooterClass() -> String
    
    /// 返回当前cell、headerFooter的高度
    ///
    /// - Returns: cell、headerFooter的高度
    func getHeaderFooterHeigh() -> CGFloat
}

/// 简单的adapter，此adapter为使用TableView进行页面布局而使用，使用此adapter 需要cellData实现CHGTableViewCellModelProtocol协议，headerData和footerData需要实现CHGTableViewHeaderFooterModelProtocol协议
class CHGSimpleTableViewAdapter: CHGTableViewAdapter {
    
    override open func obtainCellNameWithCell(_ data: AnyObject, tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> NSString {
        let tableViewCellModelProtocol:CHGTableViewCellModelProtocol = data as! CHGTableViewCellModelProtocol
        return tableViewCellModelProtocol.getCellClass() as NSString
    }
    
    override open func obtainHeaderNameWithHeader(_ data: AnyObject, tableView: UITableView, viewForHeaderInSection section: NSInteger) -> NSString {
        let tableViewHeaderFooterModelProtocol:CHGTableViewHeaderFooterModelProtocol = data as! CHGTableViewHeaderFooterModelProtocol
        return tableViewHeaderFooterModelProtocol.getHeaderFooterClass() as NSString
    }
    
    override open func obtainFooterNameWithFooter(_ data: AnyObject, tableView: UITableView, viewForFooterInSection section: NSInteger) -> NSString {
        let tableViewHeaderFooterModelProtocol:CHGTableViewHeaderFooterModelProtocol = data as! CHGTableViewHeaderFooterModelProtocol
        return tableViewHeaderFooterModelProtocol.getHeaderFooterClass() as NSString
    }
    
    override open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tableViewCellModelProtocol:CHGTableViewCellModelProtocol = cellDataWithIndexPath(indexPath) as! CHGTableViewCellModelProtocol
        return tableViewCellModelProtocol.getCellHeigh()
    }
    
    override open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let headerData = headerFooterDataWithType(type: .HeaderType, section: section)
        if headerData != nil {
            let tableViewHeaderFooterModelProtocol:CHGTableViewHeaderFooterModelProtocol = headerFooterDataWithType(type: .HeaderType, section: section) as! CHGTableViewHeaderFooterModelProtocol
            return tableViewHeaderFooterModelProtocol.getHeaderFooterHeigh()
        }
        return super.tableView(tableView, heightForHeaderInSection: section)
    }
    
    override open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let headerData = headerFooterDataWithType(type: .FooterType, section: section)
        if headerData != nil {
            let tableViewHeaderFooterModelProtocol:CHGTableViewHeaderFooterModelProtocol = headerFooterDataWithType(type: .FooterType, section: section) as! CHGTableViewHeaderFooterModelProtocol
            return tableViewHeaderFooterModelProtocol.getHeaderFooterHeigh()
        }
        return super.tableView(tableView, heightForFooterInSection: section)
    }
}

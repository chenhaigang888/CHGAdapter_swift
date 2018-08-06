//
//  CHGTableViewHeaderFooterView.swift
//  CHGAdapter_swift
//
//  Created by chen haiGang on 2018/5/16.
//  Copyright © 2018年 chen haiGang. All rights reserved.
//

import UIKit

public enum CHGTableViewHeaderFooterViewType {
    case HeaderType
    case FooterType
}

open class CHGTableViewHeaderFooterView: UITableViewHeaderFooterView {
    
    public var eventTransmissionBlock:CHGEventTransmissionBlock?
    public var section:NSInteger?
    public var tableView:UITableView?
    public var headerFooterData:AnyObject?
    public var type:CHGTableViewHeaderFooterViewType?
    
    open func headerFooter(headerFooterForSection section:NSInteger,tableView:UITableView,data:AnyObject,type:CHGTableViewHeaderFooterViewType) -> Void {
        self.section = section
        self.tableView = tableView
        self.headerFooterData = data
        self.type = type
    }
    
    open func controller()->UIViewController? {
        return self.tableView?.tableViewAdapter?.controller
    }
    
    open func adapterTag()->NSInteger? {
        return self.tableView?.tableViewAdapter?.tag
    }
    
    open func customData()->AnyObject? {
        return self.tableView?.tableViewAdapter?.adapterData.customData
    }
    
    /**
     将要复用
     
     @param identifier identifier
     */
    open func willReuseWithIdentifier(identifier:NSString)->Void {
        
    }
    
    /**
     headerFooterView将要显示
     */
    open func headerFooterViewWillAppearWithType(type:CHGTableViewHeaderFooterViewType)->Void {
        
    }
    
    /**
     headerFooterView已经消失
     */
    open func headerFooterViewDidDisAppearWithType(type:CHGTableViewHeaderFooterViewType)->Void {
        
    }
}

//
//  CHGTableViewCell.swift
//  CHGAdapter_swift
//
//  Created by chen haiGang on 2018/5/16.
//  Copyright © 2018年 chen haiGang. All rights reserved.
//

import UIKit

open class CHGTableViewCell: UITableViewCell {
    
    public var eventTransmissionBlock:CHGEventTransmissionBlock?
    public var indexPath:IndexPath?
    public var tableView:UITableView?
    public var cellData:Any?
    
    open func cellForRow(atIndexPath indexPath:IndexPath,tableView:UITableView?,data:Any?) -> Void {
        self.indexPath = indexPath
        self.tableView = tableView;
        self.cellData = data;
    }
    
    open func adapterTag()->NSInteger? {
        return self.tableView?.tableViewAdapter?.tag
    }
    
    open func customData()->Any? {
        return self.tableView?.tableViewAdapter?.adapterData.customData
    }
    
    open func controller()->UIViewController? {
        return self.tableView?.tableViewAdapter?.controller
    }
    
    /**
     将被复用
     
     @param identifier identifier
     */
    open func willReuseWithIdentifier(identifier:NSString)->Void{
        
    }
    
    /**
     将被复用
     
     @param identifier identifier
     @param indexPath indexPath
     */
    open func willReuseWithIdentifier(identifier:NSString, indexPath:NSIndexPath)->Void{
        
    }
    /**
     cell将要显示
     */
    open func cellWillAppear()->Void {
        
    }
    
    /**
     cell已经消失
     */
    open func cellDidDisappear()->Void {
        
    }
}


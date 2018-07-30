//
//  CHGTableView+CHGTableViewAdapter.swift
//  CHGAdapter_swift
//
//  Created by chen haiGang on 2018/5/16.
//  Copyright © 2018年 chen haiGang. All rights reserved.
//

import Foundation
import UIKit
//import DZNEmptyData
import EmptyDataSet_Swift

private var tableViewAdapterKey: Void?
private var eventTransmissionBlockKey: Void?
private var tableViewDidSelectRowBlockKey: Void?
private var tableViewEmptyDataShowKey: Void?

extension UITableView {
    
    open var tableViewAdapter:CHGTableViewAdapter? {
        get {
            let adapter = objc_getAssociatedObject(self, &tableViewAdapterKey) as? CHGTableViewAdapter
            if adapter == nil {
                self.tableViewAdapter = CHGSimpleTableViewAdapter.init()
                return self.tableViewAdapter
            }
            return adapter
        }
        set(newValue) {
            objc_setAssociatedObject(self, &tableViewAdapterKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            self.delegate = newValue
            self.dataSource = newValue
        }
    }
    
    open var eventTransmissionBlock:CHGEventTransmissionBlock? {
        get {
            return objc_getAssociatedObject(self, &eventTransmissionBlockKey) as? CHGEventTransmissionBlock
        }
        set(newValue) {
            objc_setAssociatedObject(self, &eventTransmissionBlockKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    open func setEventTransmissionBlock(eventTransmissionBlock:@escaping CHGEventTransmissionBlock) -> Void {
        self.eventTransmissionBlock = eventTransmissionBlock
    }
    
    open var tableViewDidSelectRowBlock:CHGTableViewDidSelectRowBlock? {
        get {
            return objc_getAssociatedObject(self, &tableViewDidSelectRowBlockKey) as? CHGTableViewDidSelectRowBlock
        }
        set(newValue) {
            objc_setAssociatedObject(self, &tableViewDidSelectRowBlockKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
    open func setTableViewDidSelectRowBlock(tableViewDidSelectRowBlock:@escaping CHGTableViewDidSelectRowBlock) -> Void {
        self.tableViewDidSelectRowBlock = tableViewDidSelectRowBlock
    }
    
    open var tableViewEmptyDataShow:CHGTableViewEmptyDataShow? {
        get {
            return objc_getAssociatedObject(self, &tableViewEmptyDataShowKey) as? CHGTableViewEmptyDataShow
        }
        set(newValue) {
            objc_setAssociatedObject(self, &tableViewEmptyDataShowKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            self.setEmpty(newValue!, delegate: newValue!)
        }
    }
    
    open func setEmptyDataShow(_ title:NSString?,imageName:NSString?) -> Void {
        let tableViewEmptyDataShow = CHGTableViewEmptyDataShow.init()
        tableViewEmptyDataShow.imageName = imageName!
        tableViewEmptyDataShow.title = title!
        tableViewEmptyDataShow.emptyDataSetShouldAllowScroll = true
        self.tableViewEmptyDataShow = tableViewEmptyDataShow;
    }
    
    private func setEmpty(_ dataSource:EmptyDataSetSource,delegate:EmptyDataSetDelegate) ->Void {
        self.emptyDataSetSource = dataSource
        self.emptyDataSetDelegate = delegate
    }
    
    open func hiddHeadView() -> Void {
        self.tableHeaderView = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0.0001))
    }
    
    open func hiddenFooterView() -> Void {
        self.tableFooterView = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0.0001))
    }
    
    open func autoHeight() -> Void {
        self.estimatedRowHeight = 44;
        self.rowHeight = UITableViewAutomaticDimension;
        self.tableViewAdapter?.cellHeight = -1;
    }
    
}

extension UITableView {
    var adapterData: CHGTableViewAdapterData {
        get {
            return (self.tableViewAdapter?.adapterData)!
        }
        set {
            self.tableViewAdapter?.adapterData = newValue
        }
    }
    
}

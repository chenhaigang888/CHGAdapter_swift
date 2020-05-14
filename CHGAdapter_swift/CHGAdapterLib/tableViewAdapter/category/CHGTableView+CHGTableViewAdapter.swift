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
private var scrollViewDelegatesKey:Void?

extension UITableView {
    
    open var tableViewAdapter:CHGTableViewAdapter? {
        get {
            guard let adapter:CHGTableViewAdapter = objc_getAssociatedObject(self, &tableViewAdapterKey) as? CHGTableViewAdapter else {
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
    
    open var scrollViewDelegates:[CHGScrollViewDelegate]? {
        get {
            let  scrollViewDelegates = objc_getAssociatedObject(self, &scrollViewDelegatesKey)
            guard scrollViewDelegates != nil else {
                self.scrollViewDelegates = [CHGScrollViewDelegate]()
                return self.scrollViewDelegates
            }
            return scrollViewDelegates as? [CHGScrollViewDelegate]
        }
        set(newValue) {
            objc_setAssociatedObject(self, &scrollViewDelegatesKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    open func add(scrollViewDelegate:CHGScrollViewDelegate) -> Void {
        let contain = self.scrollViewDelegates?.contains(where: { (item) -> Bool in
            return item as AnyObject === scrollViewDelegate as AnyObject
        }) ?? false
        if contain {
           return
        }
        self.scrollViewDelegates?.append(scrollViewDelegate)
    }
    
    open func remove(scrollViewDelegate:CHGScrollViewDelegate) -> Void {
        guard let scrollViewDelegates:[CHGScrollViewDelegate] = self.scrollViewDelegates else { return }
        for i in 0..<scrollViewDelegates.count {
            if self.scrollViewDelegates?[i] as AnyObject? === scrollViewDelegate as AnyObject {
                self.scrollViewDelegates?.remove(at: i)
                return
            }
        }
    }
    
    open var eventTransmissionBlock:CHGEventTransmissionBlock? {
        get {
            return objc_getAssociatedObject(self, &eventTransmissionBlockKey) as? CHGEventTransmissionBlock
        }
        set(newValue) {
            objc_setAssociatedObject(self, &eventTransmissionBlockKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
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
        self.rowHeight = UITableView.automaticDimension;
        self.tableViewAdapter?.cellHeight = -1;
    }
    
}

// MARK: - 增加快速使用的API
extension UITableView {
    open var adapterData: CHGTableViewAdapterData {
        get {
            return (self.tableViewAdapter?.adapterData)!
        }
        set {
            self.tableViewAdapter?.adapterData = newValue
        }
    }
    
    open var cellDatas: [Any]? {
        get {
            return self.tableViewAdapter?.adapterData.cellDatas
        }
        set {
            self.tableViewAdapter?.adapterData.cellDatas = newValue
        }
    }
    
    open var footerDatas: [Any]? {
        get {
            return self.tableViewAdapter?.adapterData.footerDatas
        }
        set {
            self.tableViewAdapter?.adapterData.footerDatas = newValue
        }
    }
    
    open var headerDatas: [Any]? {
        get {
            return self.tableViewAdapter?.adapterData.headerDatas
        }
        set {
            self.tableViewAdapter?.adapterData.headerDatas = newValue
        }
    }
    
    open var indexDatas: [String]? {
        get {
            return self.tableViewAdapter?.adapterData.indexDatas
        }
        set {
            self.tableViewAdapter?.adapterData.indexDatas = newValue
        }
    }
    
    open var customData: Any? {
        get {
            return self.tableViewAdapter?.adapterData.customData
        }
        set {
            self.tableViewAdapter?.adapterData.customData = newValue
        }
    }
}

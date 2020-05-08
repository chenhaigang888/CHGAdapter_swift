//
//  CHGTableViewAdapter.swift
//  CHGAdapter_swift
//
//  Created by chen haiGang on 2018/5/16.
//  Copyright © 2018年 chen haiGang. All rights reserved.
//

import UIKit

/// 回调
public typealias CHGCallBack = (_ data:Any?) -> Any?

/// 事件传输block target.
/// - Parameters:
///   - target: 当前事件发生的场所（一般是cell、header、footer、adapter中）
///   - params: 事件发生的场所传递出来的参数
///   - tag: 区分事件发生的场所中的多个事件
///   - callBack: 当当前类中处理完事件后异步通知事件所发生的场所
/// - Returns: 当当前类中处理完事件后同步步通知事件所发生的场所
public typealias CHGEventTransmissionBlock = (_ target:Any?,_ params:Any?,_ tag:NSInteger,_ callBack:CHGCallBack?) -> Any?

/// tableViewDidSelectRow 回调
public typealias CHGTableViewDidSelectRowBlock = (_ tableView:UITableView,_ indexPath:IndexPath,_ itemData:Any)->Void

public protocol CHGTableViewAdapterProtocol:UITableViewDelegate,UITableViewDataSource, CHGSubDataOfKeyPathDelegate{
    
    func obtainCellClassWithCell(_ data:Any ,tableView:UITableView, cellForRowAtIndexPath indexPath:IndexPath) -> AnyClass?
    
    func obtainHeaderClassWithHeader(_ data:Any,tableView:UITableView, viewForHeaderInSection section:NSInteger) -> AnyClass?
    
    func obtainFooterClassWithFooter(_ data:Any,tableView:UITableView, viewForFooterInSection section:NSInteger) -> AnyClass?
}

open class CHGTableViewAdapter: NSObject,CHGTableViewAdapterProtocol {
    
    open var cellName:AnyClass?
    open var headerName:AnyClass?
    open var footerName:AnyClass?
    
    /// 如果cell、headerView、footerView的高度都统一可以通过直接设置以下参数进行设置
    open var cellHeight:CGFloat = 44
    open var headerHeight:CGFloat = 0.01
    open var footerHeight:CGFloat = 0.01
    
    open var adapterData:CHGTableViewAdapterData = CHGTableViewAdapterData.init()
    open var keyPathOfSubData:Any?
    open var tableViewDeselectRowAtIndexPathAnimation:Bool = true
    open var tag:NSInteger = 0
    weak open var controller:UIViewController?
    
    
    open func obtainCellClassWithCell(_ data: Any, tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> AnyClass? {
        return self.cellName!;
    }
    
    open func obtainHeaderClassWithHeader(_ data: Any, tableView: UITableView, viewForHeaderInSection section: NSInteger) -> AnyClass? {
        return self.headerName!;
    }
    
    open func obtainFooterClassWithFooter(_ data: Any, tableView: UITableView, viewForFooterInSection section: NSInteger) -> AnyClass? {
        return self.footerName!;
    }
    
    open func subDataKeyPath(_ indexPath: IndexPath, targetView: UIScrollView) -> Any? {
        return self.keyPathOfSubData
    }
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.cellHeight
    }
    
    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.headerHeight
    }
    
    open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return self.footerHeight
    }
    
    open func numberOfSections(in tableView: UITableView) -> Int {
        let cellDatas = self.adapterData.cellDatas
        if cellDatas == nil || cellDatas?.count == 0 {
            return 0
        }
        return (cellDatas?.count)!
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let cellDatas = self.adapterData.cellDatas
        if cellDatas?.count == 0 {
            return 0;
        }
        let subDataKeyPathTemp = self.subDataKeyPath(IndexPath.init(row: 0, section: section), targetView: tableView)
        if (subDataKeyPathTemp != nil && (!(cellDatas![section] is NSArray))) {
            if subDataKeyPathTemp is String || subDataKeyPathTemp is NSString {
                if (subDataKeyPathTemp as? NSString)?.length != 0 {
                    return ((cellDatas![section] as AnyObject).value(forKey: subDataKeyPathTemp! as! String) as! NSArray).count
                }
            } else {
                return (cellDatas![section][keyPath:subDataKeyPathTemp as! AnyKeyPath] as! NSArray).count
            }
        }
        let cellData = cellDatas![section]
        if cellData is NSArray {
            return (cellData as AnyObject).count
        } else {
            return 1
        }
    }
    
    open func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return self.adapterData.indexDatas
    }
    
    open func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return UILocalizedIndexedCollation.current().section(forSectionIndexTitle: index)
    }
    
    open func cellDataWithIndexPath(_ indexPath:IndexPath,tableView: UITableView) -> Any? {
        if self.adapterData.cellDatas?.count == 0 {
            return nil
        }
        let sectionData = self.adapterData.cellDatas![indexPath.section]
        let subDataKeyPathTemp = self.subDataKeyPath(indexPath,targetView: tableView)
        if subDataKeyPathTemp != nil && !(sectionData is NSArray) {
            var tempArray:NSArray = []
            if subDataKeyPathTemp is String || subDataKeyPathTemp is NSString {
                if (subDataKeyPathTemp as? NSString)?.length != 0 {
                    tempArray = (sectionData as AnyObject).value(forKey: subDataKeyPathTemp as! String) as! NSArray
                }
            } else {
                tempArray = sectionData[keyPath:subDataKeyPathTemp as! AnyKeyPath] as! NSArray
            }
            return tempArray.count == 0 ? sectionData : tempArray[indexPath.row]
        } else {
            return sectionData is NSArray ? (sectionData as! NSArray)[indexPath.row] : sectionData
        }
    }
    
    
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData = self.cellDataWithIndexPath(indexPath,tableView: tableView)
        guard let cellClass = self.obtainCellClassWithCell(cellData!, tableView: tableView, cellForRowAtIndexPath: indexPath) else { return UITableViewCell() }
        let classAllName = NSStringFromClass(cellClass)
        var cell = tableView.dequeueReusableCell(withIdentifier: classAllName)
        if cell == nil {
            if Utils.fileIsExit(moduleName: Utils.getModuleName(anyClass: cellClass), fileName: Utils.getShortClassName(anyClass: cellClass)) {
                tableView.register(UINib (nibName:Utils.getShortClassName(anyClass: cellClass),
                                          bundle: Utils.getBundle(anyClass: cellClass)),
                                   forCellReuseIdentifier: classAllName)
            } else {
                tableView.register(cellClass, forCellReuseIdentifier: classAllName)
            }
            cell = tableView.dequeueReusableCell(withIdentifier: classAllName, for: indexPath)
        }
        let cell_:CHGTableViewCell = cell as! CHGTableViewCell
        //        cell_.eventTransmissionBlock = tableView.eventTransmissionBlock
        //        cell_.cellForRow(atIndexPath: indexPath, tableView: tableView, data: cellData,eventTransmissionBlock: tableView.eventTransmissionBlock)
        cell_.cellForRowAt(indexPath: indexPath, targetView: tableView, model: cellData!, eventTransmissionBlock: tableView.eventTransmissionBlock)
        return cell_
    }
    
    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.tableview(tableView, tableViewHeaderFooterViewType: CHGAdapterViewType.HeaderType, viewForHeaderInSection: section)
    }
    
    open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return self.tableview(tableView, tableViewHeaderFooterViewType: CHGAdapterViewType.FooterType, viewForHeaderInSection: section)
    }
    
    open func headerFooterDataWithType(type:CHGAdapterViewType,section:NSInteger) -> Any? {
        let headerFooterDatas:[Any]? =
            type == CHGAdapterViewType.HeaderType
                ?
                    self.adapterData.headerDatas
                :
                self.adapterData.footerDatas
        if headerFooterDatas != nil && headerFooterDatas?.count != 0 {
            if section >= (headerFooterDatas?.count)! {
                return nil
            }
            return headerFooterDatas?[section]
        }
        return nil
    }
    
    open func tableview(_ tableView:UITableView,tableViewHeaderFooterViewType type:CHGAdapterViewType,viewForHeaderInSection section:NSInteger) -> UIView? {
        //获取headerFooter的Item 数据
        let headerFooterData:Any? = self.headerFooterDataWithType(type: type, section: section)
        if headerFooterData == nil {
            return nil
        }
        guard let headerFooterClass:AnyClass =
            type == CHGAdapterViewType.HeaderType ? self.obtainHeaderClassWithHeader(headerFooterData!, tableView: tableView, viewForHeaderInSection: section)
                :
                self.obtainFooterClassWithFooter(headerFooterData!, tableView: tableView, viewForFooterInSection: section) else { return nil }
        
        let classAllName = NSStringFromClass(headerFooterClass)
        
        var view = tableView.dequeueReusableHeaderFooterView(withIdentifier: classAllName as String)
        if view == nil {
            if Utils.fileIsExit(moduleName: Utils.getModuleName(anyClass: headerFooterClass), fileName: Utils.getShortClassName(anyClass: headerFooterClass)) {
                tableView.register(UINib(nibName: Utils.getShortClassName(anyClass: headerFooterClass),
                                         bundle: Utils.getBundle(anyClass: headerFooterClass)),
                                   forHeaderFooterViewReuseIdentifier: classAllName)
            } else {
                tableView.register(headerFooterClass, forHeaderFooterViewReuseIdentifier: classAllName)
            }
            view = tableView.dequeueReusableHeaderFooterView(withIdentifier: classAllName)
        }
        
        let view_:CHGTableViewHeaderFooterView = view as! CHGTableViewHeaderFooterView
        //        view_.eventTransmissionBlock = tableView.eventTransmissionBlock
        //        view_.headerFooter(section: section, tableView: tableView, data: headerFooterData!, type: type,eventTransmissionBlock: tableView.eventTransmissionBlock)
        view_.headerFooter(for: section, in: tableView, model: headerFooterData!, type: type, eventTransmissionBlock: tableView.eventTransmissionBlock)
        return view_
    }
    
    open func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if view is CHGTableViewHeaderFooterView {
            //            (view as! CHGTableViewHeaderFooterView).headerFooterViewWillAppearWithType(type: CHGAdapterViewType.HeaderType)
            (view as! CHGTableViewHeaderFooterView).headerFooterViewWillAppear(with: .HeaderType)
        }
    }
    
    open func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell is CHGTableViewCell {
            (cell as! CHGTableViewCell).cellWillAppear()
        }
    }
    
    open func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        if view is CHGTableViewHeaderFooterView {
            //            (view as! CHGTableViewHeaderFooterView).headerFooterViewWillAppearWithType(type: CHGAdapterViewType.FooterType)
            (view as! CHGTableViewHeaderFooterView).headerFooterViewWillAppear(with: .FooterType)
        }
    }
    
    open func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        if view is CHGTableViewHeaderFooterView {
            //            (view as! CHGTableViewHeaderFooterView).headerFooterViewDidDisAppearWithType(type: CHGAdapterViewType.HeaderType)
            (view as! CHGTableViewHeaderFooterView).headerFooterViewDidDisAppear(with: .HeaderType)
        }
    }
    
    open func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell is CHGTableViewCell {
            (cell as! CHGTableViewCell).cellDidDisappear()
        }
    }
    
    open func tableView(_ tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int) {
        if view is CHGTableViewHeaderFooterView {
            //            (view as! CHGTableViewHeaderFooterView).headerFooterViewDidDisAppearWithType(type: CHGAdapterViewType.FooterType)
            (view as! CHGTableViewHeaderFooterView).headerFooterViewDidDisAppear(with: .FooterType)
        }
    }
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: self.tableViewDeselectRowAtIndexPathAnimation)
        if tableView.tableViewDidSelectRowBlock != nil {
            tableView.tableViewDidSelectRowBlock!(tableView,indexPath,self.cellDataWithIndexPath(indexPath,tableView: tableView)!)
        }
    }
    
    @available(iOS 2.0, *)
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let tableView:UITableView = scrollView as! UITableView
        guard tableView.scrollListener?.scrollViewDidScrollBlock != nil else {
            return
        }
        tableView.scrollListener?.scrollViewDidScrollBlock!(scrollView)
    }
    
    @available(iOS 3.2, *)
    open func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let tableView:UITableView = scrollView as! UITableView
        guard tableView.scrollListener?.scrollViewDidZoomBlock != nil else {
            return
        }
        tableView.scrollListener?.scrollViewDidZoomBlock!(scrollView)
    }
    
    @available(iOS 2.0, *)
    open func scrollViewWillBeginDragging(_ scrollView: UIScrollView){
        let tableView:UITableView = scrollView as! UITableView
        guard tableView.scrollListener?.scrollViewWillBeginDraggingBlock != nil else {
            return
        }
        tableView.scrollListener?.scrollViewWillBeginDraggingBlock!(scrollView)
    }
    
    @available(iOS 5.0, *)
    open func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>){
        let tableView:UITableView = scrollView as! UITableView
        guard tableView.scrollListener?.scrollViewWillEndDraggingBlock != nil else {
            return
        }
        tableView.scrollListener?.scrollViewWillEndDraggingBlock!(scrollView,velocity,targetContentOffset)
    }
    
    @available(iOS 2.0, *)
    open func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let tableView:UITableView = scrollView as! UITableView
        guard tableView.scrollListener?.scrollViewDidEndDraggingBlock != nil else {
            return
        }
        tableView.scrollListener?.scrollViewDidEndDraggingBlock!(scrollView,decelerate)
    }
    
    
    @available(iOS 2.0, *)
    open func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        let tableView:UITableView = scrollView as! UITableView
        guard tableView.scrollListener?.scrollViewWillBeginDeceleratingBlock != nil else {
            return
        }
        tableView.scrollListener?.scrollViewWillBeginDeceleratingBlock!(scrollView)
    }
    
    @available(iOS 2.0, *)
    open func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let tableView:UITableView = scrollView as! UITableView
        guard tableView.scrollListener?.scrollViewDidEndDeceleratingBlock != nil else {
            return
        }
        tableView.scrollListener?.scrollViewDidEndDeceleratingBlock!(scrollView)
    }
    
    
    @available(iOS 2.0, *)
    open func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let tableView:UITableView = scrollView as! UITableView
        guard tableView.scrollListener?.scrollViewDidEndScrollingAnimationBlock != nil else {
            return
        }
        tableView.scrollListener?.scrollViewDidEndScrollingAnimationBlock!(scrollView)
    }
    
    
    @available(iOS 2.0, *)
    open func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        let tableView:UITableView = scrollView as! UITableView
        guard tableView.scrollListener?.viewForZoomingBlock != nil else {
            return nil
        }
        return tableView.scrollListener?.viewForZoomingBlock!(scrollView)
    }
    
    @available(iOS 3.2, *)
    open func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        let tableView:UITableView = scrollView as! UITableView
        guard tableView.scrollListener?.scrollViewWillBeginZoomingBlock != nil else {
            return
        }
        tableView.scrollListener?.scrollViewWillBeginZoomingBlock!(scrollView,view)
    }
    
    @available(iOS 2.0, *)
    open func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        let tableView:UITableView = scrollView as! UITableView
        guard tableView.scrollListener?.scrollViewDidEndZoomingBlock != nil else {
            return
        }
        tableView.scrollListener?.scrollViewDidEndZoomingBlock!(scrollView,view,scale)
    }
    
    
    @available(iOS 2.0, *)
    open func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        let tableView:UITableView = scrollView as! UITableView
        guard tableView.scrollListener?.scrollViewShouldScrollToTopBlock != nil else {
            return scrollView.scrollsToTop
        }
        return (tableView.scrollListener?.scrollViewShouldScrollToTopBlock!(scrollView))!
    }
    
    @available(iOS 2.0, *)
    open func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        let tableView:UITableView = scrollView as! UITableView
        guard tableView.scrollListener?.scrollViewDidScrollToTopBlock != nil else {
            return
        }
        tableView.scrollListener?.scrollViewDidScrollToTopBlock!(scrollView)
    }
    
    @available(iOS 11.0, *)
    open func scrollViewDidChangeAdjustedContentInset(_ scrollView: UIScrollView) {
        let tableView:UITableView = scrollView as! UITableView
        guard tableView.scrollListener?.scrollViewDidChangeAdjustedContentInsetBlock != nil else {
            return
        }
        tableView.scrollListener?.scrollViewDidChangeAdjustedContentInsetBlock!(scrollView)
    }
}

